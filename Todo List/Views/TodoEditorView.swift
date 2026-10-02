//
//  TodoEditorView.swift
//  Todo List
//
//  Created by Hazo Baykulov on 02.10.2026.
//

import SwiftUI

struct TodoEditorView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var draft: TodoDraft
    @State private var cancelInProgress: Bool = false
    private let original: TodoDraft
    
    private let onSave: (TodoDraft) -> Void
    
    init (draft: TodoDraft, onSave: @escaping (TodoDraft) -> Void) {
        _draft = State(initialValue: draft)
        self.onSave = onSave
        self.original = draft 
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section ("Title") {
                    TextField("Title", text: $draft.title)
                }
                Section ("Text") {
                    TextField("Text", text: $draft.text, axis: .vertical)
                        .lineLimit(5...)
                }
                Section {
                    Picker("Priority", selection: $draft.priority) {
                        ForEach(Priority.allCases) { priority in
                            Text(priority.title)
                                .tag(priority)
                        }
                        
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Priority")
                } footer: {
                    Text("Only visible for you")
                }
                
                
                Toggle("Done", isOn: $draft.isDone)
            }
            .navigationTitle("Edit")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        if draft == original {
                            dismiss()
                            
                        } else {
                            cancelInProgress = true
                        }
                    }
                    .confirmationDialog("Should cancel?", isPresented: $cancelInProgress, titleVisibility: .visible) {
                        Button("Discard Changes", role: .destructive) { dismiss() }
                        Button("Keep Editing", role: .cancel) { }
                    } message: {
                        Text("Your edits to this todo will be lost.")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        self.onSave(draft)
                        dismiss()
                    }
                    .disabled(!draft.isValid)
                }
            }
            .interactiveDismissDisabled(draft != original)
            
        }
    }
}
//
#Preview {
    TodoEditorView(draft: TodoDraft()) { _ in }
}
