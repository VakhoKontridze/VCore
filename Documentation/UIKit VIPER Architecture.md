# UIKit Viper Architecture

Package includes templates for developing scenes using a VIPER architecture. Architecture is highly-decoupled, follows modular design, obeys the single-responsibility principle, and is built on the interface communication pattern.

To avoid writing boilerplate for every scene, the project includes `XCode` templates.

## Factory

A factory and a dependency injector that creates a scene and injects all related objects.

`Factory` takes a `viewModel` as parameter if there is a data passed from the previous scene in the navigation. Factory is a non-initializable struct with static factory methods. By default, `Factory` includes a single method, that creates a default instance of the scene.

Since objects are communicating using protocols, some can be swapped out with a non-default implementation. For instance, we can place `Presenter` and `ViewController` in a shared framework, and implement different `Interactor`'s and `Router`'s in two separate apps, subsequently reusing the same scene while only changing endpoints that they connect to and scenes to which we can navigate to. When even just one scene component is replaced, a new method must be added to `Factory`, as it requires a different dependency injection.

## Interface

While not technically an object, this file lists all protocols that explain communication within the objects.

Interface has five protocols:

| Protocol    | Conformance    | Owner          | Ownership |
| :---------- | :------------- | :------------- | :-------- |
| Viewable    | ViewController | Presenter      | unowned   |
| Navigable   | Router         | Presenter      | unowned   |
| Presentable | Presenter      | ViewController | strong    |
| Routable    | Router         | Presenter      | strong    |
| Interactive | Interactor     | Presenter      | strong    |

## ViewController (Viewable + Navigable)

#### Definition

View of the scene.

#### Responsibilities

Responsibilities of the `ViewController` include:

- Initializing and storing views
- Adding them to subviews
- Setting up a layout
- Reconfiguring self and subviews

Responsibilities of the `ViewController` do not include:

- Storing and managing data, as it's entirely taken by a `Presenter`

#### Viewable

`Viewable` protocol is used by `Presenter` for configuring and modifying the view during runtime. Some properties and methods used in the protocol may include:
    
```swift
func setContinueButtonState(to isUserInteractionEnabled: Bool)
func setInfoLabelText(to text: String)
```

#### Navigable

`Navigable` protocol is used by `Router` to perform navigation and presentation of scenes. By default, `Navigable` protocol conforms to `StandardNavigable` protocol—a helper protocol used in all scenes. `StandardNavigable` has a default implementation for `UIViewController`, and thus, additional implementation is required. API of `StandardNavigable` is the following:

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
    
## Presenter (Presentable) ***(Optional)***

#### Definition

The Central object in the scene that controls the logic and binds everything together.

#### Responsibilities

Responsibilities of the `Presenter` include:

- Connecting all scene components
- Communicating with `Router` to trigger navigation towards or presentation of scenes, which in turn communicates with `ViewController`
- Communicating with `Interactor` to fetch data
- Storing the majority of the present in the scene. This includes `viewModel` passed from the previous scene.

Responsibilities of the `Presenter` do not include:

- Importing `UIKit` and managing UI-specific data, unless absolutely necessary

#### Presentable

`Presentable` protocol is used by `ViewController` to notify `Presenter` that an event or an action has occurred. Some properties and methods used in the protocol may include:

```swift
func viewDidLoad()
func didTapContinueButton()
```

## Router (Routable) ***(Optional)***

#### Definition

Navigator of the scene that performs navigation towards and presentation of scenes.

#### Responsibilities

`Router` has access to `ViewController` view `Navigable` protocol, which allows it to access the navigation stack. By default, `Navigable` protocol conforms to `StandardNavigable` protocol.

#### Routable

`Routable` protocol is used by `Presenter` to trigger navigation towards or presentation of scenes. Some methods used in the protocol may include:
    
```swift
func toSomeScene()
func toSomeOtherScene(viewModel: SomeOtherSceneViewModel)
```
    
## Interactor (Interactive) ***(Optional)***

#### Definition

Performs fetch request to remote or local databases.

#### Responsibilities

Responsibilities of the `Interactor` include:

- Calling `Gateway`'s for fetch request. That's why an `Interactive` has a combined protocol body of all the `Gateway`'s it has access to.

Responsibilities of the `Interactor` do not include:

- Performing fetch requests on its own independent of a `Gateway`.

#### Interactive

`Interacive` protocol is used by `Presenter` to perform fetch requests. Some methods used in the protocol may include:

```swift
func fetchSomeData(with parameters: SomeParameters) async throws -> SomeEntity
```

## ViewModel ***(Optional)***

#### Definition

Data passed to the scene from the previous one.

#### Responsibilities

Owned by `Presenter`.

## Model ***(Optional)***

#### Definition

A non-initalizable static object that contains information needed for laying out a `ViewController`.

#### Responsibilities

Object breaks down into 5 sub-objects—`Layout`, `Colors`, `Fonts`, `Animations`, and `Misc`.
