//
//  TransactionViewModel.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//
import SwiftUI

class TransactionsViewModel: ObservableObject {
    // Transactions and categories
    @Published var transactions: [Transaction] = [
            Transaction(name: "Grocery Shopping", category: Category(symbol: "cart", name: "Groceries", color: .orange, parentCategory: "Essentials"), amount: 120.50),
            Transaction(name: "Monthly Rent", category: Category(symbol: "house", name: "Rent", color: .blue, parentCategory: "Housing"), amount: 1500.00),
            Transaction(name: "Gas Refill", category: Category(symbol: "car", name: "Fuel", color: .green, parentCategory: "Transportation"), amount: 45.75),
            Transaction(name: "Dinner at Restaurant", category: Category(symbol: "fork.knife", name: "Dining Out", color: .red, parentCategory: "Entertainment"), amount: 60.00),
            Transaction(name: "Gym Membership", category: Category(symbol: "dumbbell", name: "Fitness", color: .purple, parentCategory: "Health"), amount: 50.00),
            Transaction(name: "Netflix Subscription", category: Category(symbol: "tv", name: "Streaming", color: .pink, parentCategory: "Entertainment"), amount: 15.99),
            Transaction(name: "Electricity Bill", category: Category(symbol: "bolt", name: "Electricity", color: .yellow, parentCategory: "Utilities"), amount: 95.30),
            Transaction(name: "New Laptop", category: Category(symbol: "laptopcomputer", name: "Electronics", color: .gray, parentCategory: "Shopping"), amount: 1200.00),
            Transaction(name: "Coffee at Starbucks", category: Category(symbol: "cup.and.saucer", name: "Coffee", color: .brown, parentCategory: "Food & Drinks"), amount: 5.00),
            Transaction(name: "Flight Ticket", category: Category(symbol: "airplane", name: "Travel", color: .cyan, parentCategory: "Leisure"), amount: 450.00)
    ]
    
    @Published var parentCategories: [String: Color] = [
        "Essentials": Color(hue: 0.1, saturation: 0.8, brightness: 0.8), // Dunkles Orange
        "Housing": Color(hue: 0.6, saturation: 0.7, brightness: 0.7), // Blau
        "Transportation": Color(hue: 0.3, saturation: 0.9, brightness: 0.7), // Grün
        "Entertainment": Color(hue: 0.0, saturation: 0.8, brightness: 0.7), // Rot
        "Health": Color(hue: 0.75, saturation: 0.8, brightness: 0.7), // Violett
        "Utilities": Color(hue: 0.16, saturation: 0.9, brightness: 0.8), // Gelb
        "Shopping": Color(hue: 0.5, saturation: 0.5, brightness: 0.6), // Türkisblau
        "Food & Drinks": Color(hue: 0.08, saturation: 0.7, brightness: 0.7), // Braun
        "Leisure": Color(hue: 0.58, saturation: 0.9, brightness: 0.6), // Dunkelblau
        "Home & Garden": Color(hue: 0.4, saturation: 0.8, brightness: 0.6) // Waldgrün
    ]

    @Published var categories: [Category] = []
    init() {
            categories = [
                Category(symbol: "cart", name: "Groceries", color: parentCategories["Essentials"] ?? .orange, parentCategory: "Essentials"),
                Category(symbol: "house", name: "Rent", color: parentCategories["Housing"] ?? .blue, parentCategory: "Housing"),
                Category(symbol: "car", name: "Fuel", color: parentCategories["Transportation"] ?? .green, parentCategory: "Transportation"),
                Category(symbol: "fork.knife", name: "Dining Out", color: parentCategories["Entertainment"]?.opacity(0.6) ?? .red, parentCategory: "Entertainment"),
                Category(symbol: "tv", name: "Streaming", color: parentCategories["Entertainment"] ?? .pink, parentCategory: "Entertainment"),
                Category(symbol: "bolt", name: "Electricity", color: parentCategories["Utilities"] ?? .yellow, parentCategory: "Utilities"),
                Category(symbol: "laptopcomputer", name: "Electronics", color: parentCategories["Shopping"] ?? .gray, parentCategory: "Shopping"),
                Category(symbol: "cup.and.saucer", name: "Coffee", color: parentCategories["Food & Drinks"] ?? .brown, parentCategory: "Food & Drinks"),
                Category(symbol: "airplane", name: "Travel", color: parentCategories["Leisure"] ?? .cyan, parentCategory: "Leisure")
            ]
        }

        

