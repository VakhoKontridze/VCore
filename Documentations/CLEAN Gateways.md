# CLEAN Gateways

Protocol that defines a method by which a single fetch request is performed to a relational database—either remote or local.

To avoid writing boilerplate for every gateway, the project includes `XCode` templates.

## Gateway Components

#### Gateway

Defines a fetch request interface. `Gateway` should only contain a single method.

#### Gateway Parameters

Parameters used for the fetch request. A `struct`, that can conform to `Encodable`.

#### Entity

Entity that's returned from the fetch request. Also a `struct`, that can conform to `Decodable`.

#### _ Gateway

A specific implementation of a gateway. To differentiate the gateways from one another, a prefix is used. For instance, `UpdateUserDataNetworkGateway` or `UpdateUserDataCoreDataGateway`.

## Interactor-Gateway Relationship

Although an `Interactor` in VIP/VIPER is part of the scene, Gateways are not inherently bound to specific scenes.

This design choice follows CLEAN architecture. But `UseCase`'s as ommited, as their responsibility is entirely covered by `Interactor`'s.

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
