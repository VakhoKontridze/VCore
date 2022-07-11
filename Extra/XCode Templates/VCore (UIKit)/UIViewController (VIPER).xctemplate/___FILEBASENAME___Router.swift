//  ___FILEHEADER___

import Foundation

// MARK: - ___VARIABLE_productName___ Router
final class ___VARIABLE_productName___Router<Navigator>: ___VARIABLE_productName___Routable
    where Navigator: ___VARIABLE_productName___Navigable
{
    // MARK: Properties
    private unowned let navigator: Navigator

    // MARK: Initializers
    init(
        navigator: Navigator
    ) {
        self.navigator = navigator
    }

    // MARK: Routable
}
