//  ___FILEHEADER___

import Foundation

// MARK: - ___VARIABLE_productName___ Router
final class ___VARIABLE_productName___Router<Navigable>: ___VARIABLE_productName___Routable
    where Navigable: ___VARIABLE_productName___Navigable
{
    // MARK: Properties
    private unowned let navigable: Navigable

    // MARK: Initializers
    init(
        navigable: Navigable
    ) {
        self.navigable = navigable
    }

    // MARK: Routable
}
