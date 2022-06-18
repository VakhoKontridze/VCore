//  ___FILEHEADER___

import UIKit

// MARK: - ___VARIABLE_productName___ View Controller
final class ___VARIABLE_productName___ViewController: UIViewController, ___VARIABLE_productName___Viewable, ___VARIABLE_productName___Navigable {
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
        setUpNavBar()
    }
    
    private func setUpView() {
        view.backgroundColor = UIModel.Colors.background
    }

    private func addSubviews() {
        view.addSubview(activityIndicator)
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func setUpNavBar() {
        navigationItem.title = "___VARIABLE_productName___"
    }

    // MARK: Viewable

    // MARK: Navigable

}
