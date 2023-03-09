//
//  DigitalTimeFormatter.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - Digital Time Formatter
/// Digital time formatter.
///
/// You can configure to object by setting flags to change behavior, such as component visibility
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
    // MARK: Properties
    /// Indicates if empty components still show up as zeroes in format. Set to `false`.
    public var emptyComponentsShowAsZeroes: Bool = false
    
    /// Indicates if hour component in `HH:MM:SS` format shows two digits. Set to `false`.
    public var hourComponentHasTwoDigits: Bool = false
    
    /// Indicates if minute component in `MM:SS` format shows two digits. Set to `false`.
    public var minuteComponentHasTwoDigits: Bool = false
    
    /// Indicates if second component in `SS` format shows two digits. Set to `true`.
    ///
    /// `minuteComponentShowsIfSecondComponentShows` must be set to false.
    public var secondComponentHasTwoDigits: Bool = true
    
    /// Indicates if minute component is visible if only second component exists. Set to `true`.
    public var minuteComponentShowsIfSecondComponentShows: Bool = true
    
    /// Component delimiter. Set to `:`.
    public var delimiter: String = ":"
    
    // MARK: Initializers
    /// Initializes `DigitalTimeFormatter`.
    public init() {}

    // MARK: Formatting
    /// Returns `String` from seconds with specified format.
    public func string(from seconds: Double) -> String? {
        guard seconds >= 0 else { return nil }

        let (d, h, m, s) = extractTimeComponents(from: seconds)
        
        let formattedComponents: [String]? = {
            if d > 0 {
                return [.init(d), h.padded, m.padded, s.padded]
                
            } else if h > 0 {
                switch (emptyComponentsShowAsZeroes, hourComponentHasTwoDigits) {
                case (false, false): return [.init(h), m.padded, s.padded]
                case (false, true): return [h.padded, m.padded, s.padded]
                case (true, _): return ["0", h.padded, m.padded, s.padded]
                }
                
            } else if m > 0 {
                switch (emptyComponentsShowAsZeroes, minuteComponentHasTwoDigits) {
                case (false, false): return [.init(m), s.padded]
                case (false, true): return [m.padded, s.padded]
                case (true, _): return ["0", "00", m.padded, s.padded]
                }
                
            } else if s >= 0 {
                switch (emptyComponentsShowAsZeroes, minuteComponentShowsIfSecondComponentShows, minuteComponentHasTwoDigits, secondComponentHasTwoDigits) {
                case (false, false, _, false): return [.init(s)]
                case (false, false, _, true): return [s.padded]
                case (false, true, false, _): return ["0", s.padded]
                case (false, true, true, _): return ["00", s.padded]
                case (true, _, _, _): return ["0", "00", "00", s.padded]
                }

            } else {
                return nil
            }
        }()
        
        let formattedTime: String? = formattedComponents.map { $0.joined(separator: delimiter) }
        
        return formattedTime
    }

    // MARK: Time Components
    private func extractTimeComponents(from seconds: Double) -> (d: Int, h: Int, m: Int, s: Int) {
        var d: Int = {
            let remainder: Double = seconds
            
            return .init(remainder / TimeComponent.day.seconds)
        }()
        
        var h: Int = {
            let sInDay: Double = .init(d) * TimeComponent.day.seconds
            
            let remainder: Double = seconds - sInDay
            
            return .init(remainder / TimeComponent.hour.seconds)
        }()
        
        var m: Int = {
            let sInDay: Double = .init(d) * TimeComponent.day.seconds
            let sInHour: Double = .init(h) * TimeComponent.hour.seconds
            
            let remainder: Double = seconds - sInDay - sInHour
            
            return .init(remainder / TimeComponent.minute.seconds)
        }()
        
        var s: Int = {
            let sInDay: Double = .init(d) * TimeComponent.day.seconds
            let sInHour: Double = .init(h) * TimeComponent.hour.seconds
            let sInMinute: Double = .init(m) * TimeComponent.minute.seconds
            
            let remainder: Double = seconds - sInDay - sInHour - sInMinute
            
            return .init(remainder.rounded(.toNearestOrAwayFromZero))
        }()

        if s == TimeComponent.second.max { s = 0; m += 1 }
        if m == TimeComponent.minute.max { m = 0; h += 1 }
        if h == TimeComponent.hour.max { h = 0; d += 1 }

        return (d, h, m, s)
    }
    
    private enum TimeComponent {
        case day
        case hour
        case minute
        case second
        
        var seconds: Double {
            switch self {
            case .day: return 86_400
            case .hour: return 3_600
            case .minute: return 60
            case .second: return 1
            }
        }
        
        var max: Int? {
            switch self {
            case .day: return nil
            case .hour: return 24
            case .minute: return 60
            case .second: return 60
            }
        }
    }
}

// MARK: - Helpers
extension Int {
    fileprivate var padded: String {
        let str: String = .init(self)
        
        switch str.count {
        case 1: return "0\(str)"
        case 2: return str
        default: fatalError()
        }
    }
}
