//  ___FILEHEADER___

import SwiftUI

// MARK: - ___VARIABLE_productName___ View
struct ___VARIABLE_productName___View: View {
    // MARK: Properties
    private typealias UIModel = ___VARIABLE_productName___ViewUIModel
    
    private let parameters: ___VARIABLE_productName___ViewParameters
    
    // MARK: Initializers
    init(parameters: ___VARIABLE_productName___ViewParameters) {
        self.parameters = parameters
    }
    
    // MARK: Body
    var body: some View {
        EmptyView()
            .background(content: { UIModel.Colors.background.ignoresSafeArea() })
    }
}

// MARK: - Preview
struct ___VARIABLE_productName___View_Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_productName___View(parameters: .mock)
            .previewLayout(.sizeThatFits)
    }
}
