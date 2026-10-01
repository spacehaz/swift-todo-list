//
//  File.swift
//  Todo List
//
//  Created by Hazo Baykulov on 01.10.2026.
//

import Foundation
import SwiftUI

enum Priority: Int, CaseIterable, Identifiable {
    case low = 0, medium = 10, high = 20
    var id: Self { self }
    
    var title: String {
        switch self {
            case .low:
                return "Low"
            case .high:
                return "High"
            case .medium:
                return "Medium"
        }
    }
    
    var color: Color {
        switch self {
            case .low:
                return .green
            case .high:
                return .red
            case .medium:
                return .yellow
        }
    }
}
