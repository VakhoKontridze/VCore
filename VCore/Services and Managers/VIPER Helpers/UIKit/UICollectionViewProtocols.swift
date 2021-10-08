//
//  UICollectionViewProtocols.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/10/21.
//

import UIKit

// MARK: - ViewModel
/// Protocol that allows viewmodel to dequeue an `UICollectionViewCell`
///
/// Usage example:
///
///     final class Presenter: UICollectionViewDelegatable, UICollectionViewDataSourceable {
///         var dataSource: [[UICollectionViewCellViewModelable]] = []
///
///         func collectionViewDidSelectRow(section: Int, row: Int) {
///             print(dataSource[section][row])
///         }
///
///         var collectionViewNumberOfSections: Int {
///             dataSource.count
///         }
///
///         func collectionViewNumberOfItems(section: Int) -> Int {
///             dataSource[section].count
///         }
///
///         func collectionViewCellDequeueID(section: Int, row: Int) -> String {
///             dataSource[section][row].dequeueID
///         }
///
///         func collectionViewCellViewModel(section: Int, row: Int) -> UICollectionViewCellViewModelable {
///             dataSource[section][row]
///         }
///     }
///
public protocol UICollectionViewCellViewModelable {
    /// `UICollectionViewCell` dequeue ID
    var dequeueID: String { get }
}

// MARK: - Cell
/// Protocol that allows `UICollectionViewCell` to be configured using a viewmodel
public protocol UICollectionViewDequeueable: UICollectionViewCell {
    /// `UICollectionViewCell` dequeue ID
    static var dequeueID: String { get }
    
    /// Configures `UICollectionViewCell` using a viewmodel
    func configure(with viewModel: UICollectionViewCellViewModelable)
}

extension UICollectionViewDequeueable {
    public static var dequeueID: String { nsObjectName! }
}

// MARK: - Collection View
/// Allows for the delegation of `UICollectionViewDelegate`
///
/// In `VIP` and `VIPER` arhcitecutes, this protoocol is conformed to by a `Presenter`
public protocol UICollectionViewDelegatable {
    /// Notifies that a `UICollectionViewCell` has been selected and section and row
    func collectionViewDidSelectRow(section: Int, row: Int)
}

/// Allows for the delegation of `UICollectionViewDataSource`
///
/// In `VIP` and `VIPER` arhcitecutes, this protoocol is conformed to by a `Presenter`
public protocol UICollectionViewDataSourceable {
    /// Number of sections in `UICollectionView`
    var collectionViewNumberOfSections: Int { get }
    
    /// Number of items in a given sections in `UICollectionView`
    func collectionViewNumberOfItems(section: Int) -> Int
    
    /// Dequeue ID for `UICollectionViewCell`
    func collectionViewCellDequeueID(section: Int, row: Int) -> String
    
    /// Viewmodel for `UICollectionViewCell` used during configuration
    func collectionViewCellViewModel(section: Int, row: Int) -> UICollectionViewCellViewModelable
}

// MARK: - Registering
extension UICollectionView {
    /// Registers dequeueable `UICollectionViewCell` for reuse in a `UICollectionView`
    public func register(_ cells: UICollectionViewDequeueable.Type...) {
        cells.forEach { register($0, forCellWithReuseIdentifier: $0.dequeueID) }
    }
}

// MARK: - Dequeueing
extension UICollectionView {
    /// Deques and configures a resuabe cell in `UICollectionView`
    public func dequeueAndConfigureReusableCell(
        dequeueID: String,
        indexPath: IndexPath,
        viewModel: UICollectionViewCellViewModelable
    ) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: dequeueID, for: indexPath) as? UICollectionViewDequeueable else { return .init() }
        cell.configure(with: viewModel)
        return cell
    }
}
