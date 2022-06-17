//  ___FILEHEADER___

import Foundation

// MARK: - ___VARIABLE_productName___ Gatewayable
protocol ___VARIABLE_productName___Gatewayable {
    func fetch(
        with parameters: ___VARIABLE_productName___Parameters,
        completion: @escaping (Result<___VARIABLE_productName___Entity, Error>) -> Void
    )
}
