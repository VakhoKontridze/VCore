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
        .applyModifier({ view in
            switch uiModel.frame {
            case .fixed(let size, let alignment, let offset):
                ZStack(content: {
                    view
                        .frame(size: size)
                        .offset(offset)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)

            case .infinite:
                view
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        })
        .applyIfLet(uiModel.ignoredSafeArea, transform: {
            $0
                .ignoresSafeArea($1.regions, edges: $1.edges)
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
        NonInvasiveGeometryReader(
            alignment: modal.uiModel.alignment,
            content: { proxy in
                modal.view()
                    .environment(\.presentationHostGeometrySize, proxy.size)
                    .environment(\.presentationHostPresentationMode, modal.presentationMode)
            }
        )
        .onFirstAppear(perform: { modal.presentationMode.presentSubject.send() })
    }

    // MARK: Actions
    private func didReceiveInternalPresentRequest(
        presentationData: PresentationHostInternalPresentationMode.PresentationData
    ) {
        guard !modals.contains(where: { $0.id == presentationData.id }) else { return }

        let modal: ModalData = .init(
            id: presentationData.id,
            uiModel: presentationData.uiModel,
            view: presentationData.view,
            presentationMode: PresentationHostPresentationMode(
                id: presentationData.id
            )
        )

        modals.append(modal)

        presentationData.completion()
    }

    private func didReceiveInternalUpdateRequest(
        updateData: PresentationHostInternalPresentationMode.UpdateData
    ) {
        guard let index: Int = modals.firstIndex(where: { $0.id == updateData.id }) else { return }

        modals[index].uiModel = updateData.uiModel
        modals[index].view = updateData.view
    }

    private func didReceiveInternalDismissRequest(
        dismissData: PresentationHostInternalPresentationMode.DismissData
    ) {
        guard let modal: ModalData = modals.first(where: { $0.id == dismissData.id }) else { return }

        modal.presentationMode.dismissSubject.send(/*completion: */{
            modals.removeAll(where: { $0.id == dismissData.id })
            PresentationHostDataSourceCache.shared.remove(key: dismissData.id)

            dismissData.completion()
        })
    }

    // MARK: Modal Data
    private struct ModalData: Identifiable {
        let id: String
        var uiModel: PresentationHostUIModel
        var view: () -> AnyView
        let presentationMode: PresentationHostPresentationMode
    }
}

// MARK: - Non-Invasive Geometry Reader
private struct NonInvasiveGeometryReader<Content>: View
    where Content: View
{
    // MARK: Properties
    private let alignment: Alignment
    private let content: (GeometryProxy) -> Content

    // MARK: Initializers
    init(
        alignment: Alignment,
        @ViewBuilder content: @escaping (GeometryProxy) -> Content
    ) {
        self.alignment = alignment
        self.content = content
    }

    // MARK: Body
    var body: some View {
        Color.clear
            .overlay(content: {
                GeometryReader(content: { proxy in
                    ZStack(content: {
                        content(proxy)
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
                    .clipped() // Prevents content from going out of bounds
                })
            })
    }
}
