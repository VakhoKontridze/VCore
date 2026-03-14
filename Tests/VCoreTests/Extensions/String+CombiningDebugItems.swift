//
//  String+CombiningDebugItems.swift
//  VCoreTests
//
//  Created by Vakhtang Kontridze on 12.02.24.
//

import Foundation

nonisolated extension String {
    static func combiningDebugItems(
        _ items: Any...
    ) -> String {
        let messages: [String] = items
            .map { item in
                switch item {
                case let string as String:
                    return string

                case let error as Error:
                    return error.localizedDescription

                default:
                    return String(describing: item)
                }
            }
            .compactMap { $0.nonEmptyOrWhiteSpace }

        var result: String = messages
            .map { $0.last == "." ? String($0.dropLast()) : $0 }
            .joined(separator: ". ")
        if !result.isEmpty { result.append(".") }

        return result
    }
}
