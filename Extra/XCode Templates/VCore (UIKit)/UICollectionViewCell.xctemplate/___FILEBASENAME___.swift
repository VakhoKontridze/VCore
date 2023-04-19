//  ___FILEHEADER___

import UIKit
import VCore

// MARK: - ___VARIABLE_productName___
final class ___VARIABLE_productName___: UICollectionViewCell, ConfigurableUICollectionViewCell {
    // MARK: Subviews
    
    // MARK: Properties
    private typealias UIModel = ___VARIABLE_productName___UIModel
    
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
        backgroundColor = UIModel.Colors.background
    }
    
    private func addSubviews() {
        
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            
        ])
    }
    
    // MARK: Configurable Collection View Cell
    func configure(parameter: some UICollectionViewCellParameter) {
        guard let parameters = parameter as? ___VARIABLE_productName___Parameters else { return }
    }
}
