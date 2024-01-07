//
//  CaseDetectionMacro.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

import Foundation

// MARK: - Case Detection Macro
/// Adds computed properties to `enum` to represent each `case`.
///
///     @CaseDetection
///     enum RGBColor {
///         case red
///         case green
///         case blue
///     }
///
///     let value: RGBColor = ...
///     value.isRed // true
///
@attached(member, names: arbitrary)
public macro CaseDetection() = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CaseDetectionMacro"
)
