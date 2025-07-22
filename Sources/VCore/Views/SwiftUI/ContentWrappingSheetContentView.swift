//
//  ContentWrappingSheetContentView.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 20.07.25.
//

import SwiftUI

public struct ContentWrappingSheetContentView<Content>: View where Content: View {
    private let content: () -> Content
    
    @State private var height: CGFloat?
    private var presentationDetents: Set<PresentationDetent> {
        if let height {
            [.height(height)]
        } else {
            []
        }
    }
    
    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }
    
    public var body: some View {
        content()
            .onGeometryChange(of: { $0.size.height }) { height = $0 }
            .presentationDetents(presentationDetents)
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    @Previewable @State var isDataExpanded: Bool = false
    
    Button("Present") {
        isPresented = true
    }
    .sheet(isPresented: $isPresented) {
        ContentWrappingSheetContentView {
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
