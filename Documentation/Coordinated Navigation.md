# Coordinated Navigation

## Table of Contents

- [Intro](#intro)
- [Coordinated Navigation](#coordinated-navigation)

## Intro

This document provides examples of coordinated navigation using native `NavigationStack` API.

## Coordinated Navigation

#### Navigation Coordinator

We can define a top-level `NavigationCoordinator` in the app. It will have `Route`, `Destination`, and `Path` as sub-types. `NavigationCoordinator` will contain a single property, a `route`, which we will then use from the `App`.

```swift
@MainActor
@Observable
final class NavigationCoordinator {
    var route: Route = .home(HomeParameters())

    init() {}

    enum Route {
        case home(HomeParameters)
        
        @MainActor
        @ViewBuilder
        var contentView: some View {
            switch self {
            case .home(let parameters): CoordinatingNavigationStack { HomeView(parameters: parameters) }
            }
        }
    }
        
    enum Destination: Hashable {
        case info(InfoParameters)
        
        @MainActor
        @ViewBuilder
        var contentView: some View {
            switch self {
            case .info(let parameters): InfoView(parameters: parameters)
            }
        }
    }
    
    @MainActor
    @Observable
    final class Path {
        var stack: [Destination] = []
    }
}

struct CoordinatingNavigationStack<Root>: View where Root: View {
    private let root: () -> Root
    @State private var path: NavigationCoordinator.Path = .init()
    
    init(
        @ViewBuilder root: @escaping () -> Root
    ) {
        self.root = root
    }
    
    var body: some View {
        NavigationStack(path: $path.stack) {
            root()
                .navigationDestination(for: NavigationCoordinator.Destination.self) { $0.contentView }
        }
        .environment(\.navigationPath, path)
    }
}

extension EnvironmentValues {
    @Entry var navigationPath: NavigationCoordinator.Path?
}
```

#### Root and Route

We can define `HomeView` as a root in one of the routes.

```swift
struct HomeParameters: Hashable {
#if DEBUG
    static var mock: Self {
        .init()
    }
#endif
}

struct HomeView: View {
    @Environment(\.navigationPath) private var navigationPath: NavigationCoordinator.Path!
    private let parameters: HomeParameters
    
    init(parameters: HomeParameters) {
        self.parameters = parameters
    }
    
    var body: some View {
        Button("Navigate") {
            navigationPath.stack.append(.info(InfoParameters(text: "Lorem ipsum")))
        }
    }
}

#if DEBUG

#Preview {
    CoordinatingNavigationStack {
        HomeView(parameters: .mock)
    }
}

#endif
```

#### Destination

We can define `InfoView` as one of the destinations.

```swift
struct InfoParameters: Hashable {
    let text: String
    
#if DEBUG
    static var mock: Self {
        .init(
            text: "Lorem ipsum"
        )
    }
#endif
}

struct InfoView: View {
    @Environment(\.navigationPath) private var navigationPath: NavigationCoordinator.Path!
    private let parameters: InfoParameters
    
    init( parameters: InfoParameters) {
        self.parameters = parameters
    }
    
    var body: some View {
        VStack {
            Text(parameters.text)
            
            Button("Go Back") {
                navigationPath.stack.removeLast()
            }
        }
    }
}

#if DEBUG

#Preview {
    CoordinatingNavigationStack {
        InfoView(parameters: .mock)
    }
}

#endif
```

#### App

Once navigation system is set up, we can render all roots and destinations from the `App`.

```swift
@main
struct ExampleApp: App {
    @State private var navigationCoordinator: NavigationCoordinator = .init()
    
    var body: some Scene {
        WindowGroup {
            navigationCoordinator.route.contentView
        }
    }
}
```
