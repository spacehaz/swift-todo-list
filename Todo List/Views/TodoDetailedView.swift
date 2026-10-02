//
//  TodoDetailedView.swift
//  Todo List
//
//  Created by Hazo Baykulov on 01.10.2026.
//

import SwiftUI
import SwiftData

struct TodoDetailedView: View {
    
    var todo: Todo
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack {
            Text(todo.title)
            Text(todo.text)
            Text(todo.priority.title)
            Text(todo.isDone ? "Done" : "In Progress")
        }
        .navigationTitle("Item")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Edit") {
                    isEditing = true
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            TodoEditorView(draft: TodoDraft(todo)) { draft in
                draft.apply(to: todo)
            }
        }
    }
}

#Preview {
    let container = try! ModelContainer(
       for: Todo.self,
       configurations: ModelConfiguration(isStoredInMemoryOnly: true)
   )
   let todo = Todo(title: "Buy milk", text: "2 liters, oat", priority: .high)
   container.mainContext.insert(todo)
    
    return NavigationStack {
        TodoDetailedView(todo: todo)
    }
    .modelContainer(container)
}
