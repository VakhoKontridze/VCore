//
//  ViewResetter.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.04.23.
//

import Foundation

// MARK: - View Resetter
/// ViewModel placed inside the environment of `ViewResettingContainer`
/// to trigger view resets on demand.
///
/// For additional info, refer to `ViewResettingContainer`.
public final class ViewResetter: ObservableObject {
    // MARK: Properties
    @Published private(set) var value: Int = 0
    
    // MARK: Initializers
    init() {}
    
    // MARK: Trigger
    /// Triggers reset inside `ViewResettingContainer`.
    public func trigger() {
        value += 1
    }
    
    // MARK: Callable Object
    /// Triggers reset inside `ViewResettingContainer`.
    public func callAsFunction() {
        trigger()
    }
}
