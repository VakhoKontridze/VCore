//  
//  PostDetailsInteraface.swift
//  SwiftUIVIPERArchitectureDemo
//
//  Created by Vakhtang Kontridze on 19.06.22.
//

import SwiftUI
import VCore

// MARK: - Post Details Presentable
@MainActor protocol PostDetailsPresentable: ObservableObject {
    var title: String { get }
    var body: String { get }
}
