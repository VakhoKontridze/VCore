//  ___FILEHEADER___

import UIKit
import VCore

// MARK: - ___VARIABLE_productName___ View
final class ___VARIABLE_productName___View: UIView {
    // MARK: Subviews
    
    // MARK: Properties
    private typealias UIModel = ___VARIABLE_productName___ViewUIModel
    
    // MARK: Initializers
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    convenience init(parameters: ___VARIABLE_productName___ViewParameters) {
        self.init()
        configure(parameters: parameters)
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

    // MARK: Configuration
    func configure(parameters: ___VARIABLE_productName___ViewParameters) {
        
    }
}
