//  
//  PostsViewController.swift
//  UIKit Viper Demo
//
//  Created by Vakhtang Kontridze on 17.06.22.
//

import UIKit

// MARK: - Posts View Controller
final class PostsViewController:
    UIViewController, PostsViewable, PostsNavigable,
    UITableViewDelegate, UITableViewDataSource
{
    // MARK: Subviews
    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self)
        tableView.refreshControl = tableRefreshControl
        return tableView
    }()
    
    private lazy var tableRefreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = .init()
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = initActivityIndicator()

    // MARK: Properties
    var presenter: (any PostsPresentable)!
    
    private typealias UIModel = PostsUIModel

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter.viewDidLoad()
    }

    // MARK: Setup
    private func setUp() {
        setUpView()
        addSubviews()
        setUpLayout()
        setUpNavBar()
    }
    
    private func setUpView() {
        view.backgroundColor = UIModel.Colors.background
    }

    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpNavBar() {
        navigationItem.title = "Posts"
    }

    // MARK: Viewable
    func reloadPosts() {
        tableView.reloadData()
    }
    
    func setPullToRefreshVisibility(to isVisible: Bool) {
        switch isVisible {
        case false: tableRefreshControl.endRefreshing()
        case true: tableRefreshControl.beginRefreshing()
        }
    }

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
    
    // MARK: Refresh Control
    @objc private func refreshTable(sender: UIRefreshControl) {
        presenter.didPullToRefresh()
    }
}
