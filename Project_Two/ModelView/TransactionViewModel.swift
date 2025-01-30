//
//  TransactionViewModel.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//
import SwiftUI

class TransactionsViewModel: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    // Transactions and categories
    @Published var parentCategories: [String: Color] = [:]
    @Published var categories: [Category] = []
    @Published var transactions: [Transaction] = []
    @Published var budgets: [Budget] = []

    // sheets
    @Published var activeSheet: ActiveSheet? = nil

    // Form state for creating or editing a transaction
    @Published var isEditingTransaction: Bool = false
    @Published var editingTransaction: Transaction? = nil
    @Published var newTransactionName: String = ""
    @Published var newTransactionAmount: String = ""
    @Published var selectedCategory: Category? = nil
    @Published var showCategoryPicker: Bool = false

    // State for category creation
    @Published var newCategoryName: String = ""
    @Published var selectedParentCategory: String? = nil
    
    // State for Budget creation or editing
    @Published var isEditingBudget: Bool = false
    @Published var newBudgetName: String = ""
    @Published var newBudgetAmount: String = ""
    @Published var editingBudget: Budget? = nil
    
    // State for filter
    @Published var selectedFilter: String = "All"
    @Published var isFilterSheetPresented: Bool = false


/*-----------------------------------------------------Filters----------------------------------------------------------*/
    
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
    
    // filter for budgets
    var filteredBudgets: [Budget] {
        if selectedFilter == "All" {
            return budgets
        } else {
            return budgets.filter { $0.category.parentCategory == selectedFilter || $0.category.name == selectedFilter }
        }
    }

    
/*-----------------------------------------------------Transaction logic----------------------------------------------------------*/

    
    // Add a new transaction
    func addTransaction() {
        guard let amount = Double(newTransactionAmount), let category = selectedCategory else { return }
        let transaction = Transaction(name: newTransactionName, category: category, amount: amount)
        transactions.append(transaction)
        resetTransactionForm()
    }
    
    // Update an existing transaction
    func updateTransaction() {
        guard let editingTransaction = editingTransaction,
              let index = transactions.firstIndex(where: { $0.id == editingTransaction.id }),
              let amount = Double(newTransactionAmount),
              let category = selectedCategory else {
            return
        }

        transactions[index].name = newTransactionName
        transactions[index].amount = amount
        transactions[index].category = category

        resetTransactionForm()
    }

    // Load an existing transaction
    func startEditingTransaction(_ transaction: Transaction) {
        activeSheet = .transactionForm
        isEditingTransaction = true
        editingTransaction = transaction
        newTransactionName = transaction.name
        newTransactionAmount = String(format: "%.2f", transaction.amount) // 🔹 Format fix
        selectedCategory = transaction.category
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }

    // Reset the transaction form state
    func resetTransactionForm() {
        isEditingTransaction = false
        editingTransaction = nil
        newTransactionName = ""
        newTransactionAmount = ""
        selectedCategory = nil
        showCategoryPicker = false
        editingBudget = nil
    }
    

/*-----------------------------------------------------Category logic----------------------------------------------------------*/

    // Add a new category
    func addCategory() {
            guard let parent = selectedParentCategory else { return }
            let parentColor = parentCategories[parent] ?? .gray
            let newCategory = Category(symbol: "questionmark", name: newCategoryName, color: parentColor, parentCategory: parent)
            
            categories.append(newCategory)
            budgets.append(Budget(name: newCategoryName, amount: 0.0, category: newCategory))
            resetCategoryForm()
        }

    // Reset the category form state
    func resetCategoryForm() {
        newCategoryName = ""
        selectedParentCategory = nil
    }
    

/*-----------------------------------------------------Budget logic----------------------------------------------------------*/
    
    // Add new Budget
    func addBudget() {
        guard let amount = Double(newBudgetAmount), amount.isFinite else { return }

        // Falls keine Kategorie ausgewählt wurde, erstelle ein Budget für "All Categories"
        let budgetCategory = selectedCategory ?? Category(symbol: "tray.fill", name: "All Categories", color: .gray, parentCategory: "All Categories")

        let budget = Budget(name: newBudgetName, amount: amount, category: budgetCategory)
        budgets.append(budget)
        resetBudgetForm()
    }
    
    func startEditingBudget(_ budget: Budget) {
        editingBudget = budget
        isEditingBudget = true
        newBudgetName = budget.name
        newBudgetAmount = String(budget.amount)
        selectedCategory = budget.category
        activeSheet = .budgetForm
    }
    
    func updateBudget() {
        guard let editingBudget = editingBudget,
              let index = budgets.firstIndex(where: { $0.id == editingBudget.id }),
              let amount = Double(newBudgetAmount),
              let category = selectedCategory else { return }

        budgets[index].name = newBudgetName
        budgets[index].amount = amount
        budgets[index].category = category

        resetBudgetForm() // Reset state nach dem Speichern
    }
    
    func deleteBudget(at offsets: IndexSet) {
        budgets.remove(atOffsets: offsets)
    }

    // Reset Budget form
    func resetBudgetForm() {
            isEditingBudget = false
            newBudgetName = ""
            newBudgetAmount = ""
            selectedCategory = nil
            showCategoryPicker = false
        }
    

