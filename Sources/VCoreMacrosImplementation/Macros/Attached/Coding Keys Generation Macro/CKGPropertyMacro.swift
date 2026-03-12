//
//  CKGPropertyMacro.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 02.03.24.
//

#if !(os(iOS) || os(tvOS) || os(watchOS) || os(visionOS))

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

struct CKGPropertyMacro: PeerMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        []
    }
}

#endif
