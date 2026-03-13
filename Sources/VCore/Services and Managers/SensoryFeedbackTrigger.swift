//
//  SensoryFeedbackTrigger.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 03.08.25.
//

import SwiftUI

/// Allows for the trigger of sensory feedback without specifying underlying triggering types.
@MainActor
@Observable // Needed for trigger to work
public final class SensoryFeedbackTrigger {
    // MARK: Properties
    var value: Int = 0
    
    // MARK: Initializers
    /// Initializes `SensoryFeedbackTrigger`.
    public init() {}
    
    // MARK: Trigger
    /// Triggers a feedback.
    public func trigger() {
        value &+= 1
    }
    
    // MARK: Callable Object
    /// Triggers a feedback.
    public func callAsFunction() {
        trigger()
    }
}

extension View {
    /// Plays feedback when `SensoryFeedbackTrigger` is triggered.
    ///
    ///     @State private var sensoryFeedbackTrigger: SensoryFeedbackTrigger = .init()
    ///
    ///     var body: some View {
    ///         Button("Trigger") {
    ///             sensoryFeedbackTrigger.trigger()
    ///         }
    ///         .sensoryFeedback(.success, trigger: sensoryFeedbackTrigger)
    ///     }
    ///
    public func sensoryFeedback(
        _ feedback: SensoryFeedback,
        trigger: SensoryFeedbackTrigger
    ) -> some View {
        self
            .sensoryFeedback(feedback, trigger: trigger.value)
    }
}
