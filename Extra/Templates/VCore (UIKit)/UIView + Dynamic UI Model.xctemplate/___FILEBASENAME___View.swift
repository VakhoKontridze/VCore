//  ___FILEHEADER___

import UIKit

// MARK: - ___VARIABLE_productName___ View
final class ___VARIABLE_productName___View: UIView {
    // MARK: Subviews
    
    // MARK: Properties
    private var uiModel: ___VARIABLE_productName___ViewUIModel
    
    // MARK: Initializers
    init(
        uiModel: ___VARIABLE_productName___ViewUIModel = .init()
    ) {
        self.uiModel = uiModel
        super.init(frame: .zero)
        setUp()
        configure(uiModel: uiModel)
    }
    
    convenience init(
        uiModel: ___VARIABLE_productName___ViewUIModel = .init(),
        parameters: ___VARIABLE_productName___ViewParameters
    ) {
        self.init(uiModel: uiModel)
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
        backgroundColor = uiModel.colors.background
    }
    
    private func addSubviews() {
        
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
        
        ])
    }

    // MARK: Configuration - UI Model
    func configure(uiModel: ___VARIABLE_productName___ViewUIModel) {
        self.uiModel = uiModel
    }
    
    // MARK: Configuration - Paramameters
    func configure(parameters: ___VARIABLE_productName___ViewParameters) {
        
    }
}
