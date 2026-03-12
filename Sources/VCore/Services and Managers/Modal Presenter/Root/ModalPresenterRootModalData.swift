//
//  ModalPresenterRootModalData.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

import SwiftUI

struct ModalPresenterRootModalData: Identifiable {
    let id: String
    var appearance: ModalPresenterLinkAppearance
    var view: () -> AnyView
    let context: ModalPresenterContext
}
