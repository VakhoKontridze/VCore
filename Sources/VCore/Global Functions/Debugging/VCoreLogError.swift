//
//  VCoreLogError.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.09.22.
//

import Foundation

// MARK: - V Core Log Error
/// Logs an error message to the Apple System Log facility.
///
///     VCoreLogError(error)
///
public func VCoreLogError(
    _ items: Any...,
    dsohandle: UnsafeRawPointer = #dsohandle,
    file: String = #file,
    line: UInt = #line,
    function: String = #function
) {
#if DEBUG
    let module: String = moduleDescription(
        dsohandle: dsohandle
    )

    let callSite: String = callSiteDescription(
        file: file,
        line: line,
        function: function
    )

    let message: String = {
        let messages: [String] = items.map { item in
            switch item {
            case let error as Error:
                if let error = error as? VCoreError {
                    return error.localizedDescription
                } else {
                    return (error as NSError).debugDescription
                }
                
            case let string as String:
                return string
                
            default:
                return String(describing: item)
            }
        }
        
        var message: String = messages.joined(separator: ". ")
        
        if messages.count > 1 {
            if message.last != "." { message.append(".") }
            message = message.replacingOccurrences(of: ".. ", with: ". ")
        }

        return message
    }()

    NSLog("[\(module)] Error in '\(callSite)': \(message)")
#endif
}
