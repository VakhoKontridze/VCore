//
//  UninitializableMacro.swift
//  VCoreMacrosImplementation
//
//  Created by Vakhtang Kontridze on 08.01.24.
//

#if !(os(iOS) || os(tvOS) || os(watchOS) || os(visionOS))

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

struct UninitializableMacro: MemberMacro {
    static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        [
            """
            private init() {}
            """
        ]
    }
}

#endif
