//  ___FILEHEADER___

import SwiftUI
import VCore

// MARK: - ___VARIABLE_productName___ Presentable
@MainActor protocol ___VARIABLE_productName___Presentable: ObservableObject {
    /*@Published*/ var navigationStackCoordinator: NavigationStackCoordinator? { get set }
    /*@Published*/ var alertParameters: AlertParameters? { get set }
    /*@Published*/ var progressViewParameters: ProgressViewParameters? { get }
}

// MARK: - ___VARIABLE_productName___ Routable
protocol ___VARIABLE_productName___Routable: ViewModifier {}

// MARK: - ___VARIABLE_productName___ Interactive
protocol ___VARIABLE_productName___Interactive {

}
