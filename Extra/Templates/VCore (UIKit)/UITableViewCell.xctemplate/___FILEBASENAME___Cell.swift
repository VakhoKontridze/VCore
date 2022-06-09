//  ___FILEHEADER___

import UIKit
import VCore

// MARK: - ___VARIABLE_productName___ Cell
final class ___VARIABLE_productName___Cell: UITableViewCell, UITableViewDequeueable {
    // MARK: Subviews
    
    // MARK: Properties
    private typealias Model = ___VARIABLE_productName___CellModel

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
        selectionStyle = .none
        backgroundColor = Model.Colors.background
    }
    
    private func addSubviews() {
        
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
        
        ])
    }

    // MARK: Configuration
    func configure(viewModel: UITableViewCellViewModelable) {
        guard let viewModel = viewModel as? ___VARIABLE_productName___CellViewModel else { return }
    }
}
