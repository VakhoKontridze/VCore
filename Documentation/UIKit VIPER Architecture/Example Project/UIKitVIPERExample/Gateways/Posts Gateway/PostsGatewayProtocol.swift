//  
//  FetchPostsGatewayProtocol.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Fetch Posts Gateway Protocol
protocol FetchPostsGatewayProtocol {
    func fetch(completion: @escaping (Result<FetchPostsEntity, any Error>) -> Void)
}
