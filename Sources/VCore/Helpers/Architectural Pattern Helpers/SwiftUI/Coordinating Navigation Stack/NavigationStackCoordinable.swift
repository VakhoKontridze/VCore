//
//  NavigationStackCoordinable.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 07.08.22.
//

import SwiftUI

// MARK: - Navigation Stack Coordinable
@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
@MainActor public protocol NavigationStackCoordinable: ObservableObject {
    /*@Published*/ var navigationStackCoordinator: NavigationStackCoordinator? { get set }
}
