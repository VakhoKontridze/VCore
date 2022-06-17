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
    private let viewModel: PostDetailsViewModel

    // MARK: Initializers
    init(
        view: View,
        viewModel: PostDetailsViewModel
    ) {
        self.view = view
        self.viewModel = viewModel
    }

    // MARK: Presentable
    func viewDidLoad() {
        view.setTitle(to: viewModel.title)
        view.setBody(to: viewModel.body)
    }
}
