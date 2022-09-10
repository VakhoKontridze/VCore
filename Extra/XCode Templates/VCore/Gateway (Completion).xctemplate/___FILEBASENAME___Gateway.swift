//  ___FILEHEADER___

import Foundation

// MARK: - ___VARIABLE_productName___ Gateway
protocol ___VARIABLE_productName___Gateway {
    func fetch(
        with parameters: ___VARIABLE_productName___GatewayParameters,
        completion: @escaping (Result<___VARIABLE_productName___Entity, any Error>) -> Void
    )
}
