//
//  CKGCodingKeyMacro.swift
//  VCoreMacros
//
//  Created by Vakhtang Kontridze on 02.03.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

// MARK: - Coding Keys Generation Coding Key Macro
struct CKGCodingKeyMacro: PeerMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        []
    }
}