        @Published var budgets: [Budget] = [
            Budget(name: "Monthly Groceries", amount: 500.00, category: Category(symbol: "cart", name: "Groceries", color: .orange, parentCategory: "Essentials")),
            Budget(name: "Rent Payment", amount: 1500.00, category: Category(symbol: "house", name: "Rent", color: .blue, parentCategory: "Housing")),
            Budget(name: "Transport Costs", amount: 200.00, category: Category(symbol: "car", name: "Fuel", color: .green, parentCategory: "Transportation")),
            Budget(name: "Entertainment", amount: 150.00, category: Category(symbol: "tv", name: "Streaming", color: .pink, parentCategory: "Entertainment")),
            Budget(name: "Entertainment", amount: 150.00, category: Category(symbol: "tv", name: "All Entertainment", color: .pink, parentCategory: "Entertainment")),
            Budget(name: "Entertainment", amount: 150.00, category: Category(symbol: "tv", name: "Dining Out", color: .pink, parentCategory: "Entertainment")),
            Budget(name: "Health & Fitness", amount: 100.00, category: Category(symbol: "dumbbell", name: "Fitness", color: .purple, parentCategory: "Health")),
            Budget(name: "Utilities", amount: 250.00, category: Category(symbol: "bolt", name: "Electricity", color: .yellow, parentCategory: "Utilities")),
            Budget(name: "Shopping", amount: 500.00, category: Category(symbol: "laptopcomputer", name: "Electronics", color: .gray, parentCategory: "Shopping")),
            Budget(name: "Coffee & Snacks", amount: 50.00, category: Category(symbol: "cup.and.saucer", name: "Coffee", color: .brown, parentCategory: "Food & Drinks")),
            Budget(name: "Travel & Vacations", amount: 1000.00, category: Category(symbol: "airplane", name: "Travel", color: .cyan, parentCategory: "Leisure"))
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
    
    // State for filter
    @Published var selectedFilter: String = "All"
    @Published var isFilterSheetPresented: Bool = false
    
    // State for Budget creation
    @Published var isAddingBudget: Bool = false
    @Published var isEditingBudget: Bool = false
    @Published var newBudgetName: String = ""
    @Published var newBudgetAmount: String = ""

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
        guard let parent = selectedParentCategory,
              let parentColor = parentCategories[parent] else { return }
        let newCategory = Category(symbol: "questionmark", name: newCategoryName, color: parentColor, parentCategory: parent)
        categories.append(newCategory)
        budgets.append(Budget(name: newCategoryName, amount: 0.0, category: newCategory))
        resetCategoryForm()
    }


    
    // Add new Budget
    func addBudget() {
            guard let amount = Double(newBudgetAmount), let category = selectedCategory else { return }
            let budget = Budget(name: newBudgetName, amount: amount, category: category)
            budgets.append(budget)
            resetBudgetForm()
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
    
    // Reset Budget form
    func resetBudgetForm() {
            isEditingBudget = false
            newBudgetName = ""
            newBudgetAmount = ""
            selectedCategory = nil
            showCategoryPicker = false
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
    
    // Gesamtbudget basierend auf Filter
    func totalBudget() -> Double {
        if selectedFilter == "All" {
            return budgets.reduce(0) { $0 + $1.amount }
        } else {
            return budgets
                .filter { $0.category.parentCategory == selectedFilter || $0.category.name == selectedFilter }
                .reduce(0) { $0 + $1.amount }
        }
    }
    
    // Gesamtbudget Total
    func overallTotalBudget() -> Double {
        return budgets.reduce(0) { $0 + $1.amount }
    }

    // **Gesamtausgaben basierend auf Filter**
    func totalSpent() -> Double {
        if selectedFilter == "All" {
            return transactions.reduce(0) { $0 + $1.amount }
        } else {
            return transactions
                .filter { $0.category.parentCategory == selectedFilter || $0.category.name == selectedFilter }
                .reduce(0) { $0 + $1.amount }
        }
    }

    func budgetDataForParentCategories() -> [BudgetChartData] {
        // 🟢 **Falls "All" gewählt ist, zeigen wir ALLE Überkategorien**
        if selectedFilter == "All" {
            let data = parentCategories.map { (parent, color) -> BudgetChartData in
                let totalSpent = transactions
                    .filter { $0.category.parentCategory == parent }
                    .reduce(0) { $0 + $1.amount }

                let totalBudget = budgets
                    .filter { $0.category.parentCategory == parent }
                    .reduce(0) { $0 + $1.amount }

                return BudgetChartData(name: parent, amount: totalSpent, color: color)
            }

            print("📊 Budget Chart Data (All Categories): \(data)")
            return data
        }

        // 🟢 **Normale Berechnung für eine spezifische Überkategorie**
        guard parentCategories.keys.contains(selectedFilter) else { return [] }

        let relevantCategories = categories.filter { $0.parentCategory == selectedFilter }

        print("🔍 Überkategorie: \(selectedFilter), Gefundene Unterkategorien: \(relevantCategories.map { $0.name })")

        let relevantBudgets = budgets.filter { budget in
            relevantCategories.contains(where: { $0.name == budget.category.name })
        }

        print("🛠 Gefilterte Budgets für \(selectedFilter): \(relevantBudgets.map { $0.category.name })")

        let data = relevantBudgets.map { budget in
            let spent = transactions
                .filter { $0.category.name == budget.category.name }
                .reduce(0) { $0 + $1.amount }

            let categoryColor = categories.first(where: { $0.name == budget.category.name })?.color ?? .gray

            return BudgetChartData(name: budget.category.name, amount: spent, color: categoryColor)
        }

        print("📊 Budget Chart Data (Fixed - Parent): \(data)")
        return data
    }


    func budgetDataForSubcategories() -> [BudgetChartData] {
        guard parentCategories.keys.contains(selectedFilter) || categories.contains(where: { $0.name == selectedFilter }) else { return [] }

        // 🟢 **Falls direkt eine einzelne Unterkategorie ausgewählt wurde**
        if categories.contains(where: { $0.name == selectedFilter }) {
            let spent = transactions
                .filter { $0.category.name == selectedFilter }
                .reduce(0) { $0 + $1.amount }

            let budget = budgets.first(where: { $0.category.name == selectedFilter })?.amount ?? 0

            print("📊 Budget Chart Data (Fixed - Single Category): [\(selectedFilter)] → Budget: \(budget), Spent: \(spent)")

            let categoryColor = categories.first(where: { $0.name == selectedFilter })?.color ?? .gray

            return budget > 0 ? [BudgetChartData(name: selectedFilter, amount: spent, color: categoryColor)] : []
        }

        // 🟢 **Falls eine Überkategorie ausgewählt wurde, finde alle Unterkategorien**
        let subcategories = categories.filter { $0.parentCategory == selectedFilter }

        print("🔍 Gefundene Unterkategorien für \(selectedFilter): \(subcategories.map { $0.name })")

        let relevantBudgets = budgets.filter { budget in
            subcategories.contains(where: { $0.name == budget.category.name })
        }

        print("🛠 Gefilterte Budgets für \(selectedFilter): \(relevantBudgets.map { $0.category.name })")

        let totalSubcategories = relevantBudgets.count

        let data = relevantBudgets.enumerated().map { (index, budget) in
            let spent = transactions
                .filter { $0.category.name == budget.category.name }
                .reduce(0) { $0 + $1.amount }

            // 🟢 **Hier setzen wir eine unterschiedliche Opazität für jede Unterkategorie**
            let categoryColor = categories.first(where: { $0.name == budget.category.name })?.color ?? .gray
            let adjustedColor = categoryColor.opacity(0.5 + (Double(index) / Double(totalSubcategories)) * 0.5)

            return BudgetChartData(name: budget.category.name, amount: spent, color: adjustedColor)
        }

        print("📊 Budget Chart Data (Fixed - Subcategories with Opacity): \(data)")
        return data
    }

}
