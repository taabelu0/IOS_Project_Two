//
//  TransactionViewModel.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//
import SwiftUI

class TransactionsViewModel: ObservableObject {
    // Transactions and categories
    @Published var transactions: [Transaction] = []
    @Published var categories: [Category] = [
        Category(symbol: "cart", name: "Groceries", color: .orange, parentCategory: "Essentials"),
        Category(symbol: "house", name: "Rent", color: .blue, parentCategory: "Housing"),
        Category(symbol: "car", name: "Fuel", color: .green, parentCategory: "Transportation")
    ]
    @Published var parentCategories: [String: Color] = [
        "Essentials": .orange,
        "Housing": .blue,
        "Transportation": .green
    ]

    // Form state for creating or editing a transaction
    @Published var isEditingTransaction: Bool = false
    @Published var newTransactionName: String = ""
    @Published var newTransactionAmount: String = ""
    @Published var selectedCategory: Category? = nil
    @Published var showCategoryPicker: Bool = false

    // State for category creation
    @Published var isShowingAddTransaction: Bool = false
    @Published var isShowingAddCategory: Bool = false
    @Published var newCategoryName: String = ""
    @Published var selectedParentCategory: String? = nil
    
    // Zustand für den Filter
    @Published var selectedFilter: String = "All"

    // Filterlogik
    var filteredTransactions: [Transaction] {
        if selectedFilter == "All" {
            return transactions
        } else if parentCategories.keys.contains(selectedFilter) {
            // Filter nach Überkategorie
            return transactions.filter { $0.category.parentCategory == selectedFilter }
        } else {
            // Filter nach spezifischer Kategorie
            return transactions.filter { $0.category.name == selectedFilter }
        }
    }

    // Add a new transaction
    func addTransaction() {
        guard let amount = Double(newTransactionAmount), let category = selectedCategory else { return }
        let transaction = Transaction(name: newTransactionName, category: category, amount: amount)
        transactions.append(transaction)
        resetTransactionForm()
    }

    // Update an existing transaction
    func updateTransaction(transaction: Transaction) {
        guard let index = transactions.firstIndex(where: { $0.id == transaction.id }),
              let amount = Double(newTransactionAmount),
              let category = selectedCategory else { return }
        
        transactions[index].name = newTransactionName
        transactions[index].amount = amount
        transactions[index].category = category
        resetTransactionForm()
    }

    // Add a new category
    func addCategory() {
        guard let parent = selectedParentCategory else { return }
        if let color = parentCategories[parent] {
            let category = Category(symbol: "questionmark", name: newCategoryName, color: color, parentCategory: parent)
            categories.append(category)
            resetCategoryForm()
        }
    }

    // Reset the transaction form state
    func resetTransactionForm() {
        isEditingTransaction = false
        newTransactionName = ""
        newTransactionAmount = ""
        selectedCategory = nil
        showCategoryPicker = false
    }

    // Reset the category form state
    func resetCategoryForm() {
        newCategoryName = ""
        selectedParentCategory = nil
    }
}

