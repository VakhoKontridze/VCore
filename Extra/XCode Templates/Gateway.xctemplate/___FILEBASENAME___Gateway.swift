//  ___FILEHEADER___

import Foundation
import VCore

// MARK: - ___VARIABLE_productName___ Gateway Protocol
protocol ___VARIABLE_productName___GatewayProtocol {
    func fetch(with input: ___VARIABLE_productName___GatewayInput) async throws -> ___VARIABLE_productName___GatewayOutput
}

// MARK: - ___VARIABLE_productName___ Gateway Input
@CodingKeysGeneration
struct ___VARIABLE_productName___GatewayInput: Encodable {
    // ...
}

// MARK: - ___VARIABLE_productName___ Gateway Output
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

// MARK: - ___VARIABLE_productName___ Gateway
struct ___VARIABLE_productName___Gateway: ___VARIABLE_productName___GatewayProtocol {
    func fetch(with input: ___VARIABLE_productName___GatewayInput) async throws -> ___VARIABLE_productName___GatewayOutput {
        FIXME()
    }
}

// MARK: - Mock ___VARIABLE_productName___ Gateway
struct Mock___VARIABLE_productName___Gateway: ___VARIABLE_productName___GatewayProtocol {
    func fetch(with input: ___VARIABLE_productName___GatewayInput) async throws -> ___VARIABLE_productName___GatewayOutput {
        .mock
    }
}

#endif
