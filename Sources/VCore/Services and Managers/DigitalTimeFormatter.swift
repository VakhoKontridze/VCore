//
//  DigitalTimeFormatter.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - Digital Time Formatter
/// Digital time formatter that formats seconds to day, hour, minute, and second format.
///
/// You can configure to formatter by setting flags to change behavior, such as component visibility
/// or delimiter.
///
///     let formatter: DigitalTimeFormatter = .init()
///
///     formatter.string(from: 0) // "0:00"
///     formatter.string(from: 1) // "0:01"
///     formatter.string(from: 91) // "1:31"
///     formatter.string(from: 536) // "8:56"
///     formatter.string(from: 2336) // "38:56"
///     formatter.string(from: 7248) // "2:00:48"
///     formatter.string(from: 51888) // "14:24:48"
///     formatter.string(from: 95048) // "1:02:24:08"
///     formatter.string(from: 905048) // "10:11:24:08"
///     formatter.string(from: 8553600) // "99:00:00:00"
///
public struct DigitalTimeFormatter {
    // MARK: Properties - Delimiter
    /// Component delimiter. Set to `:`.
    public var delimiter: String = ":"

    // MARK: Properties - Digits
    /// Indicates if hour component in has two digits, assuming that day component is absent. Set to `false`.
    public var hourComponentHasTwoDigits: Bool = false
    
    /// Indicates if minute component has two digits, assuming that minute component is absent. Set to `false`.
    public var minuteComponentHasTwoDigits: Bool = false
    
    /// Indicates if second component has two digits, assuming that second component is absent. Set to `true`.
    ///
    /// `minuteComponentIsIncludedIfOnlySecondComponentIsIncluded` must be set to false.
    public var secondComponentHasTwoDigits: Bool = true

    // MARK: Properties - Misc
    /// Indicates if empty significant components are included. Set to `false`.
    ///
    /// For instance, if hour, minute, and second components are present, and hour is 0, "MM:SS" will be used instead of "00:MM:SS" if set to `false`.
    public var emptySignificantComponentsAreIncluded: Bool = false
    
    /// Indicates if minute component is visible if only second component exists. Set to `true`.
    public var minuteComponentIsIncludedIfOnlySecondComponentIsIncluded: Bool = true

    // MARK: Initializers
    /// Initializes `DigitalTimeFormatter`.
    public init() {}
    
    // MARK: Formatting
    /// Returns `String` from seconds with specified format.
    public func string(from seconds: Int) -> String? {
        guard seconds >= 0 else { return nil }

        let (d, h, m, s) = extractTimeComponents(from: seconds)

        if d > 0 {
            return String(format: "%d\(delimiter)%02d\(delimiter)%02d\(delimiter)%02d", d, h, m, s)
        }

        if h > 0 {
            if emptySignificantComponentsAreIncluded {
                return String(format: "0\(delimiter)%02d\(delimiter)%02d\(delimiter)%02d", h, m, s)
            }

            if hourComponentHasTwoDigits {
                return String(format: "%02d\(delimiter)%02d\(delimiter)%02d", h, m, s)
            } else {
                return String(format: "%d\(delimiter)%02d\(delimiter)%02d", h, m, s)
            }
        }

        if m > 0 {
            if emptySignificantComponentsAreIncluded {
                return String(format: "0\(delimiter)00\(delimiter)%02d\(delimiter)%02d", m, s)
            }

            if minuteComponentHasTwoDigits {
                return String(format: "%02d\(delimiter)%02d", m, s)
            } else {
                return String(format: "%d\(delimiter)%02d", m, s)
            }
        }

        if s >= 0 {
            if emptySignificantComponentsAreIncluded {
                return String(format: "0\(delimiter)00\(delimiter)00\(delimiter)%02d", s)
            }

            if minuteComponentIsIncludedIfOnlySecondComponentIsIncluded {
                if minuteComponentHasTwoDigits {
                    return String(format: "00\(delimiter)%02d", s)
                } else {
                    return String(format: "0\(delimiter)%02d", s)
                }
            }

            if secondComponentHasTwoDigits {
                return String(format: "%02d", s)
            } else {
                return String(format: "%d", s)
            }
        }

        return nil
    }

    /// Returns `String` from seconds with specified format.
    public func string(from seconds: Double) -> String? {
        let seconds: Int = .init(seconds.rounded(.toNearestOrAwayFromZero))

        return string(from: seconds)
    }
    
    // MARK: Time Components
    private func extractTimeComponents(
        from seconds: Int
    ) -> (d: Int, h: Int, m: Int, s: Int) {
        var seconds = seconds
        
        let result1 = seconds.quotientAndRemainder(dividingBy: 86_400)
        var d: Int = result1.quotient
        seconds = result1.remainder

        let result2 = seconds.quotientAndRemainder(dividingBy: 3_600)
        var h: Int = result2.quotient
        seconds = result2.remainder

        let result3 = seconds.quotientAndRemainder(dividingBy: 60)
        var m: Int = result3.quotient
        seconds = result3.remainder

        var s: Int = seconds

        if s == 60 { s = 0; m += 1 }
        if m == 60 { m = 0; h += 1 }
        if h == 24 { h = 0; d += 1 }

        return (d, h, m, s)
    }
}
