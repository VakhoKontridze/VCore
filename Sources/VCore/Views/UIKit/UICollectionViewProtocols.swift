//
//  UICollectionViewProtocols.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import OSLog

/// Protocol that allows parameter to configure a `UICollectionViewCell`.
///
///     final classViewController:
///         UIViewController,
///         UICollectionViewDelegate, UICollectionViewDataSource
///     {
///         var viewModel: ViewModel!
///
///         func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
///             viewModel.collectionViewDidSelectRow(section: indexPath.section, row: indexPath.row)
///         }
///
///         func numberOfSections(in collectionView: UICollectionView) -> Int {
///             viewModel.collectionViewNumberOfSections
///         }
///
///         func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
///             viewModel.collectionViewNumberOfItems(section: section)
///         }
///
///         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
///             collectionView.dequeueAndConfigureReusableCell(
///                 indexPath: indexPath,
///                 parameter: viewModel.collectionViewCellParameter(section: indexPath.section, row: indexPath.row)
///             )
///         }
///     }
///
///     final class ViewModel: UICollectionViewDelegable, UICollectionViewDataSourceable {
///         unowned let view: ViewController
///
///         private var collectionViewParameters: [[any UICollectionViewCellParameter]] = []
///
///         init(view: ViewController) {
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
    /// `UICollectionViewCell` reuse ID.
    var reuseID: String { get }
}

/// Protocol that allows `UICollectionViewCell` to be configured using a parameter.
public protocol ConfigurableUICollectionViewCell: UICollectionViewCell {
    /// `UICollectionViewCell` reuse ID.
    static var reuseID: String { get }
    
    /// Configures `UICollectionViewCell` using a parameter.
    func configure(parameter: any UICollectionViewCellParameter)
}

nonisolated extension ConfigurableUICollectionViewCell {
    public static var reuseID: String { .init(describing: self) }
}

/// Allows for the delegation of `UICollectionViewDelegate`.
public protocol UICollectionViewDelegable {
    /// Notifies that a `UICollectionViewCell` has been selected and section and row.
    func collectionViewDidSelectRow(section: Int, row: Int)
}

/// Allows for the delegation of `UICollectionViewDataSource`.
public protocol UICollectionViewDataSourceable {
    /// Number of sections in `UICollectionView`
    var collectionViewNumberOfSections: Int { get }
    
    /// Number of items in a given sections in `UICollectionView`.
    func collectionViewNumberOfItems(section: Int) -> Int
    
    /// Parameter for `UICollectionViewCell` used during configuration.
    func collectionViewCellParameter(section: Int, row: Int) -> any UICollectionViewCellParameter
}

extension UICollectionView {
    /// Registers `ConfigurableUICollectionViewCell` for reuse in a `UICollectionView`.
    public func register(_ cells: any ConfigurableUICollectionViewCell.Type...) {
        cells.forEach { register($0, forCellWithReuseIdentifier: $0.reuseID) }
    }
}

extension UICollectionView {
    /// Dequeues and configures a reusable cell in `UICollectionView`.
    public func dequeueAndConfigureReusableCell(
        indexPath: IndexPath,
        parameter: any UICollectionViewCellParameter
    ) -> UICollectionViewCell {
        guard
            let cell = dequeueReusableCell(withReuseIdentifier: parameter.reuseID, for: indexPath) as? any ConfigurableUICollectionViewCell
        else {
            Logger.misc.critical("Failed to dequeue 'ConfigurableUICollectionViewCell' with identifier '\(parameter.reuseID)' in 'UICollectionView.dequeueAndConfigureReusableCell(indexPath:parameter:)'")
            return UICollectionViewCell()
        }
        
        cell.configure(parameter: parameter)
        
        return cell
    }
}

#endif
