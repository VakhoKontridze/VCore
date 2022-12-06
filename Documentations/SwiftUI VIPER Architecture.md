# SwiftUI VIPER Architecture

## Intro

#### Definition

A backronym for `View`, `Interactor`, `Presenter`, `Entity`, and a `Router`.

Implementation of VIPER presented in this document is highly-decoupled, follows modular design, obeys the single-responsibility principle, and is built on the interface communication pattern.

Decoupled objects are `View`, `Presenter`, `Router`, and `Interactor`. Supporting declarations are `Factory`, `Parameters`, and an `UIModel`. Even though VIPER contains `Entity` (E) in it's name, this implementation of VIPER separates scenes from the domain layer, and instead ties them to `Gateway`s via the CLEAN architecture.

#### Structure

A single scene can be represented as a set of 3 components:

| Protocol    | Conformance    | Owner          | Ownership |
| :---------- | :------------- | :------------- | :-------- |
| Presentable | Presenter      | View           | strong    |
| Routable    | Router         | N/A            | N/A       |
| Interactive | Interactor     | Presenter      | strong    |

#### Demo and XCode Templates

Package contains demo app that demonstrates the architecture.

To avoid writing boilerplate for every scene, project includes `XCode` templates.

## Factory

#### Definition

`Factory`, as the name suggests, is a factory that creates a scene and injects all related objects.

```swift
// MARK: - Home Factory
@MainActor struct HomeFactory {
    // MARK: Initializers
    private init() {}
    
    // MARK: Factory
    static func `default`(parameters: HomeParameters) -> some View {
        HomeView(
            presenter: HomePresenter(
                interactor: HomeInteractor(),
                parameters: parameters
            )
        )
            .modifier(HomeRouter())
    }
    
    static func mock() -> some View {
        HomeView(
            presenter: HomePresenter(
                interactor: HomeMockInteractor(),
                parameters: .mock
            )
        )
            .modifier(HomeRouter())
    }
}
```

`Factory` is a non-initializable `struct` with `static` factory methods. By default, `Factory` includes a single method, `default`, that creates a an instance of the scene.

`Factory` doesn't expose any types to a caller. Only members of the scene that can be exposed (to `public`, for instance, if we are defining a scene in a separate module) are `Factory`, `Parameters`, `protocol`s defined under the interface, and a `Delegate`. If a scene is intended for a cross-module composition (more on that in the Interface section), components can be exposed as well.

#### Parameters

`Factory` can take `Parameters` as an argument, but this step is optional.

#### Mocking

`Factory` contains a method `mock`, which can be used in `SwiftUI` live previews.

```swift
struct HomeViewPreviews: PreviewProvider {
    static var previews: some View {
        CoordinatingNavigationStack(root: {
            HomeFactory.mock()
        })
    }
}
```

## Parameters

#### Definition

`Parameters` encapsulate all the data passed to the scene from previous scene in the navigation stack, or from a scene that modally presents it.

Given a scene:

```swift
struct PostDetailsFactory {
    static func `default`(parameters: HomeParameters) -> some View { ... }
}
```

```swift
@MainActor final class PostDetailsPresenter: PostsPresentable {
    private let parameters: PostDetailsParameters
    
    init(
        ...,
        parameters: PostDetailsParameters
    ) {
        ...
        self.parameters = parameters
    }
}
```

we can define `Parameters` as:

```swift
// MARK: - Post Details Parameters
struct PostDetailsParameters {
    let postID: Int
    
    let showsImages: Bool
    let canRatePost: Bool
}
```

## Interface

#### Definition

While not actually a component, this file lists all `protocol`s that define the communication within the objects.

```swift
// MARK: - Posts Presentable
@MainActor protocol PostsPresentable: ObservableObject, NavigationStackCoordinable, AlertPresentable, ProgressViewPresentable {
    var postParameters: [PostRowViewParameters] { get }
    
    func didLoad()
    
    func didPullToRefresh()
    func didTapPost(parameters: PostRowViewParameters)
}

// MARK: - Posts Routable
protocol PostsRoutable: ViewModifier {}

// MARK: - Posts Interactive
protocol PostsInteractive {
    func fetchPosts() async throws -> PostsEntity
}
```

