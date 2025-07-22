//
//  SheetContentWrappingContainerView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.07.25.
//

import SwiftUI

// MARK: - Sheet Content Wrapping Container View
/// Container view that can be used to to wrap content within sheet.
///
///     @State var isPresented: Bool = true
///     @State var isDataExpanded: Bool = false
///
///     var body: some View {
///         Button("Present") {
///             isPresented = true
///         }
///         .sheet(isPresented: $isPresented) {
///             SheetContentWrappingContainerView {
///                 VStack(spacing: 20) {
///                     Button("Toggle Data") {
///                         isDataExpanded.toggle()
///                     }
///
///                     VStack(spacing: 5) {
///                         ForEach(
///                             Range(lower: 0, upper: isDataExpanded ? 20 : 10),
///                             id: \.self
///                         ) {
///                             Text(String($0))
///                         }
///                     }
///                 }
///                 .padding()
///             }
///         }
///     }
///
public struct SheetContentWrappingContainerView<Content>: View where Content: View {
    // MARK: Properties - Appearance
    @State private var height: CGFloat?
    private var presentationDetents: Set<PresentationDetent> {
        if let height {
            [.height(height)]
        } else {
            []
        }
    }
    
    // MARK: Properties - Content
    private let content: () -> Content
    
    // MARK: Properties
    /// Initializes `SheetContentWrappingContainerView` with content.
    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }
    
    // MARK: Body
    public var body: some View {
        content()
            .onGeometryChange(of: { $0.size.height }) { height = $0 }
            .presentationDetents(presentationDetents)
    }
}

// MARK: Preview
#if DEBUG

#Preview {
    @Previewable @State var isPresented: Bool = true
    @Previewable @State var isDataExpanded: Bool = false
    
    Button("Present") {
        isPresented = true
    }
    .sheet(isPresented: $isPresented) {
        SheetContentWrappingContainerView {
            VStack(spacing: 20) {
                Button("Toggle Data") {
                    isDataExpanded.toggle()
                }
                
                VStack(spacing: 5) {
                    ForEach(
                        Range(lower: 0, upper: isDataExpanded ? 20 : 10),
                        id: \.self
                    ) {
                        Text(String($0))
                    }
                }
            }
            .padding()
        }
    }
}

#endif
