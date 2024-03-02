//
//  StringLiteralSegmentListSyntaxElement.TypeCasts.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import SwiftSyntax

// MARK: - String Literal Segment List Syntax Element Type Casts
extension StringLiteralSegmentListSyntax.Element {
    func toStringSegmentGetAssociatedValue() -> StringSegmentSyntax? {
        if case .stringSegment(let stringSegmentSyntax) = self {
            stringSegmentSyntax
        } else {
            nil
        }
    }
}
