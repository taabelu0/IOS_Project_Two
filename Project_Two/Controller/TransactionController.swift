//
//  TransactionController.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//

import SwiftUI

class TransactionsController: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var categories: [Category] = [
        Category(symbol: "bed.double", name: "Furniture", color: .blue, parentCategory: "House"),
        Category(symbol: "house", name: "Rent", color: .blue, parentCategory: "House"),
        Category(symbol: "leaf", name: "Plants", color: .blue, parentCategory: "House"),
        Category(symbol: "car", name: "Car Payment", color: .green, parentCategory: "Transportation"),
        Category(symbol: "fuelpump", name: "Fuel", color: .green, parentCategory: "Transportation"),
        Category(symbol: "cart", name: "Groceries", color: .orange, parentCategory: "Groceries"),
        Category(symbol: "film", name: "Movies", color: .purple, parentCategory: "Entertainment"),
        Category(symbol: "gamecontroller", name: "Games", color: .purple, parentCategory: "Entertainment"),
        Category(symbol: "cup.and.saucer", name: "Coffee", color: .pink, parentCategory: "Dining"),
        Category(symbol: "fork.knife", name: "Restaurants", color: .pink, parentCategory: "Dining"),
        Category(symbol: "heart", name: "Health Insurance", color: .red, parentCategory: "Health"),
        Category(symbol: "hammer", name: "Repairs", color: .gray, parentCategory: "Utilities")
    ]

    let parentCategories: [String: Color] = [
        "House": .blue,
        "Transportation": .green,
        "Groceries": .orange,
        "Entertainment": .purple,
        "Dining": .pink,
        "Health": .red,
        "Utilities": .gray
    ]

    func addTransaction(name: String, amount: Double, category: Category) {
        let transaction = Transaction(name: name, category: category, amount: amount)
        transactions.append(transaction)
    }

    func updateTransaction(transaction: Transaction, name: String, amount: Double, category: Category) {
        if let index = transactions.firstIndex(where: { $0.id == transaction.id }) {
            transactions[index].name = name
            transactions[index].amount = amount
            transactions[index].category = category
        }
    }

    func addCategory(name: String, symbol: String, parent: String) {
        if let color = parentCategories[parent] {
            let category = Category(symbol: symbol, name: name, color: color, parentCategory: parent)
            categories.append(category)
        }
    }
}
