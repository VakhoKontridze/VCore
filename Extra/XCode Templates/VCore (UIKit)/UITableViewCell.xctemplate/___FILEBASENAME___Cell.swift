//  ___FILEHEADER___

import UIKit
import VCore

// MARK: - ___VARIABLE_productName___ Cell
final class ___VARIABLE_productName___Cell: UITableViewCell, UITableViewDequeueable {
    // MARK: Subviews
    
    // MARK: Properties
    private typealias UIModel = ___VARIABLE_productName___CellUIModel

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
        backgroundColor = UIModel.Colors.background
        selectionStyle = .none
    }
    
    private func addSubviews() {
        
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
        
        ])
    }

    // MARK: Dequeueable
    func configure(parameter: any UITableViewCellParameter) {
        guard let parameters = parameter as? ___VARIABLE_productName___CellParameters else { return }
    }
}
