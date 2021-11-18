//  ___FILEHEADER___

import UIKit
import VCore

// MARK: - ___VARIABLE_productName___ Cell
final class ___VARIABLE_productName___Cell: UICollectionViewCell, UICollectionViewDequeueable {
    // MARK: Subviews
    
    // MARK: Properties
    private typealias Model = ___VARIABLE_productName___CellModel

    // MARK: Lifecycle
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }

    // MARK: Setup
    private func setUp() {
        setUpView()
        addSubviews()
        setUpLayout()
    }
    
    private func setUpView() {
        contentView.backgroundColor = Model.Colors.background
    }
    
    private func addSubviews() {
        
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
        
        ])
    }

    // MARK: Configuration
    func configure(with viewModel: UICollectionViewCellViewModelable) {
        guard let viewModel = viewModel as? ___VARIABLE_productName___CellViewModel else { return }
    }
}
