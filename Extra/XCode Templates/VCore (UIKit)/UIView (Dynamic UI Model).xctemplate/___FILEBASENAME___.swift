//  ___FILEHEADER___

import UIKit
import VCore

// MARK: - ___VARIABLE_productName___
final class ___VARIABLE_productName____: UIView {
    // MARK: Subviews
    
    // MARK: Properties
    private var uiModel: ___VARIABLE_productName____UIModel
    
    // MARK: Initializers
    init(
        uiModel: ___VARIABLE_productName____UIModel = .init()
    ) {
        self.uiModel = uiModel
        super.init(frame: .zero)
        setUp()
        configure(uiModel: uiModel)
    }
    
    convenience init(
        uiModel: ___VARIABLE_productName____UIModel = .init(),
        parameters: ___VARIABLE_productName____Parameters
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
    func configure(uiModel: ___VARIABLE_productName____UIModel) {
        self.uiModel = uiModel
    }
    
    // MARK: Configuration - Parameters
    func configure(parameters: ___VARIABLE_productName____Parameters) {
        
    }
}