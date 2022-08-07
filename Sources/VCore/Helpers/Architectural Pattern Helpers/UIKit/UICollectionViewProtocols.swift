//
//  UICollectionViewProtocols.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Parameters
/// Protocol that allows parameter to dequeue an `UICollectionViewCell`.
///
///     protocol SomeViewable: AnyObject {}
///
///     protocol SomePresentable: UICollectionViewDelegable, UICollectionViewDataSourceable {}
///
///     final class SomeViewController:
///         UIViewController, SomeViewable,
///         UICollectionViewDelegate, UICollectionViewDataSource
///     {
///         var presenter: (any SomePresentable)!
///
///         func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
///             presenter.collectionViewDidSelectRow(section: indexPath.section, row: indexPath.row)
///         }
///
///         func numberOfSections(in collectionView: UICollectionView) -> Int {
///             presenter.collectionViewNumberOfSections
///         }
///
///         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
///             presenter.collectionViewNumberOfItems(section: section)
///         }
///
///         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
///             collectionView.dequeueAndConfigureReusableCell(
///                 indexPath: indexPath,
///                 parameter: presenter.collectionViewCellParameter(section: indexPath.section, row: indexPath.row)
///             )
///         }
///     }
///
///     final class SomePresenter<View>: SomePresentable
///         where View: SomeViewable
///     {
///         unowned let view: SomeViewable
///
///         private var collectionViewParameters: [[any UICollectionViewCellParameter]] = []
///
///         init(view: View) {
///             self.view = view
///         }
///
///         func collectionViewDidSelectRow(section: Int, row: Int) {
///             print(collectionViewParameters[section][row])
///         }
///
///         var collectionViewNumberOfSections: Int {
///             collectionViewParameters.count
///         }
///
///         func collectionViewNumberOfItems(section: Int) -> Int {
///             collectionViewParameters[section].count
///         }
///
///         func collectionViewCellViewParameter(section: Int, row: Int) -> any UICollectionViewCellParameter {
///             collectionViewParameters[section][row]
///         }
///     }
///
public protocol UICollectionViewCellParameter {
    /// `UICollectionViewCell` dequeue ID.
    var dequeueID: String { get }
}

// MARK: - Cell
/// Protocol that allows `UICollectionViewCell` to be configured using a parameter.
public protocol UICollectionViewDequeueable: UICollectionViewCell {
    /// `UICollectionViewCell` dequeue ID.
    static var dequeueID: String { get }
    
    /// Configures `UICollectionViewCell` using a parameter.
    func configure(parameter: some UICollectionViewCellParameter)
}

extension UICollectionViewDequeueable {
    public static var dequeueID: String { .init(describing: self) }
}

// MARK: - Collection View
/// Allows for the delegation of `UICollectionViewDelegate`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM` architecture, this protocol is conformed to by a `ViewModel.`
public protocol UICollectionViewDelegable {
    /// Notifies that a `UICollectionViewCell` has been selected and section and row.
    func collectionViewDidSelectRow(section: Int, row: Int)
}

/// Allows for the delegation of `UICollectionViewDataSource`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM` architecture, this protocol is conformed to by a `ViewModel.`
public protocol UICollectionViewDataSourceable {
    /// Number of sections in `UICollectionView`
    var collectionViewNumberOfSections: Int { get }
    
    /// Number of items in a given sections in `UICollectionView`.
    func collectionViewNumberOfItems(section: Int) -> Int
    
    /// Parameter for `UICollectionViewCell` used during configuration.
    func collectionViewCellParameter(section: Int, row: Int) -> any UICollectionViewCellParameter
}

// MARK: - Registering
extension UICollectionView {
    /// Registers dequeueable `UICollectionViewCell` for reuse in a `UICollectionView`.
    public func register(_ cells: any UICollectionViewDequeueable.Type...) {
        cells.forEach { register($0, forCellWithReuseIdentifier: $0.dequeueID) }
    }
}

// MARK: - Dequeueing
extension UICollectionView {
    /// Dequeues and configures a reusable cell in `UICollectionView`.
    public func dequeueAndConfigureReusableCell(
        indexPath: IndexPath,
        parameter: any UICollectionViewCellParameter
    ) -> UICollectionViewCell {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: parameter.dequeueID, for: indexPath) as? any UICollectionViewDequeueable
        else {
            fatalError("Unable to dequeue a cell with identifier \(parameter.dequeueID)")
        }
        
        cell.configure(parameter: parameter)
        
        return cell
    }
}

#endif
