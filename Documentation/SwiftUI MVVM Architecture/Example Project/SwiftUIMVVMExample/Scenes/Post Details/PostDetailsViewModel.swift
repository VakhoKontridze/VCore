//  
//  PostDetailsViewModel.swift
//  SwiftUIMVVMExample
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import Foundation
import VCore

// MARK: - Post Details View Model
@Observable
final class PostDetailsViewModel: ObservableObject {
    // MARK: Properties
    @ObservationIgnored private let parameters: PostDetailsParameters

    var title: String { parameters.post.title }
    var body: String { parameters.post.body }
    
    // MARK: Initializers
    init(parameters: PostDetailsParameters) {
        self.parameters = parameters
    }
}
