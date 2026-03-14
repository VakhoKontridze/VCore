//
//  UITableViewProtocols.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/10/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit
import OSLog

/// Protocol that allows parameter to configure a `UITableViewCell`.
///
///     final class ViewController:
///         UIViewController,
///         UITableViewDelegate, UITableViewDataSource
///     {
///         var viewModel: ViewModel!
///
///         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
///             viewModel.tableViewDidSelectRow(section: indexPath.section, row: indexPath.row)
///         }
///
///         func numberOfSections(in tableView: UITableView) -> Int {
///             viewModel.tableViewNumberOfSections
///         }
///
///         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
///             viewModel.tableViewNumberOfRows(section: section)
///         }
///
///         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
///             tableView.dequeueAndConfigureReusableCell(
///                 parameter: viewModel.tableViewCellParameter(section: indexPath.section, row: indexPath.row)
///             )
///         }
///     }
///
///     final class Presenter: UITableViewDelegable, UITableViewDataSourceable {
///         unowned let view: ViewController
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

/// Protocol that allows `UITableViewCell` to be configured using a parameter.
public protocol ConfigurableUITableViewCell: UITableViewCell {
    /// `UITableViewCell` reuse ID.
    static var reuseID: String { get }
    
    /// Configures `UITableViewCell` using a parameter.
    func configure(parameter: any UITableViewCellParameter)
}

nonisolated extension ConfigurableUITableViewCell {
    public static var reuseID: String { .init(describing: self) }
}

/// Allows for the delegation of `UITableViewDelegate`.
public protocol UITableViewDelegable {
    /// Notifies that a `UITableViewCell` has been selected and section and row.
    func tableViewDidSelectRow(section: Int, row: Int)
}

/// Allows for the delegation of `UITableViewDataSource`.
public protocol UITableViewDataSourceable {
    /// Number of sections in `UITableView`.
    var tableViewNumberOfSections: Int { get }
    
    /// Number of rows in a given sections in `UITableView`.
    func tableViewNumberOfRows(section: Int) -> Int
    
    /// Parameter for `UITableViewCell` used during configuration.
    func tableViewCellParameter(section: Int, row: Int) -> any UITableViewCellParameter
}

extension UITableView {
    /// Registers `ConfigurableUITableViewCell` for reuse in a `UITableView`.
    public func register(_ cells: any ConfigurableUITableViewCell.Type...) {
        cells.forEach { register($0, forCellReuseIdentifier: $0.reuseID) }
    }
}

extension UITableView {
    /// Dequeues and configures a reusable cell in `UITableView`.
    public func dequeueAndConfigureReusableCell(
        parameter: any UITableViewCellParameter
    ) -> UITableViewCell {
        guard
            let cell = dequeueReusableCell(withIdentifier: parameter.reuseID) as? any ConfigurableUITableViewCell
        else {
            Logger.misc.critical("Unable to dequeue 'ConfigurableUITableViewCell' with identifier '\(parameter.reuseID)' in 'UITableView.dequeueAndConfigureReusableCell(parameter:)'")
            return UITableViewCell()
        }
        
        cell.configure(parameter: parameter)
        
        return cell
    }
}

#endif
