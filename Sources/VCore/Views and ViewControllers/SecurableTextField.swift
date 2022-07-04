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
///     @State var isSecure: Bool = false
///     @State var text: String = "Lorem ipsum"
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
    
    private let placeholder: String?
    @Binding private var text: String
    
    @FocusState private var isTextFieldFocused
    @FocusState private var isSecureFieldFocused
    
    // MARK: Initializers
    /// Initializes `SecurableTextField`.
    public init(
        isSecure: Bool,
        placeholder: String?,
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
                prompt: placeholder.map { .init($0) },
                label: EmptyView.init
            )
                .focused($isTextFieldFocused)
                .opacity(isSecure ? 0 : 1)
            
            SecureField(
                text: $text,
                prompt: placeholder.map { .init($0) },
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
    @State private static var isSecure: Bool = false
    @State private static var text: String = "Lorem ipsum"
    
    static var previews: some View {
        HStack(content: {
            SecurableTextField(
                isSecure: isSecure,
                placeholder: "Lorem ipsum",
                text: $text
            )
            
            Button("Toggle", action: { isSecure.toggle() })
        })
            .padding()
    }
}
