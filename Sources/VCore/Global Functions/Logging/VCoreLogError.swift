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
    module: String = "VCore",
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
#if DEBUG
    let description: String = {
        let descriptions: [String] = items.map { item in
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
        
        var description: String = descriptions.joined(separator: ". ")
        
        if description.last != "." { description.append(".") }
        description = description.replacingOccurrences(of: ".. ", with: ". ")
        
        return description
    }()
    
    let file: String = file.components(separatedBy: "/").last ?? file
    
    NSLog("[\(module)] Error in \(function) in \(file)(\(line)): \(description)")
#endif
}

// MARK: - V Core Fatal Error
/// Logs an error message to the Apple System Log facility and stops execution.
///
///     VCoreFatalError(error)
///
public func VCoreFatalError(
    _ items: Any...,
    module: String = "VCore",
    file: String = #file,
    line: Int = #line,
    function: String = #function
) -> Never {
    VCoreLogError(items, module: module, file: file, line: line, function: function)
    fatalError()
}
