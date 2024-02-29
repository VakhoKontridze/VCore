//  ___FILEHEADER___

#if DEBUG

import Foundation

// MARK: - Mock ___VARIABLE_productName___ Gateway Protocol
struct Mock___VARIABLE_productName___Gateway: ___VARIABLE_productName___GatewayProtocol {
    func fetch(with parameters: ___VARIABLE_productName___Parameters) async throws -> ___VARIABLE_productName___Entity {
        completion(.success(.mock))
    }
}

#endif
