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
    
    init (title: String, createdAt: Date = .now, isDone: Bool = false) {
        self.title = title
        self.createdAt = createdAt
        self.isDone = isDone
    }
}
