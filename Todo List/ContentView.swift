import SwiftUI
import SwiftData


struct ContentView: View {
    @Query(sort: \Todo.createdAt) private var todos: [Todo]
    @Environment(\.modelContext) private var modelContext
    @State private var isAdding: Bool = false
    @State private var newTaskTitle: String = ""
    
    
    var trimmedTitle: String {
        newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func addItem () -> Void {
        guard !trimmedTitle.isEmpty else { return }
        modelContext.insert(Todo(title: trimmedTitle))
        newTaskTitle = ""
        isAdding = false
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    Text(todo.title)
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
            
            .alert("Add new item", isPresented: $isAdding) {
                TextField("Title", text: $newTaskTitle)
                Button("Cancel", role: .cancel) {
                    isAdding = false
                    newTaskTitle = ""
                }
                Button("Add") {
                    addItem()
                }
                .disabled(trimmedTitle.isEmpty)
            }
            
        }
        
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Todo.self, inMemory: true)
}
