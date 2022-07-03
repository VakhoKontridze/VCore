//
//  LogicalExclusiveOr.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import Foundation

// MARK: - Logical Exclusive Or
/// Exclusive "or" logical operator.
infix operator ^^

/// Exclusive "or" logical operator.
public func ^^(lhs: Bool, rhs: Bool) -> Bool {
    lhs != rhs
}
