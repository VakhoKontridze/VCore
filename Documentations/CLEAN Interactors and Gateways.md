# CLEAN Interactors and Gateways

## Intro

#### Definition

Proposed architecture aims to separate the domain layer (`Gateway`) from the scenes, which the `Interactor` is part of. `Gateway` is a `protocol` defines a single method by which a fetch request is performed.

#### XCode Templates

To avoid writing boilerplate for every `Gateway`, project includes XCode templates.

## Gateway Components

#### Gateway (Protocol)

Defines a fetch request interface. `Gateway` should only contain a single method.

#### Gateway Parameters

Parameters used for the fetch request. A `struct`, that can conform to `Encodable`.

#### Entity

Entity that's returned from the fetch request. Also a `struct`, that can conform to `Decodable`.

#### Gateway (Object)

A specific implementation of a gateway.

## Interactor-Gateway Relationship

Although an `Interactor` in VIP/VIPER is part of the scene, `Gateway`s are not inherently bound to specific scenes.



This design choice follows CLEAN architecture. But `UseCase`s as omitted, as their responsibility is entirely covered by `Interactor`s.

Relationship between an `Interactor`  and `Gateway` is the following:

```swift
protocol HomeInteractive {
    func updateUserData(with parameters: UpdateUserDataGatewayParameters) async throws -> UpdateUserDataEntity
}

struct HomeInteractor: HomeInteractive {
    func updateUserData(with parameters: UpdateUserDataGatewayParameters) async throws -> UpdateUserDataEntity {
        try await UpdateUserDataNetworkGateway().fetch(with: parameters)
    }
}
```

```swift
protocol UpdateUserDataGateway {
    func fetch(with parameters: UpdateUserDataGatewayParameters) async throws -> UpdateUserDataEntity
}

struct UpdateUserDataNetworkGateway: UpdateUserDataGateway {
    func fetch(with parameters: UpdateUserDataGatewayParameters) async throws -> UpdateUserDataEntity {
        // ...
    }
}
```
