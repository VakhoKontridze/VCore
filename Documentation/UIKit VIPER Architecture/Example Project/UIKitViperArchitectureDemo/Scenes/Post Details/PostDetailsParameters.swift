//  
//  PostDetailsParameters.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation

// MARK: - Post Details Parameters
struct PostDetailsParameters {
    // MARK: Properties
    let post: Post
    
    // MARK: Mock
    static var mock: Self {
        .init(
            post: .mock
        )
    }
}
