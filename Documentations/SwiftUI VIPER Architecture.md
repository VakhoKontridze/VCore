# SwiftUI VIPER Architecture

A backronym for `View`, `Interactor`, `Presenter`, `Entity`, and `Router`.

Architecture is highly-decoupled, follows modular design, obeys the single-responsibility principle, and is built on the interface communication pattern.

Decoupled declarations discussed within this variation are—`View`, `Presenter`, `Router`, and `Interactor`. Supporting declarations are—`Factory`, `Parameters`, and `UIModel`. Even though VIPER contains `Entity` (E), this implementation of VIPER separates scenes from a database layer, and instead ties them to Gateways via CLEAN architecture.

Package contains demo app that demonstrates this architecture.

To avoid writing boilerplate for every scene, the project includes `XCode` templates.

## Factory

A factory and a dependency injector that creates a scene and injects all related objects.

Factory is a non-initializable `struct` with `static` factory methods. By default, `Factory` includes two method, that create a `default` and `mock` instances of the scene.

`Factory` takes `Parameters` as argument if there is data to be passed from the presenting scene. If not, empty `Parameters` object should not be removed, as it's used by a `Router` for identifying which scenes it navigates to using ``navigationDestination(for:destination:)` modifier. 

Since objects are communicating via protocols, they can be swapped out with a non-default implementations. For instance, we can declare protocols in a shared framework, alongside with `View` and `Presenter` objects, and implement different `Interactor`s and `Router`s in two separate apps, effectively reusing the same scene while only changing endpoints that they connect to, and scenes to which they can navigate. When even just one component is replaced, a new factory method must be added, as it requires a different dependency injection.

## Parameters

#### Definition

Data passed to the scene from the previous scene.

#### Responsibilities

None. Owned by `Presenter`.

## Interface

While not technically a component, this file lists all protocols that explain communication within the objects.

There are five protocols that explain the communication:

| Protocol    | Conformance    | Owner          | Ownership |
| :---------- | :------------- | :------------- | :-------- |
| Presentable | Presenter      | View           | strong    |
| Routable    | Router         | -              | N/A       |
| Interactive | Interactor     | Presenter      | strong    |

## View

#### Definition

View of the scene.

#### Responsibilities

Responsibilities of the `View` include:

- Creating and configuring subviews
- Interfacing with `Presenter` to access reactive data, or to call methods
- Interfacing with values stored in environment, and passing them off to `Presenter`, such as `NSManagedObjectContext

Responsibilities of the `View` do not include:

- Storing and managing data, as it's entirely taken by a `Presenter`
    
## Presenter (Presentable)

#### Definition

The Central object in the scene that controls the business logic and binds everything together.

#### Responsibilities

Responsibilities of the `Presenter` include:

- Connecting all components
- Communicating with `Router` to trigger navigation towards or presentation of scenes. This occurs via updating `NavigationPath` in `NavigationStackCoordinator`.
- Communicating with `Interactor` to interact with databases
- Storing and managing data. This includes `Parameters` passed from the previous scene.

Responsibilities of the `Presenter` do not include:

- Importing `UIKit` to perform UI work, such as subview creating and layout management

#### Presentable

`Presentable` protocol is used by `View` to access data, or to notify `Presenter` that an event or an action has occurred. Some properties and methods declared in protocol are:

```swift
/*@Published*/ var title: String { get set }

func didAppear()
func didTapContinueButton()
```

## Router (Routable) ***(Optional)***

#### Definition

A wireframe/navigator of the scene that performs navigation towards scenes.

Unlike it's `UIKit` counterpart, `SwiftUI`'s router is not responsible for the presentation of scenes, as it's done by the `View`.

#### Responsibilities

`Router` is embedded inside the `View` as a `ViewModifier`, which allows it to create `navigationDestination(for:destination:)` modifiers.

`Router` primarily works off of `NavigationStackCoordinator`, an `ObservableObject` placed in the environment of by `CoordinatingNavigationStack`. This allows `Router` to catch `Parameters` passed by `Presenter`, and to create navigation links.

#### Routable

A typealias to `ViewModifier`. `Routable` protocol defines methods that trigger navigation towards scenes.
    
## Interactor (Interactive) ***(Optional)***

#### Definition

Performs fetch request to remote or local databases.

#### Responsibilities

Responsibilities of the `Interactor` include:

- Calling `Gateway`s for fetch request. That's why an `Interactive` has a combined protocol body of all the `Gateway`s it has access to.

Responsibilities of the `Interactor` do not include:

- Performing fetch requests on its own independent of `Gateway`s.

#### Interactive

`Interactive` protocol is used by `Presenter` to perform fetch requests. Some methods declared in protocol are:

```swift
func fetchSomeData(with parameters: SomeParameters) async throws -> SomeEntity
```

## UI Model ***(Optional)***

#### Definition

A non-initalizable `static` model that describes UI.

#### Responsibilities

Object breaks down constants into 5 sub-objects—`Layout`, `Colors`, `Fonts`, `Animations`, and `Misc`.
