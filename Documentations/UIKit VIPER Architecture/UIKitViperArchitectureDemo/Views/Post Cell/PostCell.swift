//  
//  PostCell.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Post Cell
final class PostCell: UITableViewCell, UITableViewDequeueable {
    // MARK: Subviews
    private let titleLabel: UILabel = .init(
        color: UIModel.Colors.titleLabel,
        font: UIModel.Fonts.titleLabel
    ).withTranslatesAutoresizingMaskIntoConstraints(false)
    
    private let bodyLabel: UILabel = .init(
        numberOfLines: UIModel.Layout.bodyLabelNumberOfLines,
        color: UIModel.Colors.bodyLabel,
        font: UIModel.Fonts.bodyLabel
    ).withTranslatesAutoresizingMaskIntoConstraints(false)
    
    // MARK: Properties
    private typealias UIModel = PostCellUIModel

    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: Setup
    private func setUp() {
        setUpView()
        addSubviews()
        setUpLayout()
    }
    
    private func setUpView() {
        backgroundColor = UIModel.Colors.background
        selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            titleLabel.constraintLeading(to: contentView, constant: UIModel.Layout.titleLabelMarginHor),
            titleLabel.constraintTrailing(to: contentView, constant: -UIModel.Layout.titleLabelMarginHor),
            titleLabel.constraintTop(to: contentView, constant: UIModel.Layout.titleLabelMarginTop),
            
            bodyLabel.constraintLeading(to: contentView, constant: UIModel.Layout.bodyLabelMarginHor),
            bodyLabel.constraintTrailing(to: contentView, constant: -UIModel.Layout.bodyLabelMarginHor),
            bodyLabel.constraintTop(to: titleLabel, attribute: .bottom, constant: UIModel.Layout.bodyLabelMarginTop),
            bodyLabel.constraintBottom(to: contentView, constant: -UIModel.Layout.bodyLabelMarginBottom)
        ])
    }

    // MARK: Dequeueable
    func configure(parameter: some UITableViewCellParameter) {
        guard let parameters = parameter as? PostCellViewParameters else { return }
        
        titleLabel.text = parameters.title
        bodyLabel.text = parameters.body
    }
}
