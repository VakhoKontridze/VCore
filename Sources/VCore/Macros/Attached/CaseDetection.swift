//
//  CaseDetection.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 07.01.24.
//

import Foundation

// MARK: - Case Detection
/// Adds computed properties to an `enum` to represent each `case`.
///
///     @CaseDetection
///     enum PointPixelMeasurement {
///         case points(displayScale: Int)
///         case pixels
///     }
///
///     let measurement: PointPixelMeasurement = .points(displayScale: 3)
///     measurement.isPoints // true
///
@attached(member, names: arbitrary)
public macro CaseDetection(
    accessLevelModifier: String = "internal"
) = #externalMacro(
    module: "VCoreMacros",
    type: "CaseDetectionMacro"
)
