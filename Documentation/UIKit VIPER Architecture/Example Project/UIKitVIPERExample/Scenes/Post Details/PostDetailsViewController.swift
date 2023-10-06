//  
//  PostDetailsViewController.swift
//  UIKitVIPERExample
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Post Details View Controller
final class PostDetailsViewController: UIViewController, PostDetailsViewable {
    // MARK: Subviews
    private let scrollableUIView: ScrollableUIView = {
        let scrollableUIView: ScrollableUIView = .init(direction: .vertical)
        scrollableUIView.translatesAutoresizingMaskIntoConstraints = false
        scrollableUIView.scrollView.bounces = false
        return scrollableUIView
    }()

    private let bodyLabel: UILabel = {
        let label: UILabel = .init()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIModel.bodyLabelColor
        label.font = UIModel.bodyLabelFont
        return label
    }()
    
    // MARK: Properties
    var presenter: (any PostDetailsPresentable)!
    
    private var bodyLabelHeightConstraint: NSLayoutConstraint?
    
    private typealias UIModel = PostDetailsUIModel
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter.viewDidLoad()
    }
    
    // MARK: Setup
    private func setUp() {
        setUpView()
        addSubviews()
        setUpLayout()
        setUpNavigationBar()
    }
    
    private func setUpView() {
        view.backgroundColor = UIModel.backgroundColor
    }
    
    private func addSubviews() {
        view.addSubview(scrollableUIView)
        scrollableUIView.contentView.addSubview(bodyLabel)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            scrollableUIView.constraintLeading(to: view),
            scrollableUIView.constraintTrailing(to: view),
            scrollableUIView.constraintTop(to: view),
            scrollableUIView.constraintBottom(to: view),
            
            bodyLabel.constraintHeight(to: nil, constant: 0)
                .storing(in: &bodyLabelHeightConstraint),
            bodyLabel.constraintLeading(to: scrollableUIView.contentView, constant: UIModel.bodyLabelMarginHorizontal),
            bodyLabel.constraintTrailing(to: scrollableUIView.contentView, constant: -UIModel.bodyLabelMarginHorizontal),
            bodyLabel.constraintTop(to: scrollableUIView.contentView, layoutGuide: .safeArea, constant: UIModel.bodyLabelMarginTop),
            bodyLabel.constraintBottom(to: scrollableUIView.contentView, layoutGuide: .safeArea, constant: -UIModel.bodyLabelMarginBottom)
        ])
    }
    
    private func setUpNavigationBar() {
        navigationItem.title = "Post Details"
    }
    
    // MARK: Viewable
    func setTitle(to title: String) {
        navigationItem.title = title
    }
    
    func setBody(to body: String) {
        bodyLabel.text = body
        bodyLabelHeightConstraint?.constant = bodyLabel
            .multiLineHeight(width: view.frame.width - 2*UIModel.bodyLabelMarginHorizontal)
    }
}
