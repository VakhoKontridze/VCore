//
//  SecurableTextField.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 22.06.22.
//

import SwiftUI

// MARK: - Securable Text Field
/// Input component that displays an editable text interface with toggle-able text.
///
///     @State private var isSecure: Bool = false
///     @State private var text: String = "Lorem ipsum"
///
///     var body: some View {
///         SecurableTextField(
///             isSecure: isSecure,
///             placeholder: "Lorem ipsum",
///             text: $text
///         )
///     }
///     
@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(watchOS 8.0, *)
public struct SecurableTextField: View {
    // MARK: Properties
    private let isSecure: Bool
    
    private let placeholder: Text?
    @Binding private var text: String
    
    @FocusState private var isTextFieldFocused
    @FocusState private var isSecureFieldFocused
    
    // MARK: Initializers
    /// Initializes `SecurableTextField` with text.
    public init(
        isSecure: Bool,
        placeholder: Text?,
        text: Binding<String>
    ) {
        self.isSecure = isSecure
        self.placeholder = placeholder
        self._text = text
    }
    
    // MARK: Body
    public var body: some View {
        ZStack(content: {
            TextField(
                text: $text,
                prompt: placeholder,
                label: EmptyView.init
            )
                .focused($isTextFieldFocused)
                .opacity(isSecure ? 0 : 1)
            
            SecureField(
                text: $text,
                prompt: placeholder,
                label: EmptyView.init
            )
                .focused($isSecureFieldFocused)
                .opacity(isSecure ? 1 : 0)
        })
    }
}

// MARK: - Preview
@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
@available(watchOS 8.0, *)
struct SecurableTextField_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    private struct Preview: View {
        @State private var isSecure: Bool = false
        @State private var text: String = "Lorem ipsum"
        
        var body: some View {
            VStack(content: {
                SecurableTextField(
                    isSecure: isSecure,
                    placeholder: .init("Lorem ipsum"),
                    text: $text
                )
                
                Button("Toggle", action: { isSecure.toggle() })
            })
                .padding()
        }
    }
}
