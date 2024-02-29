//  ___FILEHEADER___

import Foundation

// MARK: - ___VARIABLE_productName___ Gateway Protocol
protocol ___VARIABLE_productName___GatewayProtocol {
    func fetch(
        with parameters: ___VARIABLE_productName___Parameters,
        completion: @escaping (Result<___VARIABLE_productName___Entity, any Error>) -> Void
    )
}
