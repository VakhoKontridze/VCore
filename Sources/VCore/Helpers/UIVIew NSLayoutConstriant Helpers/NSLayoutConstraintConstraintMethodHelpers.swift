//
//  NSLayoutConstraintConstraintMethodHelpers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.07.22.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

// MARK: - NS Layout Constraint Constraint Method Helpers
extension NSLayoutConstraint {
    convenience init(
        item view1: Any,
        attribute attribute1: Attribute,
        relatedBy relation: Relation,
        toItem view2: Any?,
        attribute attribute2: Attribute,
        multiplier: CGFloat,
        constant: CGFloat,
        priority: UILayoutPriority?
    ) {
        self.init(
            item: view1,
            attribute: attribute1,
            relatedBy: relation,
            toItem: view2,
            attribute: attribute2,
            multiplier: multiplier,
            constant: constant
        )
        
        if let priority = priority { self.priority = priority }
    }
}

extension UIView {
    func layoutItem(isSafe: Bool) -> Any {
        if isSafe {
            return safeAreaLayoutGuide
        } else {
            return self
        }
    }
}

#endif
