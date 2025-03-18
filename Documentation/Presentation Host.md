# Presentation Host

## Table of Contents

- [Intro](#intro)
- [Usage Example](#usage-example)
- [Simultaneous Presentation](#simultaneous-presentation)
- [Nested Presentation](#nested-presentation)
- [Background Interactions](#background-interactions)
- [Keyboard Responsiveness](#keyboard-responsiveness)
- [Multiple Layers](#multiple-layers)
- [Presentation with Types](#presentation-with-types)

## Intro

#### Description

Presentation Host is a manager that injects a host in view hierarchy for modal presentation.

Presentation Host can be used to create custom modals that behave similar to native modals, such as `View.sheet(...)`, `View.fullScreenCover(...)`, `View.alert(...)`, etc.

Presentation Host is available on all Apple platforms, and is heavily customizable.

```swift
@State private var isPresented: Bool = true

var body: some View {
    ZStack(content: {
        Button(
            "Present",
            action: { isPresented = true }
        )
        .someModal(
            id: "some_modal",
            isPresented: $isPresented,
            content: { Color.accentColor }
        )
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .presentationHostLayer() // Or declare in `App` on a `WindowScene`-level
}
```

#### Additional Info

Presentation Host is implemented in `SwiftUI`. Modals do not require a capture list that native modals, like `View.sheet(...)`, do.

Since implementation is written in `SwiftUI`, performance won't be as good as `UIKit` or `AppKit` solutions.

#### Working Products

For additional info on creating working components using Presentation Host, check out [VComponents](https://github.com/VakhoKontridze/VComponents) library.

## Usage Example

#### Intro

As an example, we can create a modal that slides up from the bottom of the screen and slides down when dismissed.

<img width="350" src="https://github.com/user-attachments/assets/82cd43ed-c275-4537-9ad3-c4030a767fc8">
<img width="350" src="https://github.com/user-attachments/assets/55fa6766-f491-402b-bb66-c1db90234c17">

#### Modal API Usage

```swift
@State private var isPresented: Bool = false

var body: some View {
    ZStack(content: { // [2]
        Button(
            "Present",
            action: { isPresented = true }
        )
        .someModal( // [4]
            id: "some_modal", // [5]
            isPresented: $isPresented,
            content: { Color.accentColor }
        )
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity) // [3]
    .presentationHostLayer() // [1]
}
```

Presentation Host API has two parts—layer and host.

For manager to present, update, and dismiss modals, a layer must be inserted in view hierarchy [1]. All modals presented within that layer can not go beyond its frame.

One layer can have multiple modal instances, even at the same time.

Presentation Host API also supports multiple layers, each serving a different purpose. For additional info, refer to "Multiple Layers" section.

In general, a layer should be declared within `App`, on a `WindowScene` level. This guarantees a maximum frame for all modals.

```swift
@main 
struct SomeApp: App {
    var body: some Scene {
        WindowGroup(content: {
            NavigationStack(root: {
                ...
            })
            .presentationHostLayer()
        })
    }
}
```

However, layers can be scoped to a specific view as well. One such example would be a `SwiftUI` preview. In this case, it's best to wrap the root view under a container [2] and apply a maximum frame [3].

Once modal API is created (shown below), it can be called [4] similar to native `View.sheet(...)`.

All modal instances require an identifier [5], which must be unique.

#### Modal API Implementation

```swift
extension View {
    func someModal<Content>(
        layerID: String? = nil, // [1]
        id: String, // [2]
        isPresented: Binding<Bool>, // [3]
        @ViewBuilder content: @escaping () -> Content
    ) -> some View
        where Content: View
    {
        self
            .presentationHost( // [4]
                layerID: layerID, // [5]
                id: id, // [6]
                isPresented: isPresented,
                onPresent: { print("PRESENT") }, // [7]
                onDismiss: { print("DISMISS") }, // [8]
                content: {
                    SomeModal(
                        isPresented: isPresented,
                        content: content
                    )
                }
            )
    }
}
```

There's no need to expose internal implementation to the clients. A single method is sufficient.

A method must have `layerID` [1] and `id` [2] parameters. Layer takes an `id` parameter, which corresponds to `layerID` from host. By default, the value if `nil`.

Then, a method of presentation is needed to manage modal lifecycle. `Bool` is the simplest solution, but we can also use a type. For additional info, refer to "Presentation with Types" section.

Then, we can declare parameters that are needed for the actual content of the modal.

Modal can be created using `presentationHost(...)` API [4]. Host takes `id` and `layerID` as parameters [5] [6]. It also handles present and dismiss lifecycle and calls event handlers [7] [8].

#### Modal Implementation

```swift
private struct SomeModal<Content>: View where Content: View {
    @Environment(\.presentationHostContainerSize) private var containerSize: CGSize // [1]
    @Environment(\.presentationHostSafeAreaInsets) private var safeAreaInsets: EdgeInsets // [2]

    @Environment(\.presentationHostPresentationMode) private var presentationMode: PresentationHostPresentationMode! // [3]

    @Binding private var isPresented: Bool [4]
    @State private var isPresentedInternally: Bool = false [5]

    private let content: () -> Content

    init(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.content = content
    }

    var body: some View {
        ZStack(content: {
            Color(uiColor: .systemBackground)

            content()
                .padding()
        })
        .frame(dimension: 300)
        
        .compositingGroup() // For shadow
        .shadow(
            color: .black.opacity(0.15),
            radius: 10
        )

        .offset(y: isPresentedInternally ? 0 : (containerSize.height + 300)/2) // [11]

        .onReceive(presentationMode.presentPublisher, perform: animateIn) // [6]
        .onReceive(presentationMode.dismissPublisher, perform: animateOut) // [8]
        .onReceive(presentationMode.dimmingViewTapActionPublisher, perform: didTapDimmingView) // [12]
    }

    private func didTapDimmingView() {
        isPresented = false // [13]
    }

    private func animateIn() {
        withAnimation(
            .easeInOut(duration: 0.3),
            { isPresentedInternally = true } // [7]
        )
    }

    private func animateOut(
        completion: @escaping () -> Void
    ) {
       withAnimation(
            .easeInOut(duration: 0.3),
            { isPresentedInternally = false }, // [9]
            completion: completion // [10]
        )
    }
}
```

#### Modal Implementation: Environment

Modal frames and lifecycle are managed by the layer, and several values are placed within the environment.

Modal is not guaranteed to have the real estate of the entire screen. Instead, it's constrained to the container [1].

Layer disables all container safe area insets for better frame handling. All safe area insets must be inserted manually, if needed. Values must be retrieved via environment [2], as they cannot be retrieved using `GeometryReader`.

`PresentationHostPresentationMode` [3] must be used to manage presentation and dismissal events.

#### Modal Implementation: Presentation States

Presentation Host differentiates between two types of presentation states—internal and external.

External presentation refers to `isPresented` flag [4], which is passed to `someModal(...)` from the presenting root view. While internal presentation refers to `isPresentedInternally` flag [5].

When Presentation Host detects `isPresented` as `true`, it triggers an event [6]. We can intercept it and animate modal content by setting `isPresentedInternally` to `true` [7].

All this could have been implemented with a single flag. Main purpose of the separation is to handle dismiss animations. Dismissing modal from within the component is straightforward. We can animate content out, and set `isPresented` to `false`. Problem arises when dismissing modal from the presenting root view. If `isPresented` is set to `false` before animations are allowed to occur, modal will be instantly removed from the view hierarchy.

With two flags, when Presentation Host detects `isPresented` as `false`, it triggers an event [8]. We can intercept it, and animate modal content by setting `isPresentedInternally` to `false` [9]. Even though `isPresented` was set to `false` from the presenting root view, the modal still remains in the view hierarchy. Once animations finish, we can call the `completion` callback [10], so that the layer can remove the modal from the view hierarchy.

#### Modal Implementation: Animation

With the presentation flags established, any animation can be implemented—offset, opacity, etc. In this example, a simple offset animation is used [11].

#### Modal Implementation: Dimming View

Most modals require a dimming view that dims the background and prevents background interactions. Dimming view can be implemented internally per modal. However, if multiple modals are presented simultaneously, dimming views would stack and multiply.

To avoid this, layer itself contains a shared dimming view that gets inserted in view hierarchy when at least one modal is presented. It can be customized, or even hidden. By default, dimming view intercepts tap gestures and sends them to the topmost modal [12]. We can intercept it, and dismiss modal by setting `isPresented` to `false` [13].

## Simultaneous Presentation

Modals can be presented simultaneously within the same layer.

```swift
@State private var isPresented1: Bool = false
@State private var isPresented2: Bool = false

var body: some View {
    ZStack(content: {
        Button(
            "Present",
            action: {
                isPresented1 = true

                Task(operation: { @MainActor in
                    try? await Task.sleep(seconds: 1)
                    isPresented2 = true
                })
            }
        )
        .someModal(
            id: "some_modal_1",
            isPresented: $isPresented1,
            content: { Color.red }
        )
        .someModal(
            id: "some_modal_2",
            isPresented: $isPresented2,
            content: { Color.blue }
        )
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .presentationHostLayer()
}
```

## Nested Presentation

Modals can be nested and presented simultaneously within the same layer.

```swift
@State private var isPresented1: Bool = false
@State private var isPresented2: Bool = false

var body: some View {
    ZStack(content: {
        Button(
            "Present",
            action: {
                isPresented1 = true
                
                Task(operation: { @MainActor in
                    try? await Task.sleep(seconds: 1)
                    isPresented2 = true
                })
            }
        )
        .someModal(
            id: "some_modal_1",
            isPresented: $isPresented1,
            content: {
                Color.red
                    .someModal(
                        id: "some_modal_2",
                        isPresented: $isPresented2,
                        content: { Color.blue }
                    )
            }
        )
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .presentationHostLayer()
}
```

## Background Interactions

Layer can be made click-through to allow background interactions behind the modal.

```swift
@State private var isPresented: Bool = false

var body: some View {
    ZStack(content: {
        Color.clear
            .contentShape(.rect)
            .onTapGesture(perform: {
                print("Root View Tapped")
            })

        Button(
            "Present",
            action: { isPresented = true }
        )
        .someModal(
            id: "some_modal",
            isPresented: $isPresented,
            content: {
                Color.accentColor
                    .onTapGesture(perform: {
                        print("Modal Tapped")
                    })
            }
        )
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .presentationHostLayer(
        uiModel: {
            var uiModel: PresentationHostLayerUIModel = .init()
            uiModel.dimmingViewColor = Color.clear
            uiModel.dimmingViewTapAction = .passTapsThrough
            return uiModel
        }()
    )
}
```

## Keyboard Responsiveness

#### Customization

Keyboard responsiveness can be customized via `PresentationHostLayerUIModel`.

```swift
var body: some View {
    ...
        .presentationHostLayer(
            uiModel: {
                var uiModel: PresentationHostLayerUIModel = .init()
                uiModel.keyboardObserverSubUIModel.keyboardResponsivenessStrategy = .offsetByObscuredViewHeight(additionalOffset: 20)
                return uiModel
            }()
        )
}
```

#### Default Behavior

Default value of `keyboardResponsivenessStrategy` is `offsetByObscuredViewHeight`, which shifts the layer up so that the first responder view is not hidden behind the keyboard.

```swift
@State private var isPresented: Bool = false
@State private var text: String = "Lorem ipsum"

var body: some View {
    ZStack(content: {
        Button(
            "Present",
            action: { isPresented = true }
        )
        .someModal(
            id: "some_modal",
            isPresented: $isPresented,
            content: {
                ScrollView(content: {
                    VStack(spacing: 20, content: {
                        ForEach(0..<10, id: \.self, content: { _ in
                            TextField("", text: $text)
                                .textFieldStyle(.roundedBorder)
                        })
                    })
                })
            }
        )
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea(isPresented ? .keyboard : []) // Disables keyboard responsiveness for presenting root view
    .presentationHostLayer()
}
```

<img width="350" src="https://github.com/user-attachments/assets/09537dbe-efe5-4835-87b0-bddb07705ee8">

## Multiple Layers

#### Intro

Presentation Host supports multiple layers. In fact, it's recommended to use them for the best result.

When multiple layers are used, each instance of modal must specify the `layerID`.

```swift
var body: some View {
    ...
        .someModal(
            layerID: "containers",
            id: "some_modal",
            isPresented: $isPresented,
            content: { ... }
        )
}
```

Layers stack. Which means, that layer that's injected after another one will always be on top.

Generally speaking, we'd want containers, such as—sheets, side bars, and modals—to be at the bottom. Followed by alerts. And lastly, notifications and toasts.

This separation opens up a possibility for customizing layers individually. For instance, notifications layer can have no dimming view and be click-through.

#### Best Practices

A method can be defined that injects all layers within the application.

```swift
extension View {
    func injectPresentationHostLayers() -> some View {
        self
            .presentationHostLayer(
                id: "containers"
            )
            .presentationHostLayer(
                id: "alerts"
            )
            .presentationHostLayer(
                id: "notifications",
                uiModel: {
                    var uiModel: PresentationHostLayerUIModel = .init()
                    uiModel.dimmingViewTapAction = .passTapsThrough
                    uiModel.dimmingViewColor = Color.clear
                    return uiModel
                }()
            )
    }
}
```

This method can be used in `App` on a `WindowScene`-level.

```swift
@main 
struct SomeApp: App {
    var body: some Scene {
        WindowGroup(content: {
            NavigationStack(root: {
                ...
            })
            .injectPresentationHostLayers()
        })
    }
}
```

This method can also be used for `SwiftUI` previews.

```swift
#Preview(body: {
    ZStack(content: {
        ...
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .injectPresentationHostLayers()
})
```

#### Exceptions

Even though the order of—containers, alerts, and notifications—is generally correct, there are times when it rule needs to be broken. This can be easily achieved by using layers that are scoped to specific views.

```swift
var body: some View {
    ZStack(content: {
        ...
            .obscureModal(
                layerID: "below_containers_home_screen",
                id: "obscure_modal",
                isPresented: $isPresented,
                content: { ... }
            )
            .sideBar(
                layerID: "containers_home_screen",
                id: "side_bar",
                isPresented: $isPresented,
                content: { ... }
            )
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .presentationHostLayer(
        id: "below_containers_home_screen"
    )
    .presentationHostLayer(
        id: "containers_home_screen"
    )
}
```

#### Compatibility with Apple's Native Modal API

Presentation Host API isn't inherently compatible with Apple's native API.

This is due to the fact, that layers are simple overlays. While Apple's native API creates a new presentation context over `UIWindow`/`NSWindow`. This means, that native modal will always be on top of ones developed via Presentation Host API.

In the following example, `View.sheet(...)` will always be on top of `View.customSheet(...)`.

```swift
@State private var isPresented1: Bool = false
@State private var isPresented2: Bool = false

var body: some View {
    ZStack(content: {
        Button(
            "Present",
            action: {
                isPresented1 = true
                
                Task(operation: { @MainActor in
                    try? await Task.sleep(seconds: 1)
                    isPresented2 = true
                })
            }
        )
        .sheet(
            isPresented: $isPresented1,
            content: { Color.red }
        )
        .someModal(
            id: "custom_sheet",
            isPresented: $isPresented2,
            content: { Color.blue }
        )
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .presentationHostLayer()
}
```

In order to achieve the intended behavior, a custom layer needs to be injected within `View.sheet(...)`.

```swift
@State private var isPresented1: Bool = false
@State private var isPresented2: Bool = false

var body: some View {
    Button(
        "Present",
        action: {
            isPresented1 = true
            
            Task(operation: { @MainActor in
                try? await Task.sleep(seconds: 1)
                isPresented2 = true
            })
        }
    )
    .sheet(
        isPresented: $isPresented1,
        content: {
            ZStack(content: {
                Color.red
                    .someModal(
                        layerID: "containers_within_sheet",
                        id: "custom_sheet",
                        isPresented: $isPresented2,
                        content: { Color.blue }
                    )
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .presentationHostLayer(id: "containers_within_sheet")
        }
    )
}
```

## Presentation with Types

A secondary `View.someModal(...)` method can be implemented to manage presentation with an item, `Error`, etc.

```swift
extension View {
    func someModal<Item, Content>(
        layerID: String? = nil,
        id: String,
        item: Binding<Item?>,
        @ViewBuilder content: @escaping (Item) -> Content
    ) -> some View
        where Content: View
    {
        item.wrappedValue.map { PresentationHostDataSourceCache.shared.set(key: id, value: $0) }

        let isPresented: Binding<Bool> = .init(
            get: { item.wrappedValue != nil },
            set: { if !$0 { item.wrappedValue = nil } }
        )
        
        return self
            .presentationHost(
                layerID: layerID,
                id: id,
                isPresented: isPresented,
                content: {
                    SomeModal<Content?>(
                        isPresented: isPresented,
                        content: {
                            if let item = item.wrappedValue ?? PresentationHostDataSourceCache.shared.get(key: id) as? Item {
                                content(item)
                            }
                        }
                    )
                }
            )
    }
}
```

One thing to keep in mind, is that Presentation Host doesn't require a capture list. Which means, that if `item` is set to `nil`, modal content will be blank when modal is being animated out. `PresentationHostDataSourceCache` can be used to cache and retrieve data sources. Cleanup is automatically performed when modal is dismissed to avoid memory leaks.
