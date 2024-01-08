//
//  StringLiteralSegmentListSyntax.TypeCasts.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

import Foundation
import SwiftSyntax

// MARK: - String Literal Segment List Syntax Type Casts
extension StringLiteralSegmentListSyntax.Element {
    var stringSegmentAssociatedValue: StringSegmentSyntax? {
        if case .stringSegment(let stringSegmentSyntax) = self {
            stringSegmentSyntax
        } else {
            nil
        }
    }
}
