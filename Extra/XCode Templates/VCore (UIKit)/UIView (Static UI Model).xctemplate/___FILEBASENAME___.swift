//  ___FILEHEADER___

import UIKit
import VCore

// MARK: - ___VARIABLE_productName___
final class ___VARIABLE_productName___: UIView {
    // MARK: Subviews
    // ...
    
    // MARK: Properties
    private typealias UIModel = ___VARIABLE_productName___UIModel
    
    // MARK: Initializers
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    convenience init(parameters: ___VARIABLE_productName___Parameters) {
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
        backgroundColor = UIModel.backgroundColor
    }
    
    private func addSubviews() {
        // ...
    }
    
    private func setUpLayout() {
        NSLayoutConstraint.activate([
            // ...
        ])
    }
    
    // MARK: Configuration
    func configure(parameters: ___VARIABLE_productName___Parameters) {
        // ...
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    ___VARIABLE_productName___()
})

#endif
