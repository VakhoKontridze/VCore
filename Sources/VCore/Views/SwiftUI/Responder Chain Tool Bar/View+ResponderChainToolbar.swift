//
//  View+ResponderChainToolbar.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

import SwiftUI

// MARK: - View + Responder Chain Toolbar
@available(tvOS, unavailable) // No `ToolbarItemPlacement.keyboard`
@available(watchOS, unavailable) // No `ToolbarItemPlacement.keyboard`
@available(visionOS, unavailable) // No `ToolbarItemPlacement.keyboard`
extension View {
    /// Inserts toolbar that managed focus navigation in responder chain.
    ///
    ///     @State private var firstName: String = ""
    ///     @State private var lastName: String = ""
    ///
    ///     @FocusState private var focusedInput: FocusedInput?
    ///
    ///     var body: some View {
    ///         VStack(content: {
    ///             TextField("First name", text: $firstName)
    ///                 .focused($focusedInput, equals: .firstName)
    ///                 .responderChainToolbar(
    ///                     focus: $focusedInput,
    ///                     equals: .firstName,
    ///                     inResponderChain: [.firstName, .lastName]
    ///                 )
    ///
    ///             TextField("Last name", text: $lastName)
    ///                 .focused($focusedInput, equals: .lastName)
    ///                 .responderChainToolbar(
    ///                     focus: $focusedInput,
    ///                     equals: .lastName,
    ///                     inResponderChain: [.firstName, .lastName]
    ///                 )
    ///         })
    ///         .padding()
    ///         .textFieldStyle(.roundedBorder)
    ///     }
    ///
    ///     private enum FocusedInput: CaseIterable {
    ///         case firstName
    ///         case lastName
    ///     }
    ///
    /// Alternately, use second method that takes `CaseIterable` as a parameter and omits `inResponderChain` argument.
    public func responderChainToolbar<Value>(
        uiModel: ResponderChainToolbarUIModel = .init(),
        focus binding: FocusState<Value?>.Binding,
        equals value: Value,
        inResponderChain responderChain: [Value]
    ) -> some View
        where Value: Hashable
    {
        self
            .toolbar(content: {
                ToolbarItemGroup(placement: .keyboard, content: {
                    if
                        binding.wrappedValue == value,
                        uiModel.hasButtons
                    {
                        let previousValue: Value? = {
                            guard
                                let wrappedValue: Value = binding.wrappedValue,
                                let index: Int = responderChain.firstIndex(of: wrappedValue),
                                let previousValue: Value = responderChain[safe: index-1]
                            else {
                                return nil
                            }

                            return previousValue
                        }()
                        let nextValue: Value? = {
                            guard
                                let wrappedValue: Value = binding.wrappedValue,
                                let index: Int = responderChain.firstIndex(of: wrappedValue),
                                let nextValue: Value = responderChain[safe: index+1]
                            else {
                                return nil
                            }

                            return nextValue
                        }()

                        let upButtonIsEnabled: Bool = previousValue != nil
                        let downButtonIsEnabled: Bool = nextValue != nil

                        Group(content: {
                            if uiModel.hasNavigationButtons {
                                Button(
                                    action: { binding.wrappedValue = previousValue },
                                    label: { Image(systemName: "chevron.up") }
                                )
                                .disabled(!upButtonIsEnabled)
                                .foregroundStyle(uiModel.buttonColors.value(for: GenericState_EnabledDisabled(isEnabled: upButtonIsEnabled)))

                                Button(
                                    action: { binding.wrappedValue = nextValue },
                                    label: { Image(systemName: "chevron.down") }
                                )
                                .disabled(!downButtonIsEnabled)
                                .foregroundStyle(uiModel.buttonColors.value(for: GenericState_EnabledDisabled(isEnabled: downButtonIsEnabled)))
                            }

                            Spacer()

                            if uiModel.hasDoneButton {
                                Button(
                                    VCoreLocalizationManager.shared.localizationProvider.responderChainToolbarDoneButtonTitle,
                                    action: { binding.wrappedValue = nil }
                                )
                                .foregroundStyle(uiModel.buttonColors.enabled)
                                .font(uiModel.doneButtonFont)
                            }
                        })
                    }
                })
            })
    }

    /// Inserts toolbar that managed focus navigation in responder chain.
    ///
    ///     enum FocusedInput: CaseIterable {
    ///         case firstName
    ///         case lastName
    ///     }
    ///
    ///     @State private var firstName: String = ""
    ///     @State private var lastName: String = ""
    ///
    ///     @FocusState private var focusedInput: FocusedInput?
    ///
    ///     var body: some View {
    ///         VStack(content: {
    ///             TextField("First name", text: $firstName)
    ///                 .focused($focusedInput, equals: .firstName)
    ///                 .responderChainToolbar(focus: $focusedInput, equals: .firstName)
    ///
    ///             TextField("Last name", text: $lastName)
    ///                 .focused($focusedInput, equals: .lastName)
    ///                 .responderChainToolbar(focus: $focusedInput, equals: .lastName)
    ///         })
    ///         .padding()
    ///         .textFieldStyle(.roundedBorder)
    ///     }
    ///
    public func responderChainToolbar<Value>(
        uiModel: ResponderChainToolbarUIModel = .init(),
        focus binding: FocusState<Value?>.Binding,
        equals value: Value
    ) -> some View
        where Value: Hashable & CaseIterable
    {
        self
            .responderChainToolbar(
                uiModel: uiModel,
                focus: binding,
                equals: value,
                inResponderChain: Array(Value.allCases)
            )
    }
}
