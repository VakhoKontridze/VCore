//
//  BaseButtonState.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 12/26/21.
//

#if canImport(UIKit) && !os(watchOS)

import Foundation

/// Enumeration that represents state.
@available(tvOS, unavailable)
public typealias UIKitBaseButtonState = GenericState_EnabledDisabled

/// Enumeration that represents state.
@available(tvOS, unavailable)
public typealias UIKitBaseButtonInternalState = GenericState_EnabledPressedDisabled

#endif
