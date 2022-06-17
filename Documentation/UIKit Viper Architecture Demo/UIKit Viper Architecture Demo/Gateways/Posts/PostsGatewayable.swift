//  
//  PostsGatewayable.swift
//  UIKit Viper Demo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Posts Gatewayable
protocol PostsGatewayable {
    func fetch(completion: @escaping (Result<PostsEntity, Error>) -> Void)
}
