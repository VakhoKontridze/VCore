//  ___FILEHEADER___

import SwiftUI

// MARK: - ___VARIABLE_productName___
struct ___VARIABLE_productName___: View {
    // MARK: Properties
    private var uiModel: ___VARIABLE_productName___UIModel
    
    private let parameters: ___VARIABLE_productName___Parameters
    
    // MARK: Initializers
    init(
        uiModel: ___VARIABLE_productName___UIModel = .init(),
        parameters: ___VARIABLE_productName___Parameters
    ) {
        self.uiModel = uiModel
        self.parameters = parameters
    }
    
    // MARK: Body
    var body: some View {
        EmptyView()
            .background(content: { uiModel.backgroundColor.ignoresSafeArea() })
    }
}

// MARK: - Preview
struct ___VARIABLE_productName____Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___(parameters: .mock)
            .previewLayout(.sizeThatFits)
    }
}
