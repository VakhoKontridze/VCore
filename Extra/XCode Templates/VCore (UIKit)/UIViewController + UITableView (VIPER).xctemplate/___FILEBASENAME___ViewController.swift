//  ___FILEHEADER___

import UIKit
import VCore

// MARK: - ___VARIABLE_productName___ View Controller
final class ___VARIABLE_productName___ViewController:
    UIViewController, ___VARIABLE_productName___Viewable, ___VARIABLE_productName___Navigable,
    UITableViewDelegate, UITableViewDataSource
{
    // MARK: Subviews
    lazy var activityIndicator: UIActivityIndicatorView = initActivityIndicator()
    
    // MARK: Properties
    var presenter: (any ___VARIABLE_productName___Presentable)!
    
    private typealias UIModel = ___VARIABLE_productName___UIModel
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: Setup
    private func setUp() {
        setUpView()
        addSubviews()
        setUpLayout()
        setUpNavigationBar()
    }
    
    private func setUpView() {
        view.backgroundColor = UIModel.backgroundColor
    }
    
    private func addSubviews() {
        view.addSubview(activityIndicator)
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func setUpNavigationBar() {
        navigationItem.title = "___VARIABLE_productName___"
    }
    
    // MARK: Viewable
    
    // MARK: Navigable
    
    // MARK: Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tableViewDidSelectRow(section: indexPath.section, row: indexPath.row)
    }
    
    // MARK: Table View DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.tableViewNumberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.tableViewNumberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueAndConfigureReusableCell(
            parameter: presenter.tableViewCellParameter(section: indexPath.section, row: indexPath.row)
        )
    }
}
