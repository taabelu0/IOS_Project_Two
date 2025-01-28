//
//  Transaction.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//
import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    var name: String
    var category: Category
    var amount: Double
}

struct Category: Identifiable {
    let id = UUID()
    var symbol: String
    var name: String
    var color: Color
    var parentCategory: String?
}
