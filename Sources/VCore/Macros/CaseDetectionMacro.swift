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
///     enum PointPixelMeasurement {
///         case points(displayScale: CGFloat)
///         case pixels
///     }
///
///     let measurement: PointPixelMeasurement = ...
///     measurement.isPoints // true
///
@attached(member, names: arbitrary)
public macro CaseDetection(
    accessLevelModifier: String = "internal"
) = #externalMacro(
    module: "VCoreMacros",
    type: "CaseDetectionMacro"
)
