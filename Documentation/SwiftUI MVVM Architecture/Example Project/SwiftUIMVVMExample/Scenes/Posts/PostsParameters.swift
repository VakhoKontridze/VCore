//
//  PostsParameters.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 20.06.22.
//

import Foundation

// MARK: - Posts Parameters
struct PostsParameters: Hashable {
    // MARK: Mock
#if DEBUG
    static var mock: Self {
        .init()
    }
#endif
}
