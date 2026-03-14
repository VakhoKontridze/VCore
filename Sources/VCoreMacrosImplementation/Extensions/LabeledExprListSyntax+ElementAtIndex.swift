//
//  LabeledExprListSyntax+ElementAtIndex.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

#if !(os(iOS) || os(tvOS) || os(watchOS) || os(visionOS))

import Foundation
import SwiftSyntax

nonisolated extension LabeledExprListSyntax {
    func element(at index: Int) -> Element? {
        let index: SyntaxChildrenIndex = self.index(startIndex, offsetBy: index)

        guard indices.contains(index) else { return nil }

        return self[index]
    }
}

#endif
