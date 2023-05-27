//
//  View.ResponderChainToolBar.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 24.05.23.
//

import SwiftUI

// MARK: - View Responder Chain Tool Bar
extension View {
    /// Inserts toolbar that managed focus navigation in responder chain.
    ///
    ///     struct ContentView: View {
    ///         @State private var firstName: String = ""
    ///         @State private var lastName: String = ""
    ///
    ///         @FocusState private var focusedInput: FocusedInput?
    ///
    ///         public var body: some View {
    ///             VStack(content: {
    ///                 TextField("First name", text: $firstName)
    ///                     .focused($focusedInput, equals: .firstName)
    ///                     .responderChainToolBar(
    ///                         focus: $focusedInput,
    ///                         equals: .firstName,
    ///                         inResponderChain: [.firstName, .lastName]
    ///                     )
    ///
    ///                 TextField("Last name", text: $lastName)
    ///                     .focused($focusedInput, equals: .lastName)
    ///                     .responderChainToolBar(
    ///                         focus: $focusedInput,
    ///                         equals: .lastName,
    ///                         inResponderChain: [.firstName, .lastName]
    ///                     )
    ///
    ///                 Spacer()
    ///             })
    ///             .padding()
    ///             .textFieldStyle(.roundedBorder)
    ///         }
    ///
    ///         private enum FocusedInput: CaseIterable {
    ///             case firstName
    ///             case lastName
    ///         }
    ///     }
    ///
    /// Alternately, use second method that takes `CaseIterable` as a parameter and omits `inResponderChain` argument.
    @available(iOS 15.0, macOS 12.0, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func responderChainToolBar<Value>(
        uiModel: SwiftUIResponderChainToolBarUIModel = .init(),
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
                        uiModel.layout.hasButtons
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
                            if uiModel.layout.hasNavigationButtons {
                                Button(
                                    action: { binding.wrappedValue = previousValue },
                                    label: { Image(systemName: "chevron.up") }
                                )
                                .disabled(!upButtonIsEnabled)
                                .foregroundColor(uiModel.colors.button.value(for: GenericState_EnabledDisabled(isEnabled: upButtonIsEnabled)))

                                Button(
                                    action: { binding.wrappedValue = nextValue },
                                    label: { Image(systemName: "chevron.down") }
                                )
                                .disabled(!downButtonIsEnabled)
                                .foregroundColor(uiModel.colors.button.value(for: GenericState_EnabledDisabled(isEnabled: downButtonIsEnabled)))
                            }

                            Spacer()

                            if uiModel.layout.hasDoneButton {
                                Button(
                                    uiModel.layout.doneButtonTitle,
                                    action: { binding.wrappedValue = nil }
                                )
                                .foregroundColor(uiModel.colors.button.enabled)
                                .font(uiModel.fonts.doneButton)
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
    ///     struct ContentView: View {
    ///         @State private var firstName: String = ""
    ///         @State private var lastName: String = ""
    ///
    ///         @FocusState private var focusedInput: FocusedInput?
    ///
    ///         public var body: some View {
    ///             VStack(content: {
    ///                 TextField("First name", text: $firstName)
    ///                     .focused($focusedInput, equals: .firstName)
    ///                     .responderChainToolBar(focus: $focusedInput, equals: .firstName)
    ///
    ///                 TextField("Last name", text: $lastName)
    ///                     .focused($focusedInput, equals: .lastName)
    ///                     .responderChainToolBar(focus: $focusedInput, equals: .lastName)
    ///
    ///                 Spacer()
    ///             })
    ///             .padding()
    ///             .textFieldStyle(.roundedBorder)
    ///         }
    ///     }
    ///
    @available(iOS 15.0, macOS 12.0, *)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    public func responderChainToolBar<Value>(
        uiModel: SwiftUIResponderChainToolBarUIModel = .init(),
        focus binding: FocusState<Value?>.Binding,
        equals value: Value
    ) -> some View
        where Value: Hashable & CaseIterable
    {
        self
            .responderChainToolBar(
                uiModel: uiModel,
                focus: binding,
                equals: value,
                inResponderChain: Array(Value.allCases)
            )
    }
}
