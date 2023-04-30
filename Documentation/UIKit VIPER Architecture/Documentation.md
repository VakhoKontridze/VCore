# UIKit VIPER Architecture

## Table of Contents

- [Intro](#intro)
- [Factory](#factory)
- [Parameters](#parameters-1)
- [Interface](#interface)
- [ViewController (Viewable, Navigable)](#viewcontroller-viewable-navigable)
- [Presenter (Presentable)](#presenter-presentable)
- [Router (Routable)](#router-routable)
- [Interactor (Interactive)](#interactor-interactive)
- [UI Model](#ui-model)

## Intro

#### Definition

A backronym for `View`, `Interactor`, `Presenter`, `Entity`, and a `Router`.

Implementation of VIPER presented in this document is highly-decoupled, follows modular design, obeys the single-responsibility principle, and is built on the interface communication pattern.

Decoupled objects are `ViewController`, `Presenter`, `Router`, and `Interactor`. Supporting declarations are `Factory`, `Parameters`, `Delegate`, and an `UIModel`. Even though VIPER contains `Entity` (E) in it's name, this implementation of VIPER separates scenes from the domain layer, and instead ties them to `Gateway`s via the CLEAN architecture.

#### Structure

A single scene can be represented as a set of 5 components:

| Protocol    | Conformance    | Owner          | Ownership |
| :---------- | :------------- | :------------- | :-------- |
| Viewable    | ViewController | Presenter      | unowned   |
| Navigable   | ViewController | Router         | unowned   |
| Presentable | Presenter      | ViewController | strong    |
| Routable    | Router         | Presenter      | strong    |
| Interactive | Interactor     | Presenter      | N/A       |

#### Demo

Package contains demo app that demonstrates the architecture.

#### XCode Templates

To avoid writing boilerplate for every scene, project includes XCode templates.

## Factory

#### Definition

`Factory`, as the name suggests, is a factory that creates a scene and injects all related objects.

```swift
// MARK: - Home Factory
struct HomeFactory {
    // MARK: Initializers
    private init() {}
    
    // MARK: Factory
    static func `default`(parameters: HomeParameters) -> UIViewController {
        let viewController: HomeViewController = .init()
        
        let router: HomeRouter = .init(navigator: viewController)

        let interactor: HomeInteractor = .init()

        let presenter: HomePresenter = .init(
            view: viewController,
            router: router,
            interactor: interactor,
            parameters: parameters
        )

        viewController.presenter = presenter
        
        return viewController
    }
}
```

`Factory` is a non-initializable `struct` with `static` factory methods. By default, `Factory` includes a single method, `default`, that creates a an instance of the scene.

`Factory` doesn't expose any types to a caller. Only members of the scene that can be exposed (to `public`, for instance, if we are defining a scene in a separate module) are `Factory`, `Parameters`, `protocol`s defined under the interface, and a `Delegate`. If a scene is intended for a cross-module composition (more on that in the Interface section), components can be exposed as well.

#### Parameters

`Factory` can take `Parameters` as an argument, but this step is optional.

## Parameters

#### Definition

`Parameters` encapsulate all the data passed to the scene from previous scene in the navigation stack, or from a scene that modally presents it.

Given a scene:

```swift
struct PostDetailsFactory {
    static func `default`(parameters: HomeParameters) -> UIViewController { ... }
}
```

```swift
final class PostDetailsPresenter: PostsPresentable {
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
// MARK: - Posts Viewable
protocol PostsViewable: AnyObject, UIAlertViewable, UIActivityIndicatorViewable { 
    func reloadData()
}

// MARK: - Posts Navigable
protocol PostsNavigable: AnyObject, StandardNavigable {}

// MARK: - Posts Presentable
protocol PostsPresentable { 
    func viewDidLoad()
}

// MARK: - Posts Routable
protocol PostsRoutable { 
    func toPostDetails(parameters: PostDetailsParameters)
}

// MARK: - Posts Interactive
protocol PostsInteractive { 
    func fetchPosts(completion: @escaping (Result<PostsEntity, any Error>) -> Void)
}
```

#### Composition within the Module

Since objects are communicating via `protocol`s, they can be backed up with more than one implementation.

For instance, we can have a scene that has two possible `Interactor`s associated with them, that determine the endpoints that they connect to.

When even just one component is replaced, a new factory method must be added.

Interfaces:

```swift
protocol HomeViewable: AnyObject { ... }

protocol HomeNavigable: AnyObject, StandardNavigable { ... }

protocol HomePresentable { ... }

protocol HomeRoutable { ... }

protocol HomeInteractive { ... }
```

Objects:

```swift
struct HomeFactory {
    static func patient(parameters: HomeParameters) -> UIViewController { ... }
    
    static func doctor(parameters: HomeParameters) -> UIViewController { ... }
}

struct HomeParameters { ... }

final class HomeViewController: UIViewController, HomeViewable, HomeNavigable { ... }

final class HomePresenter: HomePresentable { ... }

struct HomeRouter: HomeRoutable { ... }

struct HomeInteractor_Patient: HomeInteractive { ... }

struct HomeInteractor_Doctor: HomeInteractive { ... }

struct HomeUIModel { ... }
```

#### Composition across Modules

Alternately, we can declare `protocol`s in a shared module, alongside with `ViewController`, `Presenter`, and `Router` objects, and implement different `Interactor`s in two separate modules, effectively reusing the same scene, while changing endpoints that they connect to.

Interfaces defined in a shared module:

```swift
protocol HomeViewable: AnyObject { ... }

protocol HomeNavigable: AnyObject, StandardNavigable { ... }

protocol HomePresentable { ... }

protocol HomeRoutable { ... }

protocol HomeInteractive { ... }
```

Objects defined in a shared module:

```swift
struct HomeFactory {} // No methods are defined here

struct HomeParameters { ... }

final class HomeViewController: UIViewController, HomeViewable, HomeNavigable { ... }

final class HomePresenter: HomePresentable { ... }

struct HomeRouter: HomeRoutable { ... }

struct HomeUIModel { ... }
```

Scene in the first module:

```swift
extension HomeFactory {
    static func patient(parameters: HomeParameters) -> UIViewController { ... }
}
```

```swift
struct HomeInteractor_Patient: HomeInteractive { ... }
```

Scene is the second module:

```swift
extension HomeFactory {
    static func doctor(parameters: HomeParameters) -> UIViewController { ... }
}
```

```swift
struct HomeInteractor_Doctor: HomeInteractive { ... }
```

#### Delegation

Additionally, if a scene requires delegation, a delegate can be passed to a `Factory`.

```swift
protocol ItemPickerDelegate: AnyObject {
    func itemPickerDidSelectItems(at indexes: [Int])
}
```

```swift
struct ItemPickerFactory {
    static func `default`(
        parameters: ItemPickerParameters,
        delegate: some ItemPickerDelegate
    ) -> UIViewController { ... }
}
```

```swift
final class ItemPickerPresenter {
    private let parameters: ItemPickerParameters
    private unowned let delegate: any ItemPickerDelegate
    
    init(
        ...,
        parameters: PostDetailsParameters,
        delegate: some ItemPickerDelegate
    ) {
        ...
        self.parameters = parameters
        self.delegate = delegate
    }
}
```

## ViewController (Viewable, Navigable)

#### Definition

`ViewController` is a view of the scene.

```swift
// MARK: - Home ViewController
final class HomeViewController: UIViewController, HomeViewable, HomeNavigable {
    // MARK: Subviews
    ...

    // MARK: Properties
    var presenter: (any HomePresentable)!
    
    private typealias UIModel = HomeUIModel
    
    ...

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    ...

    // MARK: Setup
    private func setUp() {
        setUpView()
        addSubviews()
        setUpLayout()
        setUpNavigationBar()
    }
    
    private func setUpView() { ... }

    private func addSubviews() { ... }

    private func setUpLayout() { ... }
    
    private func setUpNavigationBar() { ... }

    // MARK: Viewable
    func setInfoText(to text: String) { ... }
    
    func setContinueButtonInteraction(to isUserInteractionEnabled: Bool) { ... }
    
    ...

    // MARK: Navigable
    ...
}
```

Responsibilities of the `ViewController` include:

- Initializing and storing subviews
- Adding subviews to the view hierarchy
- Setting up a layout
- Reconfiguring self and subviews
- Interacting with `Presenter` to notify that an event or an action has occurred.

Responsibilities of the `ViewController` do not include:

- Storing and managing data, as it's entirely taken by a `Presenter`

#### Viewable

`Viewable` `protocol` is used by a `Presenter` for configuring and modifying it.

#### Navigable

`Navigable` `protocol` is used by a `Router` to perform navigation and presentation of scenes. A keyword here is "scenes", as presentation of non-scene views—such as alerts, popups, or animatable views—should be handled between `View` and `Presenter`.

By default, `Navigable` `protocol` conforms to `StandardNavigable`—a helper `protocol` used by all scenes, that's defined within the `VCore` library.
    
## Presenter (Presentable)

#### Definition

`Presenter` is a central object of the scene that controls the business logic and connects everything together.

```swift
// MARK: - Home Presenter
final class HomePresenter<View, Router, Interactor>: HomePresentable
    where
        View: HomeViewable,
        Router: HomeRoutable,
        Interactor: HomeInteractive
{
    // MARK: Properties
    private unowned let view: View
    private let router: Router
    private let interactor: Interactor
    private let parameters: HomeParameters
    
    ...

    // MARK: Initializers
    init(
        view: View,
        router: Router,
        interactor: Interactor,
        parameters: HomeParameters
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.parameters = parameters
    }

    // MARK: Presentable
    func viewDidLoad() { ... }
    
    func didTapContinueButton() { ... }
    
    ...
}
```

Responsibilities of the `Presenter` include:

- Connecting all components
- Communicating with `ViewController` to trigger view configuration and other changes
- Communicating with `Router` to trigger navigation towards and presentation of scenes, which in turn communicates with `ViewController`
- Communicating with `Interactor` to interact with the databases
- Storing and managing data. This includes `Parameters` passed from the previous scene.

Responsibilities of the `Presenter` do not include:

- Importing `UIKit` to perform UI work, such as subview creation and a layout management

#### Presentable

`Presentable` `protocol` is used by `ViewController` to access data, or to notify `Presenter` that an event or an action has occurred.

## Router (Routable)

#### Definition

`Router` is a wireframe/navigator of the scene that performs navigation towards and presentation of scenes.

```swift
// MARK: - Home Router
final class HomeRouter<Navigator>: HomeRoutable
    where Navigator: HomeNavigable
{
    // MARK: Properties
    private unowned let navigator: Navigator
    
    ...

    // MARK: Initializers
    init(
        navigator: Navigator
    ) {
        self.navigator = navigator
    }

    // MARK: Routable
    func toAccountInfo(parameters: AccountInfoParameters) { 
        navigator.push(AccountInfoFactory.default(parameters: parameters))
    }

    func presentSideMenu(
        parameters: SideMenuParameters,
        delegate: some SideMenuDelegate
    ) { ... }
    
    func dismissSideMenu() { ... }
    
    ...
}
```

`Router` has access to `ViewController` via `Navigable` `protocol`. By default, `Navigable` `protocol` inherits `StandardNavigable` `protocol`, which allows it to access the common methods of `UINavigationController`, without exposing the type.` StandardNavigable` has a default implementation for `UIViewController`, and thus, no additional implementation is required. This is why, most of the time, `Routable` `protocol` has no body.

```swift
protocol StandardNavigable {
    func push(_ viewController: UIViewController, animated: Bool)
        
    ...
}

extension StandardNavigable where Self: UIViewController {
    func push(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    ...
```

`Router` is also responsible for determining which method of `Factory` it calls.

#### Routable

`Routable` `protocol` is used by `Presenter` to trigger navigation towards and presentation of scenes.
    
## Interactor (Interactive)

#### Definition

`Interactor` performs fetch request to remote or local databases.

```swift
// MARK: - Home Interactor
struct HomeInteractor: HomeInteractive {
    func fetchPosts(completion: @escaping (Result<PostsEntity, any Error>) -> Void) { ... }
}
```

`Interactor` calls fetch request via `Gateway`, but performs no fetches on its own.

#### Interactive

`Interactive` `protocol` is used by `Presenter` to perform fetch requests.

## UI Model

#### Definition

`UI Model` is a non-initializable `static` `struct` that describes UI.

```swift
// MARK: - Home UI Model
struct HomeUIModel {
    // MARK: Initializers
    private init() {}
    
    // MARK: Layout
    struct Layout {
        // MARK: Properties
        static var imageViewDimension: CGFloat { 50 }
        static var stackViewSpacing: CGFloat { 10 }
        static var primaryButtonMarginHor: CGFloat { 20 }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Colors
    struct Colors {
        // MARK: Properties
        static var background: UIColor { .systemBackground }
        
        static var titleText: UIColor { .label }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Fonts
    struct Fonts {
        // MARK: Properties
        static var titleText: UIFont { .systemFont(ofSize: 14) }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Animations
    struct Animations {
        // MARK: Properties
        static var appearDuration: TimeInterval { 0.25 }
        static var appearDelay: TimeInterval { 0 }
        static var appearOptions: UIView.AnimationOptions { .curveEaseInEaseOut }
        
        // MARK: Initializers
        private init() {}
    }

    // MARK: Misc
    struct Misc {
        // MARK: Properties
        static var returnKeyType: UIReturnKeyType { .done }
        
        // MARK: Initializers
        private init() {}
    }
}
```
