//
//  PlatformTypes.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 16/5/26.
//

import SwiftUI
#if canImport(UIKit)
public import UIKit
#elseif canImport(AppKit)
public import AppKit
#endif

#if canImport(UIKit)
public typealias PlatformImage = UIImage
#elseif canImport(AppKit)
public typealias PlatformImage = NSImage
#endif

#if canImport(UIKit)
public typealias PlatformColor = UIColor
#elseif canImport(AppKit)
public typealias PlatformColor = NSColor
#endif
