//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import UIKit

// MARK: - Network Response Processor
@available(*, deprecated, renamed: "NetworkResponseProcessor")
public typealias NetworkProcessor = NetworkResponseProcessor

extension NetworkClient {
    @available(*, deprecated, message: "Use init with `responseProcessor` parameter")
    public convenience init(processor: NetworkResponseProcessor) {
        self.init(responseProcessor: processor)
    }
}

// MARK: - Base Button
extension UIKitBaseButton {
    @available(*, deprecated, message: "Use method with `state` parameter")
    open func configure(with state: UIKitBaseButtonState) {
        configure(state: state)
    }
}

// MARK: - VIPER Helpers - Table View
extension UITableViewDequeueable {
    @available(*, deprecated, message: "Use method without `with` parameter")
    public func configure(with viewModel: UITableViewCellViewModelable) {
        configure(viewModel: viewModel)
    }
}

extension UITableViewDataSourceable {
    @available(*, deprecated)
    public func tableViewCellDequeueID(section: Int, row: Int) -> String {
        tableViewCellViewModel(section: section, row: row).dequeueID
    }
}

extension UITableView {
    @available(*, deprecated, message: "Use method without `dequeueID` parameter")
    public func dequeueAndConfigureReusableCell(
        dequeueID: String,
        viewModel: UITableViewCellViewModelable
    ) -> UITableViewCell {
        dequeueAndConfigureReusableCell(viewModel: viewModel)
    }
}

// MARK: - VIPER Helpers - Collection View
extension UICollectionViewDequeueable {
    @available(*, deprecated, message: "Use method without `with` parameter")
    public func configure(with viewModel: UICollectionViewCellViewModelable) {
        configure(viewModel: viewModel)
    }
}

extension UICollectionViewDataSourceable {
    @available(*, deprecated)
    public func collectionViewCellDequeueID(section: Int, row: Int) -> String {
        collectionViewCellViewModel(section: section, row: row).dequeueID
    }
}

extension UICollectionView {
    @available(*, deprecated, message: "Use method without `dequeueID` parameter")
    public func dequeueAndConfigureReusableCell(
        indexPath: IndexPath,
        dequeueID: String,
        viewModel: UICollectionViewCellViewModelable
    ) -> UICollectionViewCell {
        dequeueAndConfigureReusableCell(indexPath: indexPath, viewModel: viewModel)
    }
}

// MARK: - Exteions - UIKit - UILabel
extension UILabel {
    @available(*, deprecated, message: "Use `init` with different parameter order")
    public func configure(
        font: UIFont?,
        color: UIColor?,
        alignment: NSTextAlignment = .natural,
        numberOfLines: Int = 1,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail
    ) {
        configure(
            alignment: alignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            color: color,
            font: font
        )
    }
    
    @available(*, deprecated, message: "Use `init` with different parameter order")
    public convenience init(
        font: UIFont?,
        color: UIColor?,
        alignment: NSTextAlignment = .natural,
        numberOfLines: Int = 1,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail
    ) {
        self.init()
        
        configure(
            alignment: alignment,
            numberOfLines: numberOfLines,
            lineBreakMode: lineBreakMode,
            color: color,
            font: font
        )
    }
}
