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
    
    @FocusState private var isTextFieldFocused: Bool
    @FocusState private var isSecureFieldFocused: Bool
    
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
        ZStack {
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
        }
    }
}

// MARK: - Preview
#if DEBUG

#Preview {
    @Previewable @State var isSecure: Bool = false
    @Previewable @State var text: String = "Lorem ipsum"

    VStack {
        SecurableTextField(
            isSecure: isSecure,
            placeholder: Text("Lorem ipsum"),
            text: $text
        )
#if !(os(tvOS) || os(watchOS))
        .textFieldStyle(.roundedBorder)
#endif

        Button("Toggle") {
            isSecure.toggle()
        }
    }
    .padding()
}

#endif
