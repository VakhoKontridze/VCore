//
//  UITableViewProtocols.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - Parameter
/// Protocol that allows parameter to configure an `UITableViewCell`.
///
///     protocol SomeViewable: AnyObject {}
///
///     protocol SomePresentable: UITableViewDelegable, UITableViewDataSourceable {}
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
///                 parameter: presenter.tableViewCellParameter(section: indexPath.section, row: indexPath.row)
///             )
///         }
///     }
///
///     final class SomePresenter<View>: SomePresentable
///         where View: SomeViewable
///     {
///         unowned let view: SomeViewable
///
///         private var tableViewParameters: [[any UITableViewCellParameter]] = []
///
///         init(view: View) {
///             self.view = view
///         }
///
///         func tableViewDidSelectRow(section: Int, row: Int) {
///             print(tableViewParameters[section][row])
///         }
///
///         var tableViewNumberOfSections: Int {
///             tableViewParameters.count
///         }
///
///         func tableViewNumberOfRows(section: Int) -> Int {
///             tableViewParameters[section].count
///         }
///
///         func tableViewCellParameter(section: Int, row: Int) -> any UITableViewCellParameter {
///             tableViewParameters[section][row]
///         }
///     }
///
public protocol UITableViewCellParameter {
    /// `UITableViewCell` reuse ID
    var reuseID: String { get }
}

// MARK: - Cell
/// Protocol that allows `UITableViewCell` to be configured using a parameter.
public protocol ConfigurableUITableViewCell: UITableViewCell {
    /// `UITableViewCell` reuse ID.
    static var reuseID: String { get }
    
    /// Configures `UITableViewCell` using a parameter.
    func configure(parameter: some UITableViewCellParameter)
}

extension ConfigurableUITableViewCell {
    public static var reuseID: String { .init(describing: self) }
}

// MARK: - Table View
/// Allows for the delegation of `UITableViewDelegate`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM` architecture, this protocol is conformed to by a `ViewModel`.
public protocol UITableViewDelegable {
    /// Notifies that a `UITableViewCell` has been selected and section and row.
    func tableViewDidSelectRow(section: Int, row: Int)
}

/// Allows for the delegation of `UITableViewDataSource`.
///
/// In `MVP`, `VIP`, and `VIPER` architectures, this protocol is conformed to by a `Presenter`.
/// in `MVVM` architecture, this protocol is conformed to by a `ViewModel`.
public protocol UITableViewDataSourceable {
    /// Number of sections in `UITableView`.
    var tableViewNumberOfSections: Int { get }
    
    /// Number of rows in a given sections in `UITableView`.
    func tableViewNumberOfRows(section: Int) -> Int
    
    /// Parameter for `UITableViewCell` used during configuration.
    func tableViewCellParameter(section: Int, row: Int) -> any UITableViewCellParameter
}

// MARK: - Registering
extension UITableView {
    /// Registers `ConfigurableUITableViewCell` for reuse in a `UITableView`.
    public func register(_ cells: any ConfigurableUITableViewCell.Type...) {
        cells.forEach { register($0, forCellReuseIdentifier: $0.reuseID) }
    }
}

// MARK: - Dequeueing and Configuring
extension UITableView {
    /// Dequeues and configures a reusable cell in `UITableView`.
    public func dequeueAndConfigureReusableCell(
        parameter: any UITableViewCellParameter
    ) -> UITableViewCell {
        guard
            let cell = dequeueReusableCell(withIdentifier: parameter.reuseID) as? any ConfigurableUITableViewCell
        else {
            VCoreFatalError("Unable to dequeue a cell with identifier '\(parameter.reuseID)'")
        }
        
        cell.configure(parameter: parameter)
        
        return cell
    }
}

#endif
