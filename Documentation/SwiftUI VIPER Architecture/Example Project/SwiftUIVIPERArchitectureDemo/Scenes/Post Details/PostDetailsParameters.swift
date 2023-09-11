//  
//  PostDetailsParameters.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation

// MARK: - Post Details Parameters
struct PostDetailsParameters: Hashable {
    // MARK: Properties
    let post: Post
    
    // MARK: Mock
    static var mock: Self {
        .init(
            post: .mock
        )
    }
}