#### Composition within the Module

Since objects are communicating via `protocol`s, they can be backed up with more than one implementation.

For instance, we can have a scene that has two possible `Interactor`s associated with them, that determine the endpoints that they connect to.

When even just one component is replaced, a new factory method must be added.

Interfaces:

```swift
@MainActor protocol HomePresentable: ObservableObject { ... }

protocol HomeRoutable { ... }

protocol HomeInteractive { ... }
```

Objects:

```swift
struct HomeFactory {
    static func patient(parameters: HomeParameters) -> some View { ... }
    
    static func doctor(parameters: HomeParameters) -> some View { ... }
}

struct HomeParameters { ... }

struct HomeView: View { ... }

@MainActor final class HomePresenter: HomePresentable { ... }

struct HomeRouter: HomeRoutable { ... }

struct HomeInteractor_Patient: HomeInteractive { ... }

struct HomeInteractor_Doctor: HomeInteractive { ... }

struct HomeUIModel { ... }
```

#### Composition across Modules

Alternately, we can declare `protocol`s in a shared module, alongside with `ViewController`, `Presenter`, and `Router` objects, and implement different `Interactor`s in two separate modules, effectively reusing the same scene, while changing endpoints that they connect to.

Interfaces defined in a shared module:

```swift
@MainActor protocol HomePresentable: ObservableObject { ... }

protocol HomeRoutable { ... }

protocol HomeInteractive { ... }
```

Objects defined in a shared module:

```swift
struct HomeFactory {} // No methods, other then mock, are defined here

struct HomeParameters { ... }

struct HomeView: View { ... }

@MainActor final class HomePresenter: HomePresentable { ... }

struct HomeRouter: HomeRoutable { ... }

struct HomeUIModel { ... }
```

Scene in the first module:

```swift
extension HomeFactory {
    static func patient(parameters: HomeParameters) -> some View { ... }
}
```

```swift
struct HomeInteractor_Patient: HomeInteractive { ... }
```

Scene is the second module:

```swift
extension HomeFactory {
    static func doctor(parameters: HomeParameters) -> some View { ... }
}
```

```swift
struct HomeInteractor_Doctor: HomeInteractive { ... }
```
## View

`View` is a view of the scene.

```swift
// MARK: - Home View
struct HomeView<Presenter>: View
    where Presenter: HomePresentable
{
    // MARK: Properties
    @Environment(\.navigationStackCoordinator) private var navigationStackCoordinator: NavigationStackCoordinator?
    @StateObject private var presenter: Presenter
    
    private typealias UIModel = HomeUIModel
    
    @State private var didAppearForTheFirstTime: Bool = false
    
    ...
    
    // MARK: Initializers
    init(
        presenter: @escaping @autoclosure () -> Presenter
    ) {
        self._presenter = .init(wrappedValue: presenter())
    }

    // MARK: Body
    var body: some View {
        ZStack(content: {
            canvas
            contentView
        })
            .onFirstAppear(didAppear: $didAppearForTheFirstTime, perform: { presenter.navigationStackCoordinator = navigationStackCoordinator })
            .standardNavigationTitle("Home")
            .alert(parameters: $presenter.alertParameters)
            .progressView(parameters: presenter.progressViewParameters)
    }
    
    private var canvas: some View {
        UIModel.Colors.background.ignoresSafeArea()
    }
    
    private var contentView: some View {
        EmptyView()
    }
    
    ...
}
```
Responsibilities of the `View` include:

- Creating subviews
- Interacting with `Presenter` to notify that an event or an action has occurred.
- Interfacing with values stored in environment, and passing them to `Presenter`, such as `NSManagedObjectContext`

Responsibilities of the `View` do not include:

- Storing and managing data, as it's entirely taken by a `Presenter`

## Presenter (Presentable)

#### Definition

`Presenter` is a central object of the scene that controls the business logic and connects everything together.

