//  ___FILEHEADER___

import Foundation
import VCore

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
