//
//  UITableViewProtocols.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - ViewModel
/// Protocol that allows viewmodel to dequeue an `UITableViewCell`
///
///     protocol SomeViewable: AnyObject {}
///
///     protocol SomePresentable: UITableViewDelegatable, UITableViewDataSourceable {}
///
///     final class SomeViewController:
///         UIViewController, SomeViewable,
///         UITableViewDelegate, UITableViewDataSource
///     {
///         var presenter: (any SomePresentable)!
///
///         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
///             presenter.tableViewDidSelectRow(section: indexPath.section, row: indexPath.row)
///         }
///
///         func numberOfSections(in tableView: UITableView) -> Int {
///             presenter.tableViewNumberOfSections
///         }
///
///         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
///             presenter.tableViewNumberOfRows(section: section)
///         }
///
///         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
///             tableView.dequeueAndConfigureReusableCell(
///                 viewModel: presenter.tableViewCellViewModel(section: indexPath.section, row: indexPath.row)
///             )
///         }
///     }
///
///     final class SomePresenter<View>: SomePresentable
///         where View: SomeViewable
///     {
///         unowned let view: SomeViewable
///
///         private var tableViewViewModels: [[any UITableViewCellViewModelable]] = []
///
///         init(view: View) {
///             self.view = view
///         }
///
///         func tableViewDidSelectRow(section: Int, row: Int) {
///             print(tableViewViewModels[section][row])
///         }
///
///         var tableViewNumberOfSections: Int {
///             tableViewViewModels.count
///         }
///
///         func tableViewNumberOfRows(section: Int) -> Int {
///             tableViewViewModels[section].count
///         }
///
///         func tableViewCellDequeueID(section: Int, row: Int) -> String {
///             tableViewViewModels[section][row].dequeueID
///         }
///
///         func tableViewCellViewModel(section: Int, row: Int) -> any UITableViewCellViewModelable {
///             tableViewViewModels[section][row]
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
    func configure(viewModel: any UITableViewCellViewModelable)
}

extension UITableViewDequeueable {
    public static var dequeueID: String { .init(describing: self) }
}

// MARK: - Table View
/// Allows for the delegation of `UITableViewDelegate`
///
/// `MVP`, `VIP`, and `VIPER` arhcitecutes, this protoocol is conformed to by a `Presenter`
public protocol UITableViewDelegatable {
    /// Notifies that a `UITableViewCell` has been selected and section and row
    func tableViewDidSelectRow(section: Int, row: Int)
}

/// Allows for the delegation of `UITableViewDataSource`
///
/// `MVP`, `VIP`, and `VIPER` arhcitecutes, this protoocol is conformed to by a `Presenter`
public protocol UITableViewDataSourceable {
    /// Number of sections in `UITableView`
    var tableViewNumberOfSections: Int { get }
    
    /// Number of rows in a given sections in `UITableView`
    func tableViewNumberOfRows(section: Int) -> Int
    
    /// Viewmodel for `UITableViewCell` used during configuration
    func tableViewCellViewModel(section: Int, row: Int) -> any UITableViewCellViewModelable
}

// MARK: - Registering
extension UITableView {
    /// Registers dequeueable `UITableViewCell` for reuse in a `UITableView`
    public func register(_ cells: any UITableViewDequeueable.Type...) {
        cells.forEach { register($0, forCellReuseIdentifier: $0.dequeueID) }
    }
}

// MARK: - Dequeueing
extension UITableView {
    /// Deques and configures a resuabe cell in `UITableView`
    public func dequeueAndConfigureReusableCell(
        viewModel: any UITableViewCellViewModelable
    ) -> UITableViewCell {
        guard
            let cell = dequeueReusableCell(withIdentifier: viewModel.dequeueID) as? any UITableViewDequeueable
        else {
            fatalError("Unable to dequeue a cell with identifier \(viewModel.dequeueID)")
        }
        
        cell.configure(viewModel: viewModel)
        
        return cell
    }
}

#endif
