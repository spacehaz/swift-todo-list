

//
//  Todo.swift
//  Todo List
//
//  Created by Hazo Baykulov on 28.09.2026.
//



import SwiftData
import Foundation

@Model final class Todo {
    
    var title: String
    var createdAt: Date
    var isDone: Bool
    var text: String = ""
    var priorityRaw: Int = Priority.medium.rawValue
    
    var priority: Priority {
        get { Priority(rawValue: priorityRaw) ?? .medium }
        set { priorityRaw = newValue.rawValue }
    }
    
    init (
        title: String,
        text: String = "",
        priority: Priority = Priority.medium,
        createdAt: Date = .now,
        isDone: Bool = false,
    ) {

        self.title = title
        self.createdAt = createdAt
        self.isDone = isDone
        self.text = text
        self.priority = priority

    }
    
    

}
