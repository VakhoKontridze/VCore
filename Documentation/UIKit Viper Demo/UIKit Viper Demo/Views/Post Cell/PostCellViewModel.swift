//  
//  PostCellViewModel.swift
//  UIKit Viper Demo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import VCore

// MARK: - Post Cell ViewModel
struct PostCellViewModel: UITableViewCellViewModelable {
    // MARK: Properties
    let title: String
    let body: String
    
    // MARK: Initializers
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
    
    init?(post: PostsEntity.Post) {
        guard let title: String = post.title else { return nil }
        
        self.init(
            title: title.capitalized,
            body: post.body ?? "-"
        )
    }
    
    // MARK: Table View Cell ViewModelable
    var dequeueID: String { PostCell.dequeueID }
}
