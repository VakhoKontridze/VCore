# Interactors and Gateways

## Table of Contents

- [Intro](#intro)
- [Gateway Components](#gateway-components)
- [Interactor-Gateway Relationship](#interactor-gateway-relationship)

## Intro

#### Definition

Proposed architecture aims to separate the domain layer (`Gateway`) from the scenes, which the `Interactor` is part of. `Gateway` is a `protocol` that defines a single method by which a fetch request is performed.

#### XCode Templates

To avoid writing boilerplate for every `Gateway`, project includes XCode templates.

## Gateway Components

#### Gateway Protocol

Defines a fetch request interface. `Gateway` should only contain a single method.

#### Parameters

Parameters used for the fetch request. A `struct`, that can conform to `Encodable`.

#### Entity

Entity that's returned from the fetch request. Also a `struct`, that can conform to `Decodable`.

#### Gateway

A specific implementation of a gateway.

## Interactor-Gateway Relationship

Although an `Interactor` in VIP/VIPER is part of the scene, `Gateway`s are not inherently bound to specific scenes. This allows for reusability.

`Usecase`s are omitted, as their responsibility is entirely covered by `Interactor`s.

Relationship between an `Interactor`  and `Gateway` is the following:

```swift
protocol HomeInteractive {
    func updateUserData(with parameters: UpdateUserDataParameters) async throws -> UpdateUserDataEntity
}

struct HomeInteractor: HomeInteractive {
    func updateUserData(with parameters: UpdateUserDataParameters) async throws -> UpdateUserDataEntity {
        try await UpdateUserDataGateway().fetch(with: parameters)
    }
}
```

```swift
protocol UpdateUserDataGatewayProtocol {
    func fetch(with parameters: UpdateUserDataParameters) async throws -> UpdateUserDataEntity
}

struct UpdateUserDataParameters: Encodable {
    ...
}

struct UpdateUserDataEntity: Decodable {
    ...
}

struct UpdateUserDataGateway: UpdateUserDataGatewayProtocol {
    func fetch(with parameters: UpdateUserDataParameters) async throws -> UpdateUserDataEntity {
        ...
    }
}
```

This allows a presenter to perform a fetch request:

```swift
final class HomePresenter<Interactor>: HomePresentable
    where Interactor: HomeInteractive
{
    private let interactor: Interactor
    
    init(
        interactor: Interactor
    ) {
        self.interactor = interactor
    }

    func viewDidLoad() {
        Task(operation: { await self.fetchData() })
    }

    @MainActor
    private func fetchData() async {
        let parameters: UpdateUserDataParameters = .init(...)
    
        do {
            let entity: UpdateUserDataEntity = try await interactor.updateUserData(with: parameters)
            ...
            
        } catch {
            ...
        }
    }
}
```
