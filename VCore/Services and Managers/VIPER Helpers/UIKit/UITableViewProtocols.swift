//
//  UITableViewProtocols.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/10/21.
//

import UIKit

// MARK: - ViewModel
/// Protocol that allows viewmodel to dequeue an `UITableViewCell`
///
/// Usage example:
///
///     final class Presenter: UITableViewDelegatable, UITableViewDataSourceable {
///         var dataSource: [[UITableViewCellViewModelable]] = []
///
///         func tableViewDidSelectRow(section: Int, row: Int) {
///             print(dataSource[section][row])
///         }
///
///         var tableViewNumberOfSections: Int {
///             dataSource.count
///         }
///
///         func tableViewNumberOfRows(in section: Int) -> Int {
///             dataSource[section].count
///         }
///
///         func tableViewCellDequeueID(section: Int, row: Int) -> String {
///             dataSource[section][row].dequeueID
///         }
///
///         func tableViewCellViewModel(section: Int, row: Int) -> UITableViewCellViewModelable {
///             dataSource[section][row]
///         }
///     }
///
public protocol UITableViewCellViewModelable {
    /// `UITableViewCell` dequeue ID
    var dequeueID: String { get }
}

// MARK: - Cell
/// Protocol that allows `UITableViewCell` to be configured using a viewmodel
public protocol UITableViewDequeueable: UITableViewCell {
    /// `UITableViewCell` dequeue ID
    static var dequeueID: String { get }
    
    /// Configures `UITableViewCell` using a viewmodel
    func configure(with viewModel: UITableViewCellViewModelable)
}

extension UITableViewDequeueable {
    public static var dequeueID: String { nsObjectName! }
}

// MARK: - Table View
/// Allows for the delegation of `UITableViewDelegate`
///
/// In `VIP` and `VIPER` arhcitecutes, this protoocol is conformed to by a `Presenter`
public protocol UITableViewDelegatable {
    /// Notifies that a `UITableViewCell` has been selected and section and row
    func tableViewDidSelectRow(section: Int, row: Int)
}

/// Allows for the delegation of `UITableViewDataSource`
///
/// In `VIP` and `VIPER` arhcitecutes, this protoocol is conformed to by a `Presenter`
public protocol UITableViewDataSourceable {
    /// Number of sections in `UITableView`
    var tableViewNumberOfSections: Int { get }
    
    /// Number of rows in a given sections in `UITableView`
    func tableViewNumberOfRows(in section: Int) -> Int
    
    /// Dequeue ID for `UITableViewCell`
    func tableViewCellDequeueID(section: Int, row: Int) -> String
    
    /// Viewmodel for `UITableViewCell` used during configuration
    func tableViewCellViewModel(section: Int, row: Int) -> UITableViewCellViewModelable
}

// MARK: - Registering
extension UITableView {
    /// Registers dequeueable `UITableViewCell` for reuse in a `UITableView`
    public func register(_ cells: UITableViewDequeueable.Type...) {
        cells.forEach { register($0, forCellReuseIdentifier: $0.dequeueID) }
    }
}

// MARK: - Dequeueing
extension UITableView {
    /// Deques and configures a resuabe cell in `UITableView`
    public func dequeueAndConfigureReusableCell(
        dequeueID: String,
        viewModel: UITableViewCellViewModelable
    ) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: dequeueID) as? UITableViewDequeueable else { return .init() }
        cell.configure(with: viewModel)
        return cell
    }
}
