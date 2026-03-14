//
//  InfiniteScrollingHelpers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

#if canImport(UIKit) && !os(watchOS)

import UIKit

extension UIScrollView {
    func didScrollToBottom(offset: CGFloat) -> Bool {
        guard contentOffset.y > 0 else { return false }
        
        let didScrollToBottom: Bool =
            contentOffset.y + frame.size.height >=
            contentSize.height - offset
        
        return didScrollToBottom
    }
    
    var contentHeightExceedsHeight: Bool {
        contentSize.height > frame.size.height
    }
}

#endif
