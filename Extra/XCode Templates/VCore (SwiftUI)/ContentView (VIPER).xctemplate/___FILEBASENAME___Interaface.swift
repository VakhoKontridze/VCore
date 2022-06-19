//  ___FILEHEADER___

import SwiftUI
import VCore

// MARK: - ___VARIABLE_productName___ Presentable
@MainActor protocol ___VARIABLE_productName___Presentable: ObservableObject {
    /*@Published*/ var navigationStackCoordinator: NavigationStackCoordinator? { get set }
    /*@Published*/ var progressViewParameters: ProgressViewParameters? { get }
    /*@Published*/ var alertParameters: AlertParameters? { get set }
}

// MARK: - ___VARIABLE_productName___ Routable
typealias ___VARIABLE_productName___Routable = ViewModifier

// MARK: - ___VARIABLE_productName___ Interactive
protocol ___VARIABLE_productName___Interactive {

}