```swift
// MARK: - Home Presenter
@MainActor final class HomePresenter<Interactor>: HomePresentable
    where Interactor: HomeInteractive
{
    // MARK: Properties
    private let interactor: Interactor
    private let parameters: HomeParameters
    
    // MARK: Initializers
    init(
        interactor: Interactor,
        parameters: HomeParameters
    ) {
        self.interactor = interactor
        self.parameters = parameters
    }

    // MARK: Presentable
    var navigationStackCoordinator: NavigationStackCoordinator?
    @Published var alertParameters: AlertParameters?
    @Published var progressViewParameters: ProgressViewParameters?
    
    func viewDidLoad() { ... }
    
    func didTapContinueButton() { ... }
    
    ...
}
```

Responsibilities of the `Presenter` include:

- Connecting all components
- Communicating with `Router` to trigger navigation towards and presentation of scenes. This occurs via updating `NavigationPath` in `NavigationStackCoordinator`.
- Communicating with `Interactor` to interact with the databases
- Storing and managing data. This includes `Parameters` passed from the previous scene.

Responsibilities of the `Presenter` do not include:

- Importing `SwiftUI` to perform UI work

#### Presentable

`Presentable` `protocol` is used by `View` to access data, or to notify `Presenter` that an event or an action has occurred.

## Router (Routable)

#### Definition

`Router` is a wireframe/navigator of the scene that performs navigation towards and presentation of scenes.

```swift
// MARK: - ___VARIABLE_productName___ Router
struct ___VARIABLE_productName___Router: ___VARIABLE_productName___Routable {
    func body(content: Content) -> some View {
        content
            .navigationDestination(
                for: AccountInfoParameters.self,
                destination: { AccountInfoFactory.default(parameters: $0) }
            )
    }
}
```

Unlike it's `UIKit` counterpart, `SwiftUI`'s router is not responsible for the presentation of scenes, as it's done by the `View`.

`Router` is embedded inside the `View` as a `ViewModifier`, which allows it to create `navigationDestination(for:destination:)` modifiers. `Router` primarily works off of `NavigationStackCoordinator`, an `ObservableObject` placed in the environment of by `CoordinatingNavigationStack`. This allows `Router` to catch `Parameters` passed by `Presenter`, and to create navigation links. This is why, most of the time, `Routable` `protocol` has no body. Navigation can be initiated via `Presenter`:

```swift
navigationStackCoordinator?.path.append(AccountInfoFactory(...))
```

#### Routable

A typealias to `ViewModifier`. `Routable` protocol defines methods that trigger navigation towards scenes.

## Interactor (Interactive)

#### Definition

`Interactor` performs fetch request to remote or local databases.

```swift
// MARK: - Home Interactor
struct HomeInteractor: HomeInteractive {
    func updateUserData(with parameters: UpdateUserDataGatewayParameters) async throws -> UpdateUserDataEntity { ... }
}
```

`Interactor` calls fetch request via `Gateway`, but performs no fetches on its own.

#### Interactive

`Interactive` `protocol` is used by `Presenter` to perform fetch requests.

## UI Model

#### Definition

`UI Model` is a non-initializable `static` `struct` that describes UI.

```
// MARK: - Home UI Model
struct HomeUIModel {
    // MARK: Initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        // MARK: Properties
        static var imageViewDimension: CGFloat { 50 }
        static var titleLabelSpacing: CGFloat { 10 }
        static var primaryButtonMarginHor: CGFloat { 20 }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Colors
    struct Colors {
        // MARK: Properties
        static var background: UIColor { .init(.systemBackground) }
        
        static var titleLabel: UIColor { .init(.label) }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Fonts
    struct Fonts {
        // MARK: Properties
        static var titleLabel: Font { Font.system(size: 14) }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Animations
    struct Animations {
        // MARK: Properties
        static var appear: Animation { .easeInOut(duration: 0.25) }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Misc
    struct Misc {
        // MARK: Properties
        static var submitLabel: SubmitLabel { .done }
        
        // MARK: Initializers
        private init() {}
    }
}
```
