//
//  Deprecations.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10/9/21.
//

import UIKit
import SwiftUI

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

// MARK: - Exteions - Foundation - FloatingPoint
extension FloatingPoint {
    @available(*, deprecated, message: "Renamed to `bound`")
    public func fixedInRange(
        _ range: ClosedRange<Self>,
        step: Self? = nil
    ) -> Self {
        bound(in: range, step: step)
    }
    
    @available(*, deprecated, message: "Renamed to `bound`")
    public func fixedInRange(
        min: Self,
        max: Self,
        step: Self? = nil
    ) -> Self {
        bound(min: min, max: max, step: step)
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
            lineBreakMode: lineBreakMode,
            numberOfLines: numberOfLines,
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
            lineBreakMode: lineBreakMode,
            numberOfLines: numberOfLines,
            color: color,
            font: font
        )
    }
}

// MARK: - Extensions - SwiftUI - View
extension View {
    @available(*, deprecated, message: "Use method without `radius` parameter name")
    public func cornerRadius(
        radius: CGFloat,
        corners: UIRectCorner
    ) -> some View {
        self
            .cornerRadius(radius, corners: corners)
    }
}
