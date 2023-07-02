//  
//  PostCell.swift
//  UIKitViperArchitectureDemo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Post Cell
final class PostCell: UITableViewCell, ConfigurableUITableViewCell {
    // MARK: Subviews
    private let titleLabel: UILabel = .init(
        color: UIModel.titleLabelColor,
        font: UIModel.titleLabelFont
    )
        .withTranslatesAutoresizingMaskIntoConstraints(false)
    
    private let bodyLabel: UILabel = .init(
        numberOfLines: UIModel.bodyLabelNumberOfLines,
        color: UIModel.bodyLabelColor,
        font: UIModel.bodyLabelFont
    )
        .withTranslatesAutoresizingMaskIntoConstraints(false)
    
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
        backgroundColor = UIModel.backgroundColor
        selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            titleLabel.constraintLeading(to: contentView, constant: UIModel.titleLabelMarginHor),
            titleLabel.constraintTrailing(to: contentView, constant: -UIModel.titleLabelMarginHor),
            titleLabel.constraintTop(to: contentView, constant: UIModel.titleLabelMarginTop),
            
            bodyLabel.constraintLeading(to: contentView, constant: UIModel.bodyLabelMarginHor),
            bodyLabel.constraintTrailing(to: contentView, constant: -UIModel.bodyLabelMarginHor),
            bodyLabel.constraintTop(to: titleLabel, attribute: .bottom, constant: UIModel.bodyLabelMarginTop),
            bodyLabel.constraintBottom(to: contentView, constant: -UIModel.bodyLabelMarginBottom)
        ])
    }
    
    // MARK: Configurable Table View Cell
    func configure(parameter: some UITableViewCellParameter) {
        guard let parameters = parameter as? PostCellViewParameters else { return }
        
        titleLabel.text = parameters.title
        bodyLabel.text = parameters.body
    }
}
