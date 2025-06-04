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
///         .textFieldStyle(.roundedBorder)
///     }
///     
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
#if DEBUG

#Preview(body: {
    @Previewable @State var isSecure: Bool = false
    @Previewable @State var text: String = "Lorem ipsum"

    VStack(content: {
        SecurableTextField(
            isSecure: isSecure,
            placeholder: Text("Lorem ipsum"),
            text: $text
        )
#if !(os(tvOS) || os(watchOS))
        .textFieldStyle(.roundedBorder)
#endif

        Button("Toggle", action: { isSecure.toggle() })
    })
    .padding()
})

#endif
