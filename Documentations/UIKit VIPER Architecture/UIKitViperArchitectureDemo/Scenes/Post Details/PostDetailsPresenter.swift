//  
//  PostDetailsPresenter.swift
//  UIKit Viper Demo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import Foundation
import VCore

// MARK: - Post Details Presenter
final class PostDetailsPresenter<View>: PostDetailsPresentable
    where View: PostDetailsViewable
{
    // MARK: Properties
    private unowned let view: View
    private let parameters: PostDetailsParameters

    // MARK: Initializers
    init(
        view: View,
        parameters: PostDetailsParameters
    ) {
        self.view = view
        self.parameters = parameters
    }

    // MARK: Presentable
    func viewDidLoad() {
        view.setTitle(to: parameters.title)
        view.setBody(to: parameters.body)
    }
}
