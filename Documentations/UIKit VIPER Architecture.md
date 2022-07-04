# UIKit VIPER Architecture

A backronym for `View`, `Interactor`, `Presenter`, `Entity`, and `Router`.

Architecture is highly-decoupled, follows modular design, obeys the single-responsibility principle, and is built on the interface communication pattern.

Decoupled declarations discussed within this variation are—`ViewController`, `Presenter`, `Router`, and `Interactor`. Supporting declarations are—`Factory`, `Parameters`, and `UIModel`. Even though VIPER contains `Entity` (E), this implementation of VIPER separates scenes from a database layer, and instead ties them to Gateways via CLEAN architecture.

Package contains demo app that demonstrates this architecture.

To avoid writing boilerplate for every scene, the project includes `XCode` templates.

## Factory

A factory and a dependency injector that creates a scene and injects all related objects.

Factory is a non-initializable `struct` with `static` factory methods. By default, `Factory` includes a single method, that creates a `default` instance of the scene.

`Factory` takes `Parameters` as argument if there is data to be passed from the presenting scene.

Since objects are communicating via protocols, they can be swapped out with a non-default implementations. For instance, we can declare protocols in a shared framework, alongside with `ViewController` and `Presenter` objects, and implement different `Interactor`s and `Router`s in two separate apps, effectively reusing the same scene while only changing endpoints that they connect to, and scenes to which they can navigate. When even just one component is replaced, a new factory method must be added, as it requires a different dependency injection.

## Parameters ***(Optional)***

#### Definition

Data passed to the scene from the previous scene.

#### Responsibilities

None. Owned by `Presenter`.

## Interface

While not technically a component, this file lists all protocols that explain communication within the objects.

There are five protocols that explain the communication:

| Protocol    | Conformance    | Owner          | Ownership |
| :---------- | :------------- | :------------- | :-------- |
| Viewable    | ViewController | Presenter      | unowned   |
| Navigable   | Router         | Presenter      | unowned   |
| Presentable | Presenter      | ViewController | strong    |
| Routable    | Router         | Presenter      | strong    |
| Interactive | Interactor     | Presenter      | N/A       |

## ViewController (Viewable + Navigable)

#### Definition

View of the scene.

#### Responsibilities

Responsibilities of the `ViewController` include:

- Initializing and storing subviews
- Adding subviews to the view hierarchy
- Setting up a layout
- Reconfiguring self and subviews

Responsibilities of the `ViewController` do not include:

- Storing and managing data, as it's entirely taken by a `Presenter`

#### Viewable

`Viewable` protocol is used by `Presenter` for configuring and modifying the view in runtime. Some properties and methods declared in protocol are:
    
```swift
func setContinueButtonInteraction(to isUserInteractionEnabled: Bool)
func setInfoLabelText(to text: String)
```

#### Navigable

`Navigable` protocol is used by `Router` to perform navigation and presentation of scenes. A keyword here is "scenes", as presentation of non-scene view such as Alert, Popup, or animatable view should be handled within `View`/`Presenter`. By default, `Navigable` protocol conforms to `StandardNavigable` protocol—a helper protocol used by all scenes. `StandardNavigable` has a default implementation for `UIViewController`, and thus, no additional implementation is required. API of `StandardNavigable` is the following:

```swift
protocol StandardNavigable {
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    
    func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    
    func setRoot(to viewController: UIViewController)
}
```
    
## Presenter (Presentable)

#### Definition

The Central object in the scene that controls the business logic and binds everything together.

#### Responsibilities

Responsibilities of the `Presenter` include:

- Connecting all components
- Communication with `ViewController` to trigger view configuration, presentation, and other changes
- Communicating with `Router` to trigger navigation towards or presentation of scenes, which in turn communicates with `ViewController`
- Communicating with `Interactor` to interact with databases
- Storing and managing data. This includes `Parameters` passed from the previous scene.

Responsibilities of the `Presenter` do not include:

- Importing `UIKit` to perform UI work, such as subview creating and layout management

#### Presentable

`Presentable` protocol is used by `ViewController` to access data, or to  notify `Presenter` that an event or an action has occurred. Some properties and methods declared in protocol are:

```swift
func viewDidLoad()
func didTapContinueButton()
```

## Router (Routable) ***(Optional)***

#### Definition

A wireframe/navigator of the scene that performs navigation towards and presentation of scenes.

#### Responsibilities

`Router` has access to `ViewController` via `Navigable` protocol, which allows it to access the common methods of `UINavigationController`. By default, `Navigable` protocol inherits `StandardNavigable` protocol.

#### Routable

`Routable` protocol is used by `Presenter` to trigger navigation towards, or presentation of scenes. Some methods declared in this protocol are:
    
```swift
func toSomeScene()
func toSomeOtherScene(parameters: SomeOtherSceneParameters)
```
    
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

A non-initializable `static` model that describes UI.

#### Responsibilities

Object breaks down constants into 5 sub-objects—`Layout`, `Colors`, `Fonts`, `Animations`, and `Misc`.
