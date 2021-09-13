//
//  LogicalExclusiveOr.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/13/21.
//

import Foundation

// MARK:- Logical Exlusive Or
/// Exlsuive or logical operator
infix operator ^^

/// Exlsuive or logical operator
public func ^^(lhs: Bool, rhs: Bool) -> Bool {
    lhs != rhs
}
