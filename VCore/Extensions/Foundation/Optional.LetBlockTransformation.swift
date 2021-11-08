//
//  Optional.LetBlockTransformation.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - Optional Let Block Transformation
extension Optional {
    /// Transforms wrapped value, or returns `nil`.
    public func `let`<T>(_ transform: (Wrapped) throws -> T?) rethrows -> T? {
        guard
            let self = self,
            let result: T = try transform(self)
        else {
            return nil
        }
        
        return result
    }
}
