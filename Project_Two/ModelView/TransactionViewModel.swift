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
    @Published var budgets: [Budget] = []

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
    
    // State for filter
    @Published var selectedFilter: String = "All"

    // Filter logic transactions
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
    
    // Filter for parentCategories
    var filteredParentCategories: [String: Color] {
        if selectedFilter == "All" {
            // Zeige alle Überkategorien an
            return parentCategories
        } else if parentCategories.keys.contains(selectedFilter) {
            // Filtere nach einer bestimmten Überkategorie
            return [selectedFilter: parentCategories[selectedFilter]!]
        } else if let category = categories.first(where: { $0.name == selectedFilter }),
                  let parent = category.parentCategory { // Unwrap `category.parentCategory`
            // Filtere nach der Überkategorie, die zu einer spezifischen Kategorie gehört
            return [parent: parentCategories[parent]!]
        }
        return parentCategories // Fallback: Zeige alle Überkategorien
    }

    // Filter für categories
    var filteredCategories: [Category] {
        if selectedFilter == "All" {
            return categories
        } else if parentCategories.keys.contains(selectedFilter) {
            // Falls eine Überkategorie gewählt wurde, zeige alle ihre Unterkategorien
            return categories.filter { $0.parentCategory == selectedFilter }
        } else {
            // Falls eine spezifische Kategorie gewählt wurde, zeige nur diese
            return categories.filter { $0.name == selectedFilter }
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
    
    // Parent Category total
    func totalForParentCategory(_ parent: String) -> Double {
        let filteredCategories = categories.filter { $0.parentCategory == parent }
        return filteredCategories.reduce(0) { total, category in
            total + totalForCategory(category)
        }
    }
    
    // Category total
    func totalForCategory(_ category: Category) -> Double {
        return transactions
            .filter { $0.category.name == category.name }
            .reduce(0) { total, transaction in
                total + transaction.amount
            }
    }
    
    
    func addBudget(name: String, amount: Double, category: Category?) {
        let budget = Budget(name: name, amount: amount, category: category ?? Category(symbol: "circle", name: "All Categories", color: .gray, parentCategory: nil))
        budgets.append(budget)
    }
    
    func totalBudget() -> Double {
        return budgets.reduce(0) { $0 + $1.amount }
    }

    func totalSpent() -> Double {
        return transactions.reduce(0) { $0 + $1.amount }
    }
    
    func totalBudgetRemaining() -> Double {
        return totalBudget() - totalSpent()
    }

    // Pie Chart für Überkategorien
    func budgetDataForParentCategories() -> [BudgetChartData] {
        return parentCategories.keys.compactMap { parent in
            let budgetForParent = budgets.filter { $0.category.parentCategory == parent }.reduce(0) { $0 + $1.amount }
            let spentForParent = transactions.filter { $0.category.parentCategory == parent }.reduce(0) { $0 + $1.amount }
            return budgetForParent > 0 ? BudgetChartData(name: parent, amount: spentForParent, color: parentCategories[parent]!) : nil
        }
    }

    // Pie Chart für Unterkategorien
    func budgetDataForSubcategories() -> [BudgetChartData] {
        guard parentCategories.keys.contains(selectedFilter) else { return [] }
        return budgets
            .filter { $0.category.parentCategory == selectedFilter }
            .map { budget in
                let spent = transactions.filter { $0.category.name == budget.category.name }.reduce(0) { $0 + $1.amount }
                return BudgetChartData(name: budget.category.name, amount: spent, color: budget.category.color)
            }
    }

}


