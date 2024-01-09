//
//  DebugHelpers.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 31.12.23.
//

import Foundation

// MARK: - Module Description
func moduleDescription(
    fileID: String = #fileID
) -> String {
    let module: String = fileID.components(separatedBy: "/").first ?? fileID

    return module
}

// MARK: - Call Site Description
func callSiteDescription(
    file: String,
    line: UInt
) -> String {
    let file: String = file.components(separatedBy: "/").last ?? file

    return "\(file):\(line)"
}

// MARK: - String Combining Debug Items
extension String {
    package static func combiningDebugItems(
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
