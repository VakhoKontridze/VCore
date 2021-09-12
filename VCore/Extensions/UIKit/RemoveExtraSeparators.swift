//
//  RemoveExtraSeparators.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import UIKit

// MARK:- Remove Extra Separators
extension UITableView {
    /// Removes extra separators by inserting a `tableFooterView` of height `0`
    public func removeExtraSeparators() {
        insertEmptyFooterView(height: 0)
    }
    
    /// Removes extra separators, as well as separator from last cell, by inserting a `tableFooterView` of height `0.1`
    public func removeExtraAndLastSeparators() {
        insertEmptyFooterView(height: 0.1)
    }
    
    private func insertEmptyFooterView(height: CGFloat) {
        tableFooterView = .init(frame: .init(
            origin: .zero,
            size: .init(width: frame.size.width, height: height)
        ))
    }
}
