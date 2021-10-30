//  ___FILEHEADER___

import UIKit

// MARK: - ___VARIABLE_productName___ View Controller
final class ___VARIABLE_productName___ViewController: UIViewController, ___VARIABLE_productName___Viewable, ___VARIABLE_productName___Navigatable, UITableViewDelegate, UITableViewDataSource {
    // MARK: Subviews
    lazy var activityIndicator: UIActivityIndicatorView = initActivityIndicator()

    // MARK: Properties
    var presenter: ___VARIABLE_productName___Presentable!
    
    private typealias Model = ___VARIABLE_productName___Model

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    // MARK: Setup
    private func setUp() {
        setUpView()
        setUpNavBar()
        addSubviews()
        setUpLayout()
    }
    
    private func setUpView() {
        view.backgroundColor = Model.Colors.background
    }

    private func setUpNavBar() {
        navigationItem.title = "___VARIABLE_productName___"
    }

    private func addSubviews() {
        view.addSubview(activityIndicator)
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            
        ])
    }

    // MARK: Viewable

    // MARK: Navigatable

    // MARK: Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tableViewDidSelectRow(section: indexPath.section, row: indexPath.row)
    }

    // MARK: Table View DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.tableViewNumberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.tableViewNumberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueAndConfigureReusableCell(
            dequeueID: presenter.tableViewCellDequeueID(section: indexPath.section, row: indexPath.row),
            viewModel: presenter.tableViewCellViewModel(section: indexPath.section, row: indexPath.row)
        )
    }
}
