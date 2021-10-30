//  ___FILEHEADER___

import UIKit

// MARK: - ___VARIABLE_productName___ View
final class ___VARIABLE_productName___View: UIView {
    // MARK: Subviews
    
    // MARK: Properties
    private var model: ___VARIABLE_productName___Model
    
    // MARK: Initializers
    init(
        model: ___VARIABLE_productName___Model
    ) {
        self.model = model
        super.init(frame: .zero)
        setUp()
        configure(with: model)
    }
    
    convenience init(
        model: ___VARIABLE_productName___Model,
        viewModel: ___VARIABLE_productName___ViewModel
    ) {
        self.init(model: model)
        configure(with: viewModel)
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
        backgroundColor = model.colors.background
    }
    
    private func addSubviews() {
        
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
        
        ])
    }

    // MARK: Configuration - Model
    func configure(with model: ___VARIABLE_productName___Model) {
        self.model = model
    }
    
    // MARK: Configuration - ViewModel
    func configure(with viewModel: ___VARIABLE_productName___ViewModel) {
        
    }
}
