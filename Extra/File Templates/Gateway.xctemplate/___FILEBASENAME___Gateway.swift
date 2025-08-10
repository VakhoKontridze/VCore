//  ___FILEHEADER___

import Foundation
import VCore

protocol ___VARIABLE_productName___GatewayProtocol {
    func fetch(with input: ___VARIABLE_productName___GatewayInput) async throws -> ___VARIABLE_productName___GatewayOutput
}

@CodingKeysGeneration
struct ___VARIABLE_productName___GatewayInput: Encodable {
    // ...
}

@CodingKeysGeneration
struct ___VARIABLE_productName___GatewayOutput: Decodable {
    // MARK: Properties
    // ...

    // MARK: Mock
#if DEBUG
    static var mock: Self {
        .init()
    }
#endif
}

struct ___VARIABLE_productName___Gateway: ___VARIABLE_productName___GatewayProtocol {
    func fetch(with input: ___VARIABLE_productName___GatewayInput) async throws -> ___VARIABLE_productName___GatewayOutput {
        FIXME()
    }
}

#if DEBUG

struct Mock___VARIABLE_productName___Gateway: ___VARIABLE_productName___GatewayProtocol {
    func fetch(with input: ___VARIABLE_productName___GatewayInput) async throws -> ___VARIABLE_productName___GatewayOutput {
        .mock
    }
}

#endif
