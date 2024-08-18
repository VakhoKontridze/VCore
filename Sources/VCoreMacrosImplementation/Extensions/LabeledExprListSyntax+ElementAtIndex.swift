//
//  LabeledExprListSyntax+ElementAtIndex.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import SwiftSyntax

// MARK: - Labeled Expr List Syntax + Element at Index
extension LabeledExprListSyntax {
    func element(at index: Int) -> Element? {
        let index: SyntaxChildrenIndex = self.index(startIndex, offsetBy: index)

        guard indices.contains(index) else { return nil }

        return self[index]
    }
}
