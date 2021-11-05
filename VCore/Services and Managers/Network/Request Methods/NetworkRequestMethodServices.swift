//
//  NetworkRequestMethodServices.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import Foundation

// MARK: - Network URL Parameters Request Method Services
/// Network service that performs `GET` network data tasks.
public final class NetworkGETRequestMethodService: NetworkURLParametersRequestMethodService {
    init(_ networkRequestService: NetworkRequestService) {
        super.init(
            networkRequestService: networkRequestService,
            httpMethod: "GET"
        )
    }
}

// MARK: - Network Body Parameters Request Method Services
/// Network service that performs `POST` network data tasks.
public final class NetworkPOSTRequestMethodService: NetworkBodyParametersRequestMethodService {
    init(_ networkRequestService: NetworkRequestService) {
        super.init(
            networkRequestService: networkRequestService,
            httpMethod: "POST"
        )
    }
}

/// Network service that performs `PUT` network data tasks.
public final class NetworkPUTRequestMethodService: NetworkBodyParametersRequestMethodService {
    init(_ networkRequestService: NetworkRequestService) {
        super.init(
            networkRequestService: networkRequestService,
            httpMethod: "PUT"
        )
    }
}

/// Network service that performs `PATCH` network data tasks.
public final class NetworkPATCHRequestMethodService: NetworkBodyParametersRequestMethodService {
    init(_ networkRequestService: NetworkRequestService) {
        super.init(
            networkRequestService: networkRequestService,
            httpMethod: "PATCH"
        )
    }
}

/// Network service that performs `DELETE` network data tasks.
public final class NetworkDELETERequestMethodService: NetworkBodyParametersRequestMethodService {
    init(_ networkRequestService: NetworkRequestService) {
        super.init(
            networkRequestService: networkRequestService,
            httpMethod: "DELETE"
        )
    }
}
