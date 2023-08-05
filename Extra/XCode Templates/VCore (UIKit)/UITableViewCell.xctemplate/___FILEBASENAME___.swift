//  ___FILEHEADER___

import UIKit
import VCore

// MARK: - ___VARIABLE_productName___
final class ___VARIABLE_productName___: UITableViewCell, ConfigurableUITableViewCell {
    // MARK: Subviews
    // ...
    
    // MARK: Properties
    private typealias UIModel = ___VARIABLE_productName___UIModel
    
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: Setup
    private func setUp() {
        setUpView()
        addSubviews()
        setUpLayout()
    }
    
    private func setUpView() {
        backgroundColor = UIModel.backgroundColor
        selectionStyle = .none
    }
    
    private func addSubviews() {
        // ...
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            // ...
        ])
    }
    
    // MARK: Configurable Table View Cell
    func configure(parameter: some UITableViewCellParameter) {
        guard let parameters = parameter as? ___VARIABLE_productName___Parameters else { return }

        // ...
    }
}
