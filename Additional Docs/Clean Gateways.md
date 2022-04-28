# Clean Gateways

Protocol that defines a method by which a single fetch request is performed to a relational database—either remote or local.

To avoid writing boilerplate for every gateway, the project includes `XCode` templates.

## Gateway Components

#### Gatewayable

Defines an interface by which a fetch request can occur. `Gateway` should only contain a single method.

#### Parameters

Parameters used for the fetch request. A struct, that can conform to `Encodable`.

#### Entity

Entity that's returned from the fetch request. Also a struct, that can conform to `Decodable`.

#### _ Gateway

A specific implementation of a gateway. To differentiate the gateways from one another, a prefix is used. For instance, `UpdateUserDataNetworkGateway` or `UpdateUserDataCoreDataGateway`.

## Interactor-Gateway Relation

Although an `Interactor` component in VIPER is part of the scene, Gateways are not bound to specific scenes.

This design choice follows CLEAN architecture. But I am not using `UseCase`'s as their responsibility is entirely covered by `Interactor`'s.

Relation between an `Interactor`  and `Gateway` is the following:

```swift
protocol UpdateUserDataGatewayable {
    func fetch(with parameters: UpdateUserDataParameters) async throws -> UpdateUserDataEntity
}

struct UpdateUserDataNetworkGateway: UpdateUserDataGatewayable {
    func fetch(with parameters: UpdateUserDataParameters) async throws -> UpdateUserDataEntity {
        // Implementation
    }
}
```

```swift
protocol HomeInteractive {
    func updateUserData(with parameters: UpdateUserDataParameters) async throws -> UpdateUserDataEntity
}

struct HomeInteractor: HomeInteractive {
    func updateUserData(with parameters: UpdateUserDataParameters) async throws -> UpdateUserDataEntity {
        try await UpdateUserDataNetworkGateway().fetch(with: parameters)
    }
}
```
