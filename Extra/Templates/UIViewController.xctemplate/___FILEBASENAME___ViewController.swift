//  ___FILEHEADER___

import UIKit

// MARK: - ___VARIABLE_productName___ View Controller
final class ___VARIABLE_productName___ViewController: UIViewController, ___VARIABLE_productName___Viewable, ___VARIABLE_productName___Navigable {
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

    // MARK: Navigable

}
