//
//  AppSheet.swift
//  Todo List
//
//  Created by Hazo Baykulov on 29.09.2026.
//

import SwiftUI

struct AppSheet<Content: View>: View {
    let title: String
    let message: String?
    let primary: SheetAction
    let secondary: SheetAction?
    let content: Content
    
    @Environment(\.dismiss) private var dismiss
    @State private var height: CGFloat = 300.0
    
    init (
        title: String,
        message: String? = nil,
        primary: SheetAction,
        secondary: SheetAction? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.message = message
        self.primary = primary
        self.secondary = secondary
        self.content = content()
    }
    
    var body: some View {
        VStack (spacing: 14) {
            header
            content
            buttons
            
        }
        .padding(24)
        .padding(.top, 8)
        // counting the size
        .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { height = $0 }
        .presentationDetents([.height(height)])
        .presentationCornerRadius(28)
        .presentationDragIndicator(.visible)
    }
    
    
    private var header: some View {
       VStack(spacing: 8) {
           Text(title)
               .font(.title3.bold())
           if let message {
               Text(message)
                   .font(.subheadline)
                   .foregroundStyle(.secondary)
           }
       }
       .multilineTextAlignment(.center)
   }
    
    private var buttons: some View {
       VStack(spacing: 12) {
           button(for: primary)
               .buttonStyle(.primary)
           if let secondary {
               button(for: secondary)
           }
       }
   }

   private func button(for item: SheetAction) -> some View {
       Button(item.title, role: item.role) {
           item.action()
           dismiss()                                  // every button closes the sheet; call sites never have to
       }
       .disabled(item.isDisabled)
   }
}

#Preview {
    @Previewable @State var text: String = "String"
    AppSheet(
        title: "Hello",
        primary: SheetAction(title: "Submit")
    ) {
        TextField("Type something", text: $text)
    }
}
