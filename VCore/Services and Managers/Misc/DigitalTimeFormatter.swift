//
//  DigitalTimeFormatter.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK:- Digital Time Foramtter
/// Digital Time formatter
public struct DigitalTimeFormatter {
    // MARK: Properties
    /// Indicates if empty components still show up as zeroes in format. Defaults to `false`.
    public var emptyComponentsShowAsZeroes: Bool = false
    
    /// Indicates if hour component in `HH:MM:SS` or `00:MM:SS` format shows two digits. Defaults to `false`.
    public var hourComponentHasTwoDigits: Bool = false
    
    /// Indicates if minute component in `MM:SS` or `00:SS` format shows two digits. Defaults to `false`.
    public var minuteComponentHasTwoDigits: Bool = false
    
    /// Indicates if second component in `SS` format shows two digits. Defaults to `true`.
    public var secondComponentHasTwoDigits: Bool = true
    
    /// Indicates if minute component is visible if only second component exists. Defaults to `true`.
    public var minuteComponentIsVisibleIfOnlySecondComponentExists: Bool = true
    
    /// Component delimiter. Defaults to `:`.
    public var delimiter: String = ":"
    
    // MARK: Initializers
    /// Initialzies `DigitalTimeFormatter`
    public init() {}
}

// MARK:- Formatting
extension DigitalTimeFormatter {
    /// Returns string from seconds with specified format
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
                switch (emptyComponentsShowAsZeroes, minuteComponentIsVisibleIfOnlySecondComponentExists, minuteComponentHasTwoDigits, secondComponentHasTwoDigits) {
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
        
        let formattedTime: String? = formattedComponents.let { $0.joined(separator: delimiter) }
        
        return formattedTime
    }
}

// MARK:- Time Components
extension DigitalTimeFormatter {
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
    
    fileprivate enum TimeComponent {
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

// MARK:- Helprs
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
