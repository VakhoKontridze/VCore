//
//  InfiniteScrollingHelpers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/21/21.
//

import UIKit

// MARK: - Scroll Detection
extension UIScrollView {
    func didScrollToBottom(offset: CGFloat) -> Bool {
        guard contentOffset.y > 0 else { return false }
        
        let didScrollToBottom: Bool =
            contentOffset.y + frame.size.height >=
            contentSize.height - offset
        
        return didScrollToBottom
    }
    
    var contentHeightExceedsTableViewHeight: Bool {
        contentSize.height > frame.size.height
    }
    
    var contentHeightExceedsCollectionViewHeight: Bool {
        contentSize.height > frame.size.height
    }
}
