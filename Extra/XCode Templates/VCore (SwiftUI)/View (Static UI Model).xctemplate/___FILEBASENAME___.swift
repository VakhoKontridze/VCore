//  ___FILEHEADER___

import SwiftUI

// MARK: - ___VARIABLE_productName___
struct ___VARIABLE_productName___: View {
    // MARK: Properties
    private typealias UIModel = ___VARIABLE_productName___UIModel
    
    private let parameters: ___VARIABLE_productName___Parameters
    
    // MARK: Initializers
    init(parameters: ___VARIABLE_productName___Parameters) {
        self.parameters = parameters
    }
    
    // MARK: Body
    var body: some View {
        EmptyView()
            .background(content: { UIModel.Colors.background.ignoresSafeArea() })
    }
}

// MARK: - Preview
struct ___VARIABLE_productName____Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___(parameters: .mock)
            .previewLayout(.sizeThatFits)
    }
}
