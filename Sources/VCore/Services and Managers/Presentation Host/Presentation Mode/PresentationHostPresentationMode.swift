//
//  PresentationHostPresentationMode.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

import SwiftUI

// MARK: - Presentation Host Presentation Mode
/// Object embedded in environment of modals presented via Presentation Host.
///
/// Contains `dismiss` handler that can be called after internal dismissal to remove content from view hierarchy.
///
/// Also contains `isExternallyDismissed` that indicates if dismiss has been triggered via externally via code,
/// i.e., setting `isPresented` to `false`. When this change is triggered, internal dismiss animation can occur.
/// After which `externalDismissCompletion` handler must be called to remove content from view hierarchy.
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct PresentationHostPresentationMode {
    // MARK: Properties
    /// Indicates if `PresentationHostPresentationMode` is embedded via environment.
    ///
    /// Can be used to support both Presentation Host and `DismissAction` APIs.
    public let isValidConfiguration: Bool
    
    /// Instance ID of modal.
    public let id: String?
    
    /// Completion handler that dismisses modal.
    public let dismiss: () -> Void
    
    /// Indicates if external dismiss has been triggered externally.
    public let isExternallyDismissed: Bool
    
    /// Completion handler that dismisses modal after external trigger.
    ///
    /// Must be called after modal has been animated out.
    public let externalDismissCompletion: () -> Void
    
    // MARK: Initializers
    init(
        id: String,
        dismiss: @escaping () -> Void,
        isExternallyDismissed: Bool,
        externalDismissCompletion: @escaping () -> Void
    ) {
        self.isValidConfiguration = true
        self.id = id
        self.dismiss = dismiss
        self.isExternallyDismissed = isExternallyDismissed
        self.externalDismissCompletion = externalDismissCompletion
    }
    
    init() {
        self.isValidConfiguration = false
        self.id = nil
        self.dismiss = {}
        self.isExternallyDismissed = false
        self.externalDismissCompletion = {}
    }
}
