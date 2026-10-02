//
//  TodoDraft.swift
//  Todo List
//
//  Created by Hazo Baykulov on 28.09.2026.
//

import Foundation

struct TodoDraft: Equatable {
    
    var title: String
    var isDone: Bool
    var text: String
    
    var priority: Priority
    
    var trimmedTitle: String {
        return self.title.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    init (
        _ todo: Todo
    ) {
        self.title = todo.title
        self.isDone = todo.isDone
        self.text = todo.text
        self.priority = todo.priority
    }
    init () {
        self.title = ""
        self.isDone = false
        self.text = ""
        self.priority = .medium
    }
    
    func apply(to todo: Todo) {
        todo.title = self.trimmedTitle
        todo.isDone = self.isDone
        todo.priority = self.priority
        todo.text = self.text
    }
    
    var isValid: Bool { !trimmedTitle.isEmpty }
    
    

}


extension Todo {
    convenience init(_ draft: TodoDraft) {
        self.init(title: draft.trimmedTitle, text: draft.text, priority: draft.priority, isDone: draft.isDone)
    }
}
