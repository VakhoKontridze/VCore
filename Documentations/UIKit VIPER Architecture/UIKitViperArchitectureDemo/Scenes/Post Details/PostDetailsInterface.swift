//  
//  PostDetailsInterface.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import VCore

// MARK: - Post Details Viewable
protocol PostDetailsViewable: AnyObject {
    func setTitle(to title: String)
    func setBody(to body: String)
}

// MARK: - Post Details Presentable
protocol PostDetailsPresentable {
    func viewDidLoad()
}
