//  
//  PostDetailsViewController.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Post Details View Controller
final class PostDetailsViewController: UIViewController, PostDetailsViewable {
    // MARK: Subviews
    private let scrollableView: ScrollableView = {
        let scrollabelView: ScrollableView = .init(direction: .vertical)
        scrollabelView.translatesAutoresizingMaskIntoConstraints = false
        scrollabelView.scrollView.bounces = false
        return scrollabelView
    }()
    
    private let bodyLabel: UILabel = .init(
        numberOfLines: 0,
        color: UIModel.Colors.bodyLabel,
        font: UIModel.Fonts.bodyLabel
    ).withTranslatesAutoresizingMaskIntoConstraints(false)
    
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
        setUpNavBar()
    }
    
    private func setUpView() {
        view.backgroundColor = UIModel.Colors.background
    }

    private func addSubviews() {
        view.addSubview(scrollableView)
        scrollableView.contentView.addSubview(bodyLabel)
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            scrollableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollableView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bodyLabel.heightAnchor.constraint(equalToConstant: 0)
                .storing(in: &bodyLabelHeightConstraint),
            bodyLabel.leadingAnchor.constraint(equalTo: scrollableView.contentView.leadingAnchor, constant: UIModel.Layout.bodyLabelMarginHor),
            bodyLabel.trailingAnchor.constraint(equalTo: scrollableView.contentView.trailingAnchor, constant: -UIModel.Layout.bodyLabelMarginHor),
            bodyLabel.topAnchor.constraint(equalTo: scrollableView.contentView.safeAreaLayoutGuide.topAnchor, constant: UIModel.Layout.bodyLabelMarginTop),
            bodyLabel.bottomAnchor.constraint(equalTo: scrollableView.contentView.safeAreaLayoutGuide.bottomAnchor, constant: -UIModel.Layout.bodyLabelMarginBottom)
        ])
    }
    
    private func setUpNavBar() {
        navigationItem.title = "Post Details"
    }

    // MARK: Viewable
    func setTitle(to title: String) {
        navigationItem.title = title
    }
    
    func setBody(to body: String) {
        bodyLabel.text = body
        bodyLabelHeightConstraint?.constant = bodyLabel
            .multiLineHeight(width: view.frame.width - 2*UIModel.Layout.bodyLabelMarginHor)
    }
}
