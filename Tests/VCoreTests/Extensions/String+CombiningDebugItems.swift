//
//  String+CombiningDebugItems.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 12.02.24.
//

import Foundation

// MARK: - String + Combining Debug Items
extension String {
    static func combiningDebugItems(
        _ items: Any...
    ) -> String {
        let messages: [String] = items
            .map { item in
                switch item {
                case let string as String:
                    return string

                case let error as Error:
                    return (error as NSError).localizedDescription

                default:
                    return String(describing: item)
                }
            }
            .compactMap { $0.nonEmptyOrWhiteSpace }

        var result: String = messages.joined(separator: ". ")
        if messages.count > 1 {
            if result.last != "." { result.append(".") }
            result = result.replacingOccurrences(of: ".. ", with: ". ")
        }

        return result
    }
}
