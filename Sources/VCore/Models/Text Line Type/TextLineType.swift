//
//  TextLineType.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 17.08.22.
//

import SwiftUI

// MARK: - Text Line Type
/// Model that represents text line, such as `singleLine` or `multiLine`.
@available(iOS 16.0, *)
@available(macOS 13.0, *)
@available(tvOS 16.0, *)
@available(watchOS 9.0, *)
public struct TextLineType {
    // MARK: Properties
    private let _textLineType: _TextLineType
    
    /// `TextAlignment`.
    public var textAlignment: TextAlignment? {
        switch _textLineType {
        case .singleLine:
            return nil
            
        case .multiLine(let alignment, _):
            return alignment
        }
    }
    
    /// `TextLineLimitType`.
    public var textLineLimitType: TextLineLimitType {
        switch _textLineType {
        case .singleLine:
            return .fixed(lineLimit: 1)
            
        case .multiLine(_, let textLineLimitType):
            return textLineLimitType
        }
    }
    
    // MARK: Initializers
    private init(
        textLineType: _TextLineType
    ) {
        self._textLineType = textLineType
    }
    
    /// Single-line.
    public static var singleLine: Self {
        .init(textLineType: .singleLine)
    }
    
    /// Multi-line.
    public static func multiLine(
        alignment: TextAlignment,
        lineLimit: Int?
    ) -> Self {
        .init(textLineType: .multiLine(
            alignment: alignment,
            textLineLimitType: .fixed(lineLimit: lineLimit)
        ))
    }
    
    /// Multi-line.
    public static func multiLine(
        alignment: TextAlignment,
        lineLimit: Int,
        reservesSpace: Bool
    ) -> Self {
        .init(textLineType: .multiLine(
            alignment: alignment,
            textLineLimitType: .spaceReserved(lineLimit: lineLimit, reservesSpace: reservesSpace)
        ))
    }
    
    /// Multi-line.
    public static func multiLine(
        alignment: TextAlignment,
        lineLimit: PartialRangeFrom<Int>
    ) -> Self {
        .init(textLineType: .multiLine(
            alignment: alignment,
            textLineLimitType: .partialRangeFrom(lineLimit: lineLimit)
        ))
    }
    
    /// Multi-line.
    public static func multiLine(
        alignment: TextAlignment,
        lineLimit: PartialRangeThrough<Int>
    ) -> Self {
        .init(textLineType: .multiLine(
            alignment: alignment,
            textLineLimitType: .partialRangeThrough(lineLimit: lineLimit)
        ))
    }
    
    /// Multi-line.
    public static func multiLine(
        alignment: TextAlignment,
        lineLimit: ClosedRange<Int>
    ) -> Self {
        .init(textLineType: .multiLine(
            alignment: alignment,
            textLineLimitType: .closedRange(lineLimit: lineLimit)
        ))
    }
}

// MARK: - _ V Text Type
@available(iOS 16.0, *)
@available(macOS 13.0, *)
@available(tvOS 16.0, *)
@available(watchOS 9.0, *)
enum _TextLineType {
    case singleLine
    case multiLine(alignment: TextAlignment, textLineLimitType: TextLineLimitType)
}
