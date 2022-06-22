//  ___FILEHEADER___

import SwiftUI

// MARK: - ___VARIABLE_productName___ View
struct ___VARIABLE_productName___View: View {
    // MARK: Properties
    private var uiModel: ___VARIABLE_productName___ViewUIModel
    
    private let parameters: ___VARIABLE_productName___ViewParameters
    
    // MARK: Initializers
    init(
        uiModel: ___VARIABLE_productName___ViewUIModel = .init(),
        parameters: ___VARIABLE_productName___ViewParameters
    ) {
        self.uiModel = uiModel
        self.parameters = parameters
    }
    
    // MARK: Body
    var body: some View {
        EmptyView()
            .background(uiModel.colors.background.ignoresSafeArea())
    }
}

// MARK: - Preview
struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___View(parameters: .mock)
    }
}
