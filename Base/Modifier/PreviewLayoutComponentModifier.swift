//
//  PreviewLayoutComponentModifier.swift
//  BCR
//
//  Created by Aruzhan  on 15.12.2022.
//

import SwiftUI
struct PreviewLayoutComponentModifier: ViewModifier {
    let name: String
    func body(content: Content) -> some View {
        content
            .previewLayout(.sizeThatFits)
            .previewDisplayName(name)
            .padding()
    }
}

extension View {
    
    func preview(with name: String) -> some View {
        self.modifier(PreviewLayoutComponentModifier(name: name))
    }
}
