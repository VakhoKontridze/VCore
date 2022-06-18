//  
//  PostCell.swift
//  UIKit Viper Demo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit
import VCore

// MARK: - Post Cell
final class PostCell: UITableViewCell, UITableViewDequeueable {
    // MARK: Subviews
    private let titleLabel: UILabel = .init(
        color: Model.Colors.titleLabel,
        font: Model.Fonts.titleLabel
    ).withTranslatesAutoresizingMaskIntoConstraints(false)
    
    private let bodyLabel: UILabel = .init(
        numberOfLines: Model.Layout.bodyLabelNumberOfLines,
        color: Model.Colors.bodyLabel,
        font: Model.Fonts.bodyLabel
    ).withTranslatesAutoresizingMaskIntoConstraints(false)
    
    // MARK: Properties
    private typealias Model = PostCellModel

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
        backgroundColor = Model.Colors.background
        selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Model.Layout.titleLabelMarginHor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Model.Layout.titleLabelMarginHor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Model.Layout.titleLabelMarginTop),
            
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Model.Layout.bodyLabelMarginHor),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Model.Layout.bodyLabelMarginHor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Model.Layout.bodyLabelMarginTop),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Model.Layout.bodyLabelMarginBottom)
        ])
    }

    // MARK: Dequeueable
    func configure(viewModel: any UITableViewCellViewModelable) {
        guard let viewModel = viewModel as? PostCellViewModel else { return }
        
        titleLabel.text = viewModel.title
        bodyLabel.text = viewModel.body
    }
}
