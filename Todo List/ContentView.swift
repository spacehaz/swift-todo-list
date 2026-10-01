import SwiftUI
import SwiftData


struct ContentView: View {
    @Query(sort: \Todo.createdAt) private var todos: [Todo]
    @Environment(\.modelContext) private var modelContext
    @State private var isAdding: Bool = false
    @State private var newTaskTitle: String = ""
    @State private var itemToDelete: Todo?
    
    
    var trimmedTitle: String {
        newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func addItem () -> Void {
        guard !trimmedTitle.isEmpty else { return }
        modelContext.insert(Todo(title: trimmedTitle))
        newTaskTitle = ""
    }
    
    func deleteItem (_ todo: Todo) -> Void {
        modelContext.delete(todo)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    Text(todo.title)
                        .swipeActions {
                            Button("Delete", systemImage: "trash.fill") {
                                itemToDelete = todo
                            }
                            .tint(.red)

                        }
                }
            }
            .overlay {
                if todos.isEmpty {
                    ContentUnavailableView("No todos yet", systemImage: "checklist", description: Text("Tap + on the top to add"))
                }
            }
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem {
                    Button("Add", systemImage: "plus") {
                        isAdding = true
                    }
                }
            }
            
            .sheet(isPresented: $isAdding, onDismiss: {
                newTaskTitle = ""
            }) {
                AppSheet (
                    "Create new item",
                    primary: SheetAction(
                        "Add",
                        isDisabled: trimmedTitle.isEmpty,
                        action: addItem
                        
                    ),
                    secondary: SheetAction(
                        "Cancel",
                        action: {
                            newTaskTitle = ""
                        }
                    ),
                ) {
                    TextField("Title", text: $newTaskTitle)
                }
                
            }
            
            
            .sheet(item: $itemToDelete) { todo in
                let title = todo.title
                AppSheet (
                    "Delete \"\(title)\"?" ,
                    message: "This can't be undone.",
                    primary: SheetAction(
                        "Delete",
                        role: .destructive,
                    ) {
                        deleteItem(todo)
                    },
                    secondary: SheetAction("Cancel")
                )
                
            }
            
        }
        
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Todo.self, inMemory: true)
}
