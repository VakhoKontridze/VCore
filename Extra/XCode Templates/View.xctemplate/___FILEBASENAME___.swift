//  ___FILEHEADER___

import SwiftUI

// MARK: - ___VARIABLE_productName___
struct ___VARIABLE_productName___: View {
    // MARK: Properties - Model Injection
    // ...

    // MARK: Properties - UI Model
    private let uiModel: ___VARIABLE_productName___UIModel

    // MARK: Properties - Parameters
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
            .background { uiModel.backgroundColor }
    }
}

// MARK: - Preview
#if DEBUG

#Preview {
    ___VARIABLE_productName___(parameters: .mock)
}

#endif
