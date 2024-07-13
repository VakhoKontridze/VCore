//
//  PresentationHostLayer.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 10.07.24.
//

import SwiftUI
import Combine

// MARK: - Extension
extension View {
    /// Injects a Presentation Host layer in view hierarchy for modal presentation.
    ///
    /// For additional info, refer to `View.presentationHost(...)`.
    public func presentationHostLayer(
        id layerID: String? = nil,
        uiModel: PresentationHostLayerUIModel = .init()
    ) -> some View {
        self
            .modifier(
                PresentationHostLayerViewModifier(
                    layerID: layerID,
                    uiModel: uiModel
                )
            )
    }
}

// MARK: - Presentation Host Layer View Modifier
private struct PresentationHostLayerViewModifier: ViewModifier {
    // MARK: Properties
    private let uiModel: PresentationHostLayerUIModel

    @State private var modals: [ModalData] = []

    @ObservedObject private var internalPresentationMode: PresentationHostInternalPresentationMode

    // MARK: Initializers
    init(
        layerID: String?,
        uiModel: PresentationHostLayerUIModel
    ) {
        self.uiModel = uiModel
        self._internalPresentationMode = ObservedObject(
            wrappedValue: PresentationHostInternalPresentationModeRegistrar.shared.resolve(layerID: layerID)
        )
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            .overlay(content: { layerView })

            .onReceive(internalPresentationMode.presentPublisher, perform: didReceiveInternalPresentRequest)
            .onReceive(internalPresentationMode.updatePublisher, perform: didReceiveInternalUpdateRequest)
            .onReceive(internalPresentationMode.dismissPublisher, perform: didReceiveInternalDismissRequest)
    }

    private var layerView: some View {
        ZStack(content: {
            dimmingView
            modalsView
        })
        .applyModifier({
            switch uiModel.frame {
            case .automatic:
                $0
            case .fixed(let size):
                $0.frame(size: size)
            case .infinite:
                $0.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        })
        .applyModifier({
            if let ignoredSafeArea = uiModel.ignoredSafeArea {
                $0.ignoresSafeArea(ignoredSafeArea.regions, edges: ignoredSafeArea.edges)
            } else {
                $0
            }
        })
    }

    @ViewBuilder
    private var dimmingView: some View {
        if let topMostModal: ModalData = modals.last { // Same as checking `!modals.isEmpty`
            uiModel.dimmingViewColor
                .contentShape(.rect)
                .allowsHitTesting(uiModel.dimmingViewTapAction.allowsHitTesting)
                .onTapGesture(perform: {
                    if uiModel.dimmingViewTapAction == .sendActionToTopmostModal {
                        topMostModal.presentationMode.dimmingViewTapActionSubject.send()
                    }
                })
        }
    }

    private var modalsView: some View {
        ForEach(modals, content: { modal in
            modalView(modal: modal)
        })
    }

    private func modalView(
        modal: ModalData
    ) -> some View {
        modal.view()
            .environment(\.presentationHostPresentationMode, modal.presentationMode)
            .onFirstAppear(perform: { modal.presentationMode.presentSubject.send() })
    }

    // MARK: Actions
    private func didReceiveInternalPresentRequest(
        data: PresentationHostInternalPresentationMode.PresentationData
    ) {
        let modal: ModalData = .init(
            id: data.id,
            view: data.view,
            presentationMode: PresentationHostPresentationMode(
                id: data.id,
                dismissCompletion: {
                    modals.removeAll(where: { $0.id == data.id })
                    PresentationHostDataSourceCache.shared.remove(key: data.id)
                }
            )
        )

        guard !modals.contains(where: { $0.id == modal.id }) else { return }

        modals.append(modal)
    }

    private func didReceiveInternalUpdateRequest(
        data: PresentationHostInternalPresentationMode.UpdateData
    ) {
        guard let index: Int = modals.firstIndex(where: { $0.id == data.id }) else { return }

        modals[index].view = data.view
    }

    private func didReceiveInternalDismissRequest(
        data: PresentationHostInternalPresentationMode.DismissData
    ) {
        guard let modal: ModalData = modals.first(where: { $0.id == data.id }) else { return }

        modal.presentationMode.dismissSubject.send()
    }

    // MARK: Modal Data
    private struct ModalData: Identifiable {
        let id: String
        var view: () -> AnyView
        let presentationMode: PresentationHostPresentationMode
    }
}
