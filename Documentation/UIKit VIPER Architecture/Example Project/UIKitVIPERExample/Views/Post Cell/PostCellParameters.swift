//  
//  PostCellParameters.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import VCore

// MARK: - Post Cell Parameters
struct PostCellParameters: UITableViewCellParameter {
    // MARK: Properties
    let post: Post
    
    // MARK: Table View Cell Parameter
    var reuseID: String { PostCell.reuseID }
}
