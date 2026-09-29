//
//  SheetAction.swift
//  Todo List
//
//  Created by Hazo Baykulov on 29.09.2026.
//

import SwiftUI

struct SheetAction {
    let title: String
    let role: ButtonRole?
    let isDisabled: Bool
    let action: () -> Void
    
    init (
        _ title: String,
        role: ButtonRole? = nil,
        isDisabled: Bool = false,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.role = role
        self.isDisabled = isDisabled
        self.action = action
    }
}
