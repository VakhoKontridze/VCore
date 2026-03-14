//  ___FILEHEADER___

import SwiftUI

struct ___VARIABLE_productName___: View {
    // MARK: Properties - Appearance
    private let appearance: ___VARIABLE_productName___Appearance

    // MARK: Properties - Parameters
    // ...

    // MARK: Properties - Dependencies
    // ...

    // MARK: Properties - ???
    // ...

    // MARK: Initializers
    init(
        appearance: ___VARIABLE_productName___Appearance = .init()
    ) {
        self.appearance = appearance
    }
    
    // MARK: Body
    var body: some View {
        EmptyView()
            .background(appearance.backgroundColor)
    }
}

#if DEBUG

#Preview {
    ___VARIABLE_productName___()
}

#endif
