//
//  Budget.swift
//  Project_Two
//
//  Created by Marco Worni on 29.01.2025.
//

import SwiftUI

struct Budget: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var category: Category
}
