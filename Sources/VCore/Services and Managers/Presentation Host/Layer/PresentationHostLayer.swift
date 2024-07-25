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
    // MARK: Properties - UI Model
    private let uiModel: PresentationHostLayerUIModel

    // MARK: Properties - Modals
    @State private var modals: [ModalData] = []

    // MARK: Properties - Presentation Mode
    @ObservedObject private var internalPresentationMode: PresentationHostInternalPresentationMode

    // MARK: Properties - Keyboard Responsiveness
#if os(iOS)
    @StateObject private var keyboardObserver: KeyboardObserver
#endif

    // MARK: Properties - Safe Area
    @State private var safeAreaInsets: EdgeInsets?
    @State private var didReadSafeAreaInsetsSubject: PassthroughSubject<Void, Never> = .init() // Delays presentation until environment is read

    // MARK: Initializers
    init(
        layerID: String?,
        uiModel: PresentationHostLayerUIModel
    ) {
        self.uiModel = uiModel
        
        self._internalPresentationMode = ObservedObject(
            wrappedValue: PresentationHostInternalPresentationModeRegistrar.shared.resolve(layerID: layerID)
        )

#if os(iOS)
        self._keyboardObserver = StateObject(
            wrappedValue: KeyboardObserver(
                uiModel: uiModel.keyboardObserverSubUIModel
            )
        )
#endif
    }

    // MARK: Body
    func body(content: Content) -> some View {
        content
            .getSafeAreaInsets(ignoredKeyboardSafeAreaEdges: .all, {
                safeAreaInsets = $0

                didReadSafeAreaInsetsSubject.send()
                didReadSafeAreaInsetsSubject.send(completion: .finished)
            })

            .overlay(content: { layerView })

            .onReceive(
                internalPresentationMode.presentPublisher.combineLatest(didReadSafeAreaInsetsSubject),
                perform: { (data, _) in didReceiveInternalPresentRequest(data) }
            )
            .onReceive(
                internalPresentationMode.updatePublisher.combineLatest(didReadSafeAreaInsetsSubject),
                perform:  { (data, _) in didReceiveInternalUpdateRequest(data) }
            )
            .onReceive(
                internalPresentationMode.dismissPublisher.combineLatest(didReadSafeAreaInsetsSubject),
                perform: { (data, _) in didReceiveInternalDismissRequest(data) }
            )
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

        // Must be written last
        .applyModifier({
#if os(iOS)
            $0
                .offset(y: -keyboardObserver.offset)
#else
            $0
#endif
        })
        .ignoresSafeArea()
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
                    .environment(\.presentationHostContainerSize, proxy.size)
                    .environment(\.presentationHostSafeAreaInsets, safeAreaInsets!) // Force-unwrap
                    .environment(\.presentationHostPresentationMode, modal.presentationMode)
            }
        )
        .onFirstAppear(perform: { modal.presentationMode.presentSubject.send() })
    }

    // MARK: Actions
    private func didReceiveInternalPresentRequest(
        _ presentationData: PresentationHostInternalPresentationMode.PresentationData
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
        _ updateData: PresentationHostInternalPresentationMode.UpdateData
    ) {
        guard let index: Int = modals.firstIndex(where: { $0.id == updateData.id }) else { return }

        modals[index].uiModel = updateData.uiModel
        modals[index].view = updateData.view
    }

    private func didReceiveInternalDismissRequest(
        _ dismissData: PresentationHostInternalPresentationMode.DismissData
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