/*-----------------------------------------------------Calculate functions----------------------------------------------------------*/

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
                .map { $0.amount }
                .reduce(0, +) // ✅ Fix: Redundante Summierung entfernt
        }
    }

    // Gesamtbudget Total
    func overallTotalBudget() -> Double {
        return budgets.reduce(0) { $0 + $1.amount } - transactions.reduce(0){ $0 + $1.amount }
    }

    // Gesamtausgaben basierend auf Filter
    func totalSpent() -> Double {
        if selectedFilter == "All" {
            return transactions.reduce(0) { $0 + $1.amount }
        } else {
            return transactions
                .filter { $0.category.parentCategory == selectedFilter || $0.category.name == selectedFilter }
                .map { $0.amount }
                .reduce(0, +) // ✅ Fix: Transaktionslose Kategorien vermeiden
        }
    }
    
    
    // Gesamtbudget ohne Abzüge
    func overallBudgetLimit() -> Double {
        budgets.reduce(0) {$0 + $1.amount}
    }
    
/*-----------------------------------------------------PieChart functions----------------------------------------------------------*/
    
    // total budgetForParentCategories without filter
    func totalBudgetDataForParentCategories() -> [BudgetChartData] {
        let data = parentCategories.map { (parent, color) -> BudgetChartData in
            let totalSpent = transactions
                .filter { $0.category.parentCategory == parent }
                .reduce(0) { $0 + $1.amount }

            _ = budgets
                .filter { $0.category.parentCategory == parent }
                .reduce(0) { $0 + $1.amount }

            return BudgetChartData(name: parent, amount: totalSpent, color: color)
        }
        return data
    }
        

    func budgetDataForParentCategories() -> [BudgetChartData] {
        if selectedFilter == "All" {
            return totalBudgetDataForParentCategories()
        }

        guard parentCategories.keys.contains(selectedFilter) else { return [] }

        let relevantCategories = categories.filter { $0.parentCategory == selectedFilter }

        let relevantBudgets = budgets.filter { budget in
            relevantCategories.contains(where: { $0.name == budget.category.name })
        }

        let data = relevantBudgets.map { budget in
            let spent = transactions
                .filter { $0.category.name == budget.category.name }
                .reduce(0) { $0 + $1.amount }

            let categoryColor = categories.first(where: { $0.name == budget.category.name })?.color ?? .gray

            return BudgetChartData(name: budget.category.name, amount: spent, color: categoryColor)
        }

        return data
    }


    func budgetDataForSubcategories() -> [BudgetChartData] {
        guard parentCategories.keys.contains(selectedFilter) || categories.contains(where: { $0.name == selectedFilter }) else {
            return []
        }

        if categories.contains(where: { $0.name == selectedFilter }) {
            // Falls eine spezifische Kategorie gewählt wurde, zeige nur diese Kategorie
            let spent = transactions.filter { $0.category.name == selectedFilter }.reduce(0) { $0 + $1.amount }
            let budget = budgets.first(where: { $0.category.name == selectedFilter })?.amount ?? 0

            guard budget > 0 else { return [] } 

            let categoryColor = categories.first(where: { $0.name == selectedFilter })?.color ?? .gray
            return [BudgetChartData(name: selectedFilter, amount: spent, color: categoryColor)]
        }

        // Falls eine Überkategorie gewählt wurde, zeige alle Unterkategorien mit Transaktionen
        let subcategories = categories.filter { $0.parentCategory == selectedFilter }

        let relevantCategories = subcategories.filter { category in
            transactions.contains { $0.category.name == category.name }
        }

        let totalSubcategories = relevantCategories.count

        let data: [BudgetChartData] = relevantCategories.enumerated().compactMap { (index, category) in
            let spent = transactions.filter { $0.category.name == category.name }.reduce(0) { $0 + $1.amount }
            guard spent > 0 else { return nil }

            let categoryColor = category.color
            let hue = categoryColor.getHSBComponents()?.hue ?? 0.5
            let adjustedColor = Color(hue: hue, saturation: 0.1 + (Double(index) / Double(totalSubcategories)) * 0.8, brightness: 1.0)

            return BudgetChartData(name: category.name, amount: spent, color: adjustedColor)
        }.compactMap { $0 }
        return data
    }


}
