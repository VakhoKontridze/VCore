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

// MARK: - VIPER Helpers
extension UITableViewDataSourceable {
    @available(*, deprecated, message: "")
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

extension UICollectionViewDataSourceable {
    @available(*, deprecated, message: "")
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
