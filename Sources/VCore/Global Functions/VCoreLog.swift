//
//  VCoreLog.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11.09.22.
//

import Foundation

// MARK: - V Core Log
/// Logs an error message to the Apple System Log facility.
public func VCoreLog(
    _ items: Any...,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
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
                return .init(describing: item)
            }
        }
        
        var description: String = descriptions.joined(separator: ". ")
        
        if description.last != "." { description.append(".") }
        description = description.replacingOccurrences(of: ".. ", with: ". ")
        
        return description
    }()
    
    let file: String = file.components(separatedBy: "/").last ?? file
    
    NSLog("VCore error in \(file) at line \(line). \(description)")
}
