# Tasks

## Table of Contents

- [Intro](#intro)
- [Synchronous vs Asynchronous Methods](#synchronous-vs-asynchronous-methods)
- [Allowing Reetrancy with Cancellation](#allowing-reetrancy-with-cancellation)
- [Avoiding Reetrancy](#avoiding-reetrancy)

## Intro

This document provides examples of `Task` usage.

## Synchronous vs Asynchronous Methods

#### Views

Methods inside views should be synchronous so that they are easier to call from buttons, lifecycle triggers, and various actions. `Task`s should be used within those methods to handle asynchronous code.

```swift
var body: some View {
    Button(
        "Lorem ipsum",
        action: didTapButton
    )
}

private func didTapButton() {
    doSomething()
}

private func doSomething() {}
    Task(operation: { @MainActor in
        await ...
    })
}
```

#### Services and Managers

Methods inside services and managers should be asynchronous by default. Using synchronous methods with `Task`s within them would make throwing errors and delivering them to views for presentation difficult.

```swift
final class SomeService {
    func doSomething() async throws -> ... {
        await ...
    }
}
```

However, synchronous methods can still be used to perform internal or side work.

```swift
final class MusicPlayer {
    func play(_ song: Song) {
        ... // Plays song
        
        ... // Extracts data
        
        Task(operation: { @MainActor in // Extracts album art
            await ...
        })
    }
}
```

## Reetrancy

#### Intro

If method or a block of code has a suspension point, it can be triggered again even before previous work is finished.

#### Not Handling Reetrancy

There are cases when reetrancy doesn't have to be considered. Such as switching between threads without a suspension point.

```swift
extension View {
    func galleryPhotoPicker(
        isPresented: Binding<Bool>,
        onSelect selectionHandler: @escaping @Sendable (Data?) -> Void
    ) -> some View {
        self
            .photosPicker(
                isPresented: isPresented,
                selection: Binding(
                    get: { nil },
                    set: { photoPickerItem in
                        guard let photoPickerItem else { return }

                        photoPickerItem.loadTransferable(
                            type: Data.self,
                            completionHandler: { result in
                                Task(operation: { @MainActor in
                                    let data: Data? = try? result.get()
                                    selectionHandler(data)
                                })
                            }
                        )
                    }
                )
            )
    }
}
```

#### Handling Reetrancy

There are several ways of handling reetrancy:

- Allowing it, as work that's performed can be independent of one another.

- Allowing it, as long as previous work is cancelled.

- Not allowing it, as it causes issues with mutation of the state. There are several strategies that can be employed, and some can even be implemented simultaneously.


## Allowing Reetrancy with Cancellation

#### Single Suspension Point

If work performed within a `Task` can be overridden without any side effects, simple cancellation is sufficient. It's also important to check for cancellation after the suspension point.

```swift
final class MusicPlayer {
    private var fetchAlbumArtTask: Task<Void, Never>?

    func play(_ song: Song) {
        ... // Plays song
        
        ... // Extracts data
        
        fetchAlbumArtTask?.cancel()
        fetchAlbumArtTask = Task(operation: { @MainActor in 
            defer { fetchAlbumArtTask = nil }
        
            let albumArt: Image = await ...
            guard !Task.isCancelled else { return }
            
            ... // Stores album art
        })
    }
}
```

#### Multiple Suspension Points

If there are multiple suspension points, mutation of the state needs to be carefully considered.

Does progress need to be saved after each suspension point, or can it occur in bulk at the very end?

If progress can be saved at the end of the work, the handling is straightforward.

```swift
final class HomeView {
    private var fetchDataTask: Task<Void, Never>?

    var body: some View {
        ...
    }

    private func fetchData() {
        fetchDataTask?.cancel()
        fetchDataTask = Task(operation: { @MainActor in 
            let user: User = await ...
            guard !Task.isCancelled else { return }
            
            let items: [Item] = await ... // Fetches items using the user data
            guard !Task.isCancelled else { return }
            
            self.user = user
            self.items = items
        })
    }
}
```

Otherwise, cleanup work should be considered to avoid garbage or unsafe data.

## Avoiding Reetrancy

#### Disabling Triggers Points

Reetrancy can be avoided by disabling trigger points, such as buttons. When asynchronous work begins, `Task` can be persisted that would prevent button from triggering again.

```swift
struct HomeView: View {
    private var isFetchDataButtonEnabled: Bool {
        fetchDataTask == nil
    }

    @State private var fetchDataTask: Task<Void, Never?

    var body: some View {
        Button(
            "Fetch Data",
            action: didTapFetchDataButton
        )
        .disabled(!isFetchDataButtonEnabled)
    }
    
    private func didTapFetchDataButton() {
        fetchData()
    }
    
    private func fetchData() {
        fetchDataTask = Task(operation: { @MainActor in
            defer { fetchDataTask = nil }
            
            await ...
        })
    }
}
```

#### Early Exits

Reetrancy can be avoided by writing early exists. This is particularly useful when method call can happen from a source whose trigger point cannot be directly disabled.

```swift
struct HomeView: View {
    @State private var fetchDataTask: Task<Void, Never?

    var body: some View {
        ...
    }
    
    private func fetchData() {
        guard fetchDataTask == nil else { return }
    
        fetchDataTask = Task(operation: { @MainActor in
            defer { fetchDataTask = nil }
            
            await ...
        })
    }
}
```
