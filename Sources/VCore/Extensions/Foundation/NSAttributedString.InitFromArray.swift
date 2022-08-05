//
//  NSAttributedString.InitFromArray.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12.07.22.
//

import Foundation

// MARK: - Attributed String Init from Array
extension NSAttributedString {
    /// Initializes `NSAttributedString` with sub `NSAttributedString`s.
    ///
    ///     let label: UILabel = .init()
    ///
    ///     label.attributedText = .init(attributedStrings: [
    ///         .init(
    ///             string: "Hello, ",
    ///             attributes: [
    ///                 NSAttributedString.Key.foregroundColor: UIColor.label as Any,
    ///                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13) as Any
    ///             ]
    ///         ),
    ///         .init(
    ///             string: "World",
    ///             attributes: [
    ///                 NSAttributedString.Key.foregroundColor: UIColor.label as Any,
    ///                 NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13) as Any
    ///             ]
    ///         )
    ///     ])
    ///
    convenience public init(attributedStrings: [NSAttributedString]) {
        self.init(attributedString: {
            let mutableAttributedString: NSMutableAttributedString = .init()
            attributedStrings.forEach { mutableAttributedString.append($0) }
            return mutableAttributedString
        }())
    }
}
