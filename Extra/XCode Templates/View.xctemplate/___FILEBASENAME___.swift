//  ___FILEHEADER___

import SwiftUI

struct ___VARIABLE_productName___: View {
    // MARK: Properties - Model Injection
    // ...

    // MARK: Properties - Appearance
    private let appearance: ___VARIABLE_productName___Appearance

    // MARK: Properties - Parameters
    private let parameters: ___VARIABLE_productName___Parameters

    // MARK: Properties - ???
    // ...

    // MARK: Initializers
    init(
        appearance: ___VARIABLE_productName___Appearance = .init(),
        parameters: ___VARIABLE_productName___Parameters
    ) {
        self.appearance = appearance
        self.parameters = parameters
    }
    
    // MARK: Body
    var body: some View {
        EmptyView()
            .background(appearance.backgroundColor)
    }
}

#if DEBUG

#Preview {
    ___VARIABLE_productName___(parameters: .mock)
}

#endif
