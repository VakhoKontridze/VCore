//  ___FILEHEADER___

import SwiftUI

// MARK: - ___VARIABLE_productName___
struct ___VARIABLE_productName___: View {
    // MARK: Properties - UI Model
    private let uiModel: ___VARIABLE_productName___UIModel

    // MARK: Properties - Data
    private let parameters: ___VARIABLE_productName___Parameters

    // MARK: Properties - ???
    // ...

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
            .background(content: { uiModel.backgroundColor })
    }
}

// MARK: - Preview
#if DEBUG

#Preview(body: {
    ___VARIABLE_productName___(parameters: .mock)
})

#endif
