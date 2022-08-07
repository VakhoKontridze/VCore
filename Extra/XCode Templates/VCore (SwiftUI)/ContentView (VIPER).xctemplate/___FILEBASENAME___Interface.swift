//  ___FILEHEADER___

import SwiftUI
import VCore

// MARK: - ___VARIABLE_productName___ Presentable
@MainActor protocol ___VARIABLE_productName___Presentable: ObservableObject, AlertPresentable, ProgressViewPresentable {
    /*@Published*/ var navigationStackCoordinator: NavigationStackCoordinator? { get set }
}

// MARK: - ___VARIABLE_productName___ Routable
protocol ___VARIABLE_productName___Routable: ViewModifier {}

// MARK: - ___VARIABLE_productName___ Interactive
protocol ___VARIABLE_productName___Interactive {

}
