//  
//  PostsGateway.swift
//  UIKit Viper Demo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Posts Gateway
protocol PostsGateway {
    func fetch(completion: @escaping (Result<PostsEntity, Error>) -> Void)
}
