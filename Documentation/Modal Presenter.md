# Modal Presenter

## Table of Contents

- [Intro](#intro)
- [Usage Example](#usage-example)
- [Simultaneous Presentation](#simultaneous-presentation)
- [Nested Presentation](#nested-presentation)
- [Background Interactions](#background-interactions)
- [Keyboard Responsiveness](#keyboard-responsiveness)
- [Multiple Roots](#multiple-roots)
- [Presentation with Types](#presentation-with-types)

## Intro

#### Description

Modal Presenter is a manager that allows for creating and presentation of custom modals.

Modal Presenter can be used to create custom modals that behave similar to native modals, such as `View.sheet(...)`, `View.fullScreenCover(...)`, `View.alert(...)`, etc.

Modal Presenter is available on all Apple platforms, and is heavily customizable.

```swift
@State private var isPresented: Bool = true

var body: some View {
    ZStack {
        Button("Present") {
            isPresented = true
        }
        .modal(
            link: .window(linkID: "modal"),
            isPresented: $isPresented
        ) { 
            Color.accentColor 
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity) // For `overlay` configuration
    .modalPresenterRoot(root: .window()) // Or declare in `App` on a `WindowScene`-level
}
```

#### Additional Info

Modal Presenter is implemented in `SwiftUI`. Modals do not require a capture list that native modals, like `View.sheet(...)`, do.

Since implementation is written in `SwiftUI`, performance won't be as good as `UIKit` or `AppKit` solutions.

#### Working Products

For additional info on creating working components using Modal Presenter, check out [VComponents](https://github.com/VakhoKontridze/VComponents) library.

## Usage Example

#### Intro

As an example, we can create a modal that slides up from the bottom of the screen and slides down when dismissed.

<img width="350" src="https://github.com/user-attachments/assets/82cd43ed-c275-4537-9ad3-c4030a767fc8">
<img width="350" src="https://github.com/user-attachments/assets/55fa6766-f491-402b-bb66-c1db90234c17">

#### Modal API Usage

```swift
@State private var isPresented: Bool = false

var body: some View {
    ZStack { // [2]
        Button("Present") { 
            isPresented = true 
        }
        .modal( // [4]
            link: .window(linkID: "modal"), // [5]
            isPresented: $isPresented
        ) { 
            Color.accentColor
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity) // For `overlay` configuration // [3]
    .modalPresenterRoot(root: .window()) // [1]
}
```

Model Presenter API has two parts—root and link.

For Modal Presenter to present, update, and dismiss modals, a root must be inserted in view hierarchy [1]. One root can have multiple modal links, even at the same time. There are two types of roots—`overlay` and `window`.

- `overlay` presents modals over current `SwiftUI` context using `View.overlay(...)` modifier. Which means that modals cannot go beyond the frame of the root.

- `window` presents modals in a new `UIWindow`.

You can also have multiple roots, each serving a different purpose. For additional info, refer to "Multiple Roots" section.

In general, root should be declared within `App`, on a `WindowScene` level for better organization and access. For `overlay` root configuration, this also guarantees a maximum frame for all modals.

```swift
@main 
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ...
            }
            .modalPresenterRoot(root: .window())
        }
    }
}
```

However, roots can also be scoped to a specific view as well. One such example would be a `SwiftUI` preview. In this case, it's best to wrap the root view under a container [2] and apply a maximum frame [3], if `overlay` configuration is used.

Once modal API is created (shown below), it can be called [4] similar to native `View.sheet(...)`.

All links require an identifier [5], which must be unique within a root.

#### Modal API Implementation

```swift
extension View {
    func modal<Content>(
        link: ModalPresenterLink, // [1]
        isPresented: Binding<Bool>, // [2]
        @ViewBuilder content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            .modalPresenterLink( // [3]
                link: link, // [4]
                isPresented: isPresented,
                onPresent: { print("PRESENT") }, // [5]
                onDismiss: { print("DISMISS") }, // [6]
            ) {
                Modal(
                    isPresented: isPresented,
                    content: content
                )
            }
    }
}
```

There's no need to expose internal implementation to the clients. A single method is sufficient.

A method must have `link` parameter [1].

Then, a method of presentation is needed to manage modal lifecycle. `Bool` is the simplest solution, but we can also use a type. For additional info, refer to "Presentation with Types" section.

Then, we can declare parameters that are needed for the contents of the modal.

Modal can be linked using `modalPresenterLink(...)` API [3]. It takes `link` as parameter [4]. It also handles present and dismiss lifecycle event handlers [5] [6].

#### Modal Implementation

```swift
struct Modal<Content>: View where Content: View {
    @Environment(\.modalPresenterInterfaceOrientation) private var interfaceOrientation: PlatformInterfaceOrientation // [1]
    @Environment(\.modalPresenterContainerSize) private var containerSize: CGSize // [2]
    @Environment(\.modalPresenterSafeAreaInsets) private var safeAreaInsets: EdgeInsets // [3]

    @Environment(\.modalPresenterPresentationMode) private var presentationMode: ModalPresenterPresentationMode! // [4]

    @Binding private var isPresented: Bool [5]
    @State private var isPresentedInternally: Bool = false [6]

    private let content: () -> Content

    init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.content = content
    }

    var body: some View {
        ZStack {
            Color(uiColor: UIColor.systemBackground)

            content()
                .padding()
        }
        .frame(dimension: 300)
        
        .compositingGroup() // For shadow
        .shadow(
            color: Color.black.opacity(0.15),
            radius: 10
        )

        .offset(y: isPresentedInternally ? 0 : (containerSize.height + 300)/2) // [12]

        .onReceive(presentationMode.presentPublisher, perform: animateIn) // [7]
        .onReceive(presentationMode.dismissPublisher, perform: animateOut) // [9]
        .onReceive(presentationMode.dimmingViewTapActionPublisher, perform: didTapDimmingView) // [13]
    }

    private func didTapDimmingView() {
        isPresented = false // [14]
    }

    private func animateIn() {
        withAnimation(
            .easeInOut(duration: 0.3),
            { isPresentedInternally = true } // [8]
        )
    }

    private func animateOut(
        completion: @escaping () -> Void
    ) {
       withAnimation(
            .easeInOut(duration: 0.3),
            { isPresentedInternally = false }, // [10]
            completion: completion // [11]
        )
    }
}
```

#### Modal Implementation: Environment

Modal frame and lifecycle are managed by the root, and several values are placed within the environment.

Interface orientation can be retrieved via the environment [1].

If `window` `root` type is used, modal will have the real estate of the entire screen. But if `overlay` is used, there's no guarantee. Instead, model will be constrained to the root. It both cases, container size can be retrieved from the environment [2].

Root disables all container safe area insets for better frame handling, so safe area insets must be inserted manually, if needed. Values must be retrieved via the environment [3], as they cannot be read using a `GeometryReader`.

`ModalPresenterPresentationMode` [4] must be used to manage presentation and dismissal events.

#### Modal Implementation: Presentation States

Modal Presenter differentiates between two types of presentation states—internal and external.

External presentation refers to `isPresented` flag [5], which is passed to `modal(...)` from the presenting root view. While internal presentation refers to `isPresentedInternally` flag [6].

When Modal Presenter detects `isPresented` as `true`, it triggers an event [7]. We can intercept it and animate modal content by setting `isPresentedInternally` to `true` [8].

All this could have been implemented with a single flag. Main purpose of this separation is to handle dismiss animations. Dismissing modal from within the component is straightforward. We can animate content out, and set `isPresented` to `false`. Problem arises when dismissing modal from the presenting root view. If `isPresented` is set to `false` before animations are allowed to occur, modal will be instantly removed from the view hierarchy.

With two flags, when Modal Presenter detects `isPresented` as `false`, it triggers an event [9]. We can intercept it, and animate modal content by setting `isPresentedInternally` to `false` [10]. Even though `isPresented` was set to `false` from the presenting root view, modal still remains in the view hierarchy. Once animations finish, we can call the `completion` callback [11], so that the root can remove the modal from the view hierarchy.

#### Modal Implementation: Animation

With the presentation flags established, any animation can be implemented—offset, opacity, etc. In this example, a simple offset animation is used [12].

#### Modal Implementation: Dimming View

Most modals require a dimming view that dims the background and prevents background interactions. Dimming view can be implemented internally. However, if multiple modals are presented simultaneously, dimming views would stack and multiply.

To avoid this, root itself contains a shared dimming view that gets inserted in view hierarchy when at least one modal is presented. It can be customized, or even hidden. By default, dimming view intercepts tap gestures and sends them to the topmost modal [13]. We can intercept it, and dismiss modal by setting `isPresented` to `false` [14].

## Simultaneous Presentation

Modals can be presented simultaneously within the same root.

```swift
@State private var isPresented1: Bool = false
@State private var isPresented2: Bool = false

var body: some View {
    ZStack {
        Button("Present") {
            isPresented1 = true

            Task { @MainActor in
                try await Task.sleep(for: .seconds(1))
                isPresented2 = true
            }
        }
        .modal(
            link: .window(linkID: "modal_1"),
            isPresented: $isPresented1
        ) { 
            Color.red 
        }
        .modal(
            link: .window(linkID: "modal_2"),
            isPresented: $isPresented2
        ) { 
            Color.blue 
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity) // For `overlay` configuration
    .modalPresenterRoot(root: .window())
}
```

## Nested Presentation

Modals can be nested and presented simultaneously within the same root.

```swift
@State private var isPresented1: Bool = false
@State private var isPresented2: Bool = false

var body: some View {
    ZStack {
        Button("Present") {
            isPresented1 = true
                
            Task { @MainActor in
                try await Task.sleep(for: .seconds(1))
                isPresented2 = true
            }
        }
        .modal(
            link: .window(linkID: "modal_1"),
            isPresented: $isPresented1
        ) {
            Color.red
                .modal(
                    link: .window(linkID: "modal_2"),
                    isPresented: $isPresented2
                ) { 
                    Color.blue 
                }
            }
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity) // For `overlay` configuration
    .modalPresenterRoot(root: .window())
}
```

## Background Interactions

Root can be made click-through to allow background interactions behind the modal.

```swift
@State private var isPresented: Bool = false

var body: some View {
    ZStack {
        ScrollView {
            Button("Present") { 
                isPresented = true 
            }
            
            ForEach(0..<100, id: \.self) { i in
                Text("\(i)")
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
            }
        }
        .modal(
            link: .window(linkID: "modal"),
            isPresented: $isPresented,
        ) {
            Color.accentColor
                .onTapGesture { isPresented = false }
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity) // For `overlay` configuration
    .modalPresenterRoot(
        root: .window(),
        appearance: {
            var appearance: ModalPresenterRootAppearance = .init()
            appearance.dimmingViewColor = Color.clear
            appearance.dimmingViewTapAction = .passTapsThrough
            return appearance
        }()
    )
}
```

## Keyboard Responsiveness

#### Customization

Keyboard responsiveness can be customized via `ModalPresenterRootAppearance`.

```swift
var body: some View {
    ...
        .modalPresenterRoot(
            root: .window(),
            appearance: {
                var appearance: ModalPresenterRootAppearance = .init()
                appearance.keyboardResponsivenessStrategy = .offsetByObscuredViewHeight(additionalOffset: 20)
                return appearance
            }()
        )
}
```

#### Default Behavior

Default value of `keyboardResponsivenessStrategy` is `offsetByObscuredViewHeight`, which shifts the root up so that the first responder view is not hidden behind the keyboard.

```swift
@State private var isPresented: Bool = false
@State private var text: String = "Lorem ipsum"

var body: some View {
    ZStack {
        Button("Present") { 
            isPresented = true 
        }
        .modal(
            link: .window(linkID: "modal"),
            isPresented: $isPresented
        ) {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<10, id: \.self) { _ in
                        TextField("", text: $text)
                            .textFieldStyle(.roundedBorder)
                    }
                }
            }
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity) // For `overlay` configuration
    .ignoresSafeArea(isPresented ? .keyboard : []) // Disables keyboard responsiveness for presenting root view
    .modalPresenterRoot(root: .window())
}
```

<img width="350" src="https://github.com/user-attachments/assets/09537dbe-efe5-4835-87b0-bddb07705ee8">

## Multiple Roots

#### Intro

Modal Presenter supports multiple roots. In fact, it's recommended to use them for the best result.

When multiple roots are used, links must specify the `rootID`.

```swift
var body: some View {
    ...
        .modal(
            link: .window(rootID: "containers". linkID: "modal"),
            isPresented: $isPresented,
        ) { 
            ... 
        }
}
```

In `overlay` configuration, root that's injected after another one will always be on top, as `SwiftUI` overlays stack.

In `window` configuration, root with higher `windowLevel` in Appearance is presented at the top.

Generally speaking, we'd want containers, such as—sheets, side bars, and modals—to be at the bottom. Followed by alerts. And lastly, notifications and toasts.

This separation opens up a possibility for customizing roots individually. For instance, notifications root can have transparent and click-through dimming view. 

#### Best Practices

A method can be defined that injects all roots within the application.

```swift
extension View {
    func injectModalPresenterRoots() -> some View {
        self
            .modalPresenterRoot(
                root: .window(rootID: "containers")
            )
            .modalPresenterRoot(
                root: .window(rootID: "alerts")
            )
            .modalPresenterRoot(
                root: .window(rootID: "notifications"),
                appearance: {
                    var appearance: ModalPresenterRootAppearance = .init()
                    appearance.dimmingViewTapAction = .passTapsThrough
                    appearance.dimmingViewColor = Color.clear
                    return appearance
                }()
            )
    }
}
```

This method can be used in `App` on a `WindowScene`-level.

```swift
@main 
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ...
            }
            .injectModalPresenterRoots()
        }
    }
}
```

This method can also be used for `SwiftUI` previews.

```swift
#Preview {
    ZStack {
        ...
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity) // For `overlay` configuration
    .injectModalPresenterRoots()
}
```

#### Compatibility with Apple's Native Modal API - Intro

Modal Presenter API isn't inherently compatible with Apple's native API.

#### Compatibility with Apple's Native Modal API - Overlay Configuration

In `overlay` configuration, roots are simple overlays, while native components are presented over current context. This means that native components will always be on top. However, this can be changed by using roots that are scoped to specific views, and presenting Modal Presenter components from within.

```swift
@State private var isPresented1: Bool = false
@State private var isPresented2: Bool = false

var body: some View {
    Button("Present") {
        isPresented1 = true
            
        Task { @MainActor in
            try await Task.sleep(for: .seconds(1))
            isPresented2 = true
        }
    }
    .sheet(isPresented: $isPresented1) {
        ZStack {
            Color.red
                .modal(
                    link: .overlay(rootID: "containers_within_sheet", linkID: "custom_sheet"),
                    isPresented: $isPresented2
                ) { 
                    Color.blue 
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // For `overlay` configuration
        .modalPresenterRoot(root: .overlay(rootID: "containers_within_sheet"))
    }
}
```

#### Compatibility with Apple's Native Modal API - Window Configuration

In `window` configuration, new windows are stacked based on `windowLevel` parameter, while native components are presented over current context. This means that Modal Presenter components will almost always be on top. However, this can be changed by presenting native components from Modal Presenter components.

```swift
@State private var isPresented1: Bool = false
@State private var isPresented2: Bool = false

var body: some View {
    ZStack {
        Button("Present") {
            isPresented1 = true
            
            Task { @MainActor in
                try await Task.sleep(for: .seconds(1))
                isPresented2 = true
            }
        }
        .modal(
            link: .window(linkID: "custom_sheet"),
            isPresented: $isPresented1,
        ) {
            Color.blue
                .sheet(isPresented: $isPresented2) {
                    Color.red
                }
            }
        )
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity) // For `overlay` configuration
    .modalPresenterRoot(root: .window())
}
```

## Presentation with Types

A secondary `View.modal(...)` method can be implemented to manage presentation with an item, `Error`, etc.

```swift
extension View {
    func modal<Item, Content>(
        link: ModalPresenterLink,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View
        where Content: View
    {
        item.wrappedValue.map { ModalPresenterDataSourceCache.shared.set(link: link, value: $0) }

        let isPresented: Binding<Bool> = .init(
            get: { item.wrappedValue != nil },
            set: { if !$0 { item.wrappedValue = nil } }
        )
        
        return self
            .modalPresenterLink(
                link: link,
                isPresented: isPresented
            ) {
                Modal<Content?>(
                    isPresented: isPresented,
                ) {
                    if let item = item.wrappedValue ?? ModalPresenterDataSourceCache.shared.get(link: link) as? Item {
                        content(item)
                    }
                }
            }
    }
}
```

One thing to keep in mind, is that Modal Presenter doesn't require a capture list. Which means, that if `item` is set to `nil`, content will be blank when modal is being animated out. `ModalPresenterDataSourceCache` can be used to cache and retrieve data sources. Cleanup is automatically performed when modal is dismissed to avoid memory leaks.
