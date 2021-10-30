//  ___FILEHEADER___

import UIKit

// MARK: - ___VARIABLE_productName___ View
final class ___VARIABLE_productName___View: UIView {
    // MARK: Subviews
    
    // MARK: Properties
    private typealias Model = ___VARIABLE_productName___Model
    
    // MARK: Initializers
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    convenience init(viewModel: ___VARIABLE_productName___ViewModel) {
        self.init()
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
        backgroundColor = Model.Colors.background
    }
    
    private func addSubviews() {
        
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
        
        ])
    }

    // MARK: Configuration
    func configure(with viewModel: ___VARIABLE_productName___ViewModel) {
        
    }
}
