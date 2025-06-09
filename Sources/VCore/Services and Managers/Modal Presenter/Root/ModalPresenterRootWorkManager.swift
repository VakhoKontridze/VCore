//
//  ModalPresenterRootWorkManager.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 29.05.25.
//

import Foundation
import Combine

// MARK: - Modal Presenter Root Work Manager
// When work is received in Modal Presenter root (such as present, update, or dismiss)
// they have to be buffered before important data is read from the environment.
// In addition, it provides serialization.
@MainActor
final class ModalPresenterRootWorkManager {
    // MARK: Properties
    private var queue: [Work] = []
    
    private var isEnabled: Bool = false
    private var isRunning: Bool = false
    
    let publisher: PassthroughSubject<Work, Never> = .init()
    
    // MARK: Initializers
    init() {}
    
    // MARK: API
    func addWork(_ work: Work) {
        queue.append(work)
        executeWork()
    }
    
    func setEnabledStatus(to isEnabled: Bool) {
        self.isEnabled = isEnabled
        executeWork()
    }
    
    private func executeWork() {
        guard isEnabled else { return }
        guard !isRunning else { return }
        guard !queue.isEmpty else { return }
        
        isRunning = true
        let work: Work = queue.removeFirst()
        publisher.send(work)
        isRunning = false
        
        executeWork()
    }
    
    // MARK: Work
    enum Work {
        case present(ModalPresenterInternalPresentationMode.PresentationData)
        case update(ModalPresenterInternalPresentationMode.UpdateData)
        case dismiss(ModalPresenterInternalPresentationMode.DismissData)
    }
}
