//
//  PrimaryButtonStyle.swift
//  Todo List
//
//  Created by Hazo Baykulov on 29.09.2026.
//

import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .font(.headline)
            .foregroundStyle(Color.brandPrimary)
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(backgroundColor(for: configuration.role), in: .capsule)
            .opacity(isEnabled ? 1 : 0.4)
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
    
    private func backgroundColor (for role: ButtonRole?) -> Color {
        return role == .destructive ? .red : .onBrandPrimary
    }
}

extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: SecondaryButtonStyle { .init() }
}


#Preview {
    VStack(spacing: 16) {
        Button("Add todo") {}
        Button("Add todo", systemImage: "plus") {}
        Button("Disabled") {}.disabled(true)
        Button("Delete", role: .destructive) {}
    }
    .buttonStyle(.secondary)
    .padding()
}
