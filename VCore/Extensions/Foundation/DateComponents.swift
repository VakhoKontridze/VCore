//
//  DateComponents.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 9/12/21.
//

import Foundation

// MARK: - Date Components
extension Date {
    /// Returns the value for one component, using the calendar time zone.
    public func component(_ component: Calendar.Component) -> Int {
        Calendar.current.component(component, from: self)
    }
    
    /// Returns all the date components of a date, using the calendar time zone.
    public func components(_ components: Set<Calendar.Component>) -> DateComponents {
        Calendar.current.dateComponents(components, from: self)
    }
}
