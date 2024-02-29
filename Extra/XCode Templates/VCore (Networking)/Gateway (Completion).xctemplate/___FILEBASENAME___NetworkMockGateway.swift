//  ___FILEHEADER___

#if DEBUG

import Foundation

// MARK: - ___VARIABLE_productName___ Network Mock Gateway
struct ___VARIABLE_productName___NetworkMockGateway: ___VARIABLE_productName___Gateway {
    func fetch(with parameters: ___VARIABLE_productName___GatewayParameters) async throws -> ___VARIABLE_productName___Entity {
        completion(.success(.mock))
    }
}

#endif
