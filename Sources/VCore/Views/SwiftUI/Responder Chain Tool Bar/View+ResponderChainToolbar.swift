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
    /// Inserts toolbar that manages focus navigation in responder chain.
    ///
    ///     @State private var firstName: String = ""
    ///     @State private var lastName: String = ""
    ///
    ///     @FocusState private var focusedInput: FocusedInput?
    ///
    ///     var body: some View {
    ///         VStack {
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
    ///         }
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
        appearance: ResponderChainToolbarAppearance = .init(),
        focus binding: FocusState<Value?>.Binding,
        equals value: Value,
        inResponderChain responderChain: [Value]
    ) -> some View
        where Value: Hashable
    {
        self
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    if
                        binding.wrappedValue == value,
                        appearance.hasButtons
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

                        Group {
                            if appearance.hasNavigationButtons {
                                Button(
                                    action: { binding.wrappedValue = previousValue },
                                    label: { Image(systemName: "chevron.up") }
                                )
                                .disabled(!upButtonIsEnabled)
                                .foregroundStyle(appearance.buttonColors.value(for: GenericState_EnabledDisabled(isEnabled: upButtonIsEnabled)))

                                Button(
                                    action: { binding.wrappedValue = nextValue },
                                    label: { Image(systemName: "chevron.down") }
                                )
                                .disabled(!downButtonIsEnabled)
                                .foregroundStyle(appearance.buttonColors.value(for: GenericState_EnabledDisabled(isEnabled: downButtonIsEnabled)))
                            }

                            Spacer() // No need to specify min value, as it's controlled by the operating system

                            if appearance.hasDoneButton {
                                Button(VCoreLocalizationManager.shared.localizationProvider.responderChainToolbarDoneButtonTitle) {
                                    binding.wrappedValue = nil
                                }
                                .foregroundStyle(appearance.buttonColors.enabled)
                                .font(appearance.doneButtonFont)
                            }
                        }
                    }
                }
            }
    }

    /// Inserts toolbar that manages focus navigation in responder chain.
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
    ///         VStack {
    ///             TextField("First name", text: $firstName)
    ///                 .focused($focusedInput, equals: .firstName)
    ///                 .responderChainToolbar(focus: $focusedInput, equals: .firstName)
    ///
    ///             TextField("Last name", text: $lastName)
    ///                 .focused($focusedInput, equals: .lastName)
    ///                 .responderChainToolbar(focus: $focusedInput, equals: .lastName)
    ///         }
    ///         .padding()
    ///         .textFieldStyle(.roundedBorder)
    ///     }
    ///
    public func responderChainToolbar<Value>(
        appearance: ResponderChainToolbarAppearance = .init(),
        focus binding: FocusState<Value?>.Binding,
        equals value: Value
    ) -> some View
        where Value: Hashable & CaseIterable
    {
        self
            .responderChainToolbar(
                appearance: appearance,
                focus: binding,
                equals: value,
                inResponderChain: Array(Value.allCases)
            )
    }
}
