//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import UIKit

// MARK: - Network Response Processor
@available(*, deprecated, renamed: "NetworkResponseProcessor")
public typealias NetworkProcessor = NetworkResponseProcessor

extension NetworkClient {
    @available(*, deprecated, message: "Use init with `responseProcessor` parameter")
    public convenience init(processor: NetworkResponseProcessor) {
        self.init(responseProcessor: processor)
    }
}
