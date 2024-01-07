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
///     enum PixelPointMeasurement {
///         case pixel
///         case point(displayScale: CGFloat)
///     }
///
///     let measurement: PixelPointMeasurement = ...
///     measurement.isPoint // true
///
@attached(member, names: arbitrary)
public macro CaseDetection() = #externalMacro(
    module: "VCoreMacrosImplementation",
    type: "CaseDetectionMacro"
)
