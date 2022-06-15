//  ___FILEHEADER___

import UIKit
import VCore

// MARK: - ___VARIABLE_productName___ Cell
final class ___VARIABLE_productName___Cell: UICollectionViewCell, UICollectionViewDequeueable {
    // MARK: Subviews
    
    // MARK: Properties
    private typealias Model = ___VARIABLE_productName___CellModel

    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        backgroundColor = Model.Colors.background
    }
    
    private func addSubviews() {
        
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
        
        ])
    }

    // MARK: Dequeueable
    func configure(viewModel: any UICollectionViewCellViewModelable) {
        guard let viewModel = viewModel as? ___VARIABLE_productName___CellViewModel else { return }
    }
}
