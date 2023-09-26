//
//  ViewResetterOO.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 13.04.23.
//

import Foundation

// MARK: - View Resetter (Observable Object)
/// Object inside the environment of `ViewResettingContainerOO` to trigger view resets on demand.
///
/// For additional info, refer to `ViewResettingContainerOO`.
public final class ViewResetterOO: ObservableObject {
    // MARK: Properties
    @Published private(set) var value: Int = 0
    
    // MARK: Initializers
    init() {}
    
    // MARK: Trigger
    /// Triggers reset inside `ViewResettingContainerOO`.
    public func trigger() {
        value += 1
    }
    
    // MARK: Callable Object
    /// Triggers reset inside `ViewResettingContainerOO`.
    public func callAsFunction() {
        trigger()
    }
}
