//
//  TransactionViewModel.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//
import SwiftUI

class TransactionsViewModel: ObservableObject {
    // Transactions and categories
    @Published var parentCategories: [String: Color] = [
            "Essentials": Color(hue: 0.1, saturation: 1.0, brightness: 1.0), // Orange
            "Housing": Color(hue: 0.6, saturation: 1.0, brightness: 1.0), // Blau
            "Transportation": Color(hue: 0.3, saturation: 1.0, brightness: 1.0), // Grün
            "Entertainment": Color(hue: 0.0, saturation: 1.0, brightness: 1.0), // Rot
            "Health": Color(hue: 0.75, saturation: 1.0, brightness: 1.0), // Violett
            "Utilities": Color(hue: 0.16, saturation: 1.0, brightness: 1.0), // Gelb
            "Shopping": Color(hue: 0.5, saturation: 1.0, brightness: 1.0), // Türkisblau
            "Food & Drinks": Color(hue: 0.08, saturation: 1.0, brightness: 1.0), // Braun
            "Leisure": Color(hue: 0.58, saturation: 1.0, brightness: 1.0), // Dunkelblau
            "Home & Garden": Color(hue: 0.4, saturation: 1.0, brightness: 1.0) // Waldgrün
        ]
        
    @Published var categories: [Category] = []
    @Published var transactions: [Transaction] = []
        
        init() {
            categories = [
                // 🏠 **Essentials**
                Category(symbol: "cart", name: "Groceries", color: parentCategories["Essentials"]!, parentCategory: "Essentials"),
                Category(symbol: "cart.fill", name: "Supermarket", color: parentCategories["Essentials"]!, parentCategory: "Essentials"),
                Category(symbol: "cart.badge.plus", name: "Bulk Shopping", color: parentCategories["Essentials"]!, parentCategory: "Essentials"),
                
                // 🏡 **Housing**
                Category(symbol: "house", name: "Rent", color: parentCategories["Housing"]!, parentCategory: "Housing"),
                Category(symbol: "hammer", name: "Repairs", color: parentCategories["Housing"]!, parentCategory: "Housing"),
                Category(symbol: "paintbrush", name: "Renovation", color: parentCategories["Housing"]!, parentCategory: "Housing"),
                
                // 🚗 **Transportation**
                Category(symbol: "car", name: "Fuel", color: parentCategories["Transportation"]!, parentCategory: "Transportation"),
                Category(symbol: "tram.fill", name: "Public Transport", color: parentCategories["Transportation"]!, parentCategory: "Transportation"),
                Category(symbol: "bicycle", name: "Bike Maintenance", color: parentCategories["Transportation"]!, parentCategory: "Transportation"),
                
                // 🎭 **Entertainment**
                Category(symbol: "fork.knife", name: "Dining Out", color: parentCategories["Entertainment"]!, parentCategory: "Entertainment"),
                Category(symbol: "tv", name: "Streaming", color: parentCategories["Entertainment"]!, parentCategory: "Entertainment"),
                Category(symbol: "gamecontroller", name: "Gaming", color: parentCategories["Entertainment"]!, parentCategory: "Entertainment"),
                
                // ⚕️ **Health**
                Category(symbol: "heart.fill", name: "Medical Bills", color: parentCategories["Health"]!, parentCategory: "Health"),
                Category(symbol: "dumbbell", name: "Gym Membership", color: parentCategories["Health"]!, parentCategory: "Health"),
                
                // ⚡ **Utilities**
                Category(symbol: "bolt", name: "Electricity", color: parentCategories["Utilities"]!, parentCategory: "Utilities"),
                Category(symbol: "drop.fill", name: "Water Bill", color: parentCategories["Utilities"]!, parentCategory: "Utilities"),
                Category(symbol: "wifi", name: "Internet", color: parentCategories["Utilities"]!, parentCategory: "Utilities"),
                
                // 🛍 **Shopping**
                Category(symbol: "laptopcomputer", name: "Electronics", color: parentCategories["Shopping"]!, parentCategory: "Shopping"),
                Category(symbol: "bag.fill", name: "Clothing", color: parentCategories["Shopping"]!, parentCategory: "Shopping"),
                Category(symbol: "watch.fill", name: "Accessories", color: parentCategories["Shopping"]!, parentCategory: "Shopping")
            ]
            
            transactions = [
                // 🏠 **Housing & Essentials**
                Transaction(name: "Monthly Rent", category: Category(symbol: "house", name: "Rent", color: parentCategories["Housing"]!, parentCategory: "Housing"), amount: 1500.00),
                Transaction(name: "Electricity Bill", category: Category(symbol: "bolt", name: "Electricity", color: parentCategories["Utilities"]!, parentCategory: "Utilities"), amount: 90.30),
                Transaction(name: "Water Bill", category: Category(symbol: "drop.fill", name: "Water Bill", color: parentCategories["Utilities"]!, parentCategory: "Utilities"), amount: 50.00),
                Transaction(name: "Internet Subscription", category: Category(symbol: "wifi", name: "Internet", color: parentCategories["Utilities"]!, parentCategory: "Utilities"), amount: 40.00),
                Transaction(name: "Grocery Shopping", category: Category(symbol: "cart", name: "Groceries", color: parentCategories["Essentials"]!, parentCategory: "Essentials"), amount: 120.50),
                Transaction(name: "Supermarket Visit", category: Category(symbol: "cart.fill", name: "Supermarket", color: parentCategories["Essentials"]!, parentCategory: "Essentials"), amount: 75.20),
                Transaction(name: "Bulk Shopping at Costco", category: Category(symbol: "cart.badge.plus", name: "Bulk Shopping", color: parentCategories["Essentials"]!, parentCategory: "Essentials"), amount: 230.00),

                // 🚗 **Transportation**
                Transaction(name: "Gas Refill", category: Category(symbol: "car", name: "Fuel", color: parentCategories["Transportation"]!, parentCategory: "Transportation"), amount: 45.75),
                Transaction(name: "Uber Ride", category: Category(symbol: "car", name: "Fuel", color: parentCategories["Transportation"]!, parentCategory: "Transportation"), amount: 18.90),
                Transaction(name: "Tram Ticket", category: Category(symbol: "tram.fill", name: "Public Transport", color: parentCategories["Transportation"]!, parentCategory: "Transportation"), amount: 3.20),
                Transaction(name: "Bike Repair", category: Category(symbol: "bicycle", name: "Bike Maintenance", color: parentCategories["Transportation"]!, parentCategory: "Transportation"), amount: 25.00),

                // 🎭 **Entertainment**
                Transaction(name: "Netflix Subscription", category: Category(symbol: "tv", name: "Streaming", color: parentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 15.99),
                Transaction(name: "Spotify Premium", category: Category(symbol: "music.note", name: "Streaming", color: parentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 9.99),
                Transaction(name: "Dinner at Restaurant", category: Category(symbol: "fork.knife", name: "Dining Out", color: parentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 75.00),
                Transaction(name: "Concert Tickets", category: Category(symbol: "music.mic", name: "Concerts", color: parentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 120.00),
                Transaction(name: "Cinema Night", category: Category(symbol: "film", name: "Movies", color: parentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 35.00),
                Transaction(name: "PS5 Game Purchase", category: Category(symbol: "gamecontroller", name: "Gaming", color: parentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 60.00),

                // ⚕️ **Health & Fitness**
                Transaction(name: "Gym Membership", category: Category(symbol: "dumbbell", name: "Gym Membership", color: parentCategories["Health"]!, parentCategory: "Health"), amount: 50.00),
                Transaction(name: "Doctor Visit", category: Category(symbol: "stethoscope", name: "Medical Bills", color: parentCategories["Health"]!, parentCategory: "Health"), amount: 100.00),
                Transaction(name: "Vitamins & Supplements", category: Category(symbol: "pill", name: "Health", color: parentCategories["Health"]!, parentCategory: "Health"), amount: 25.00),
            ]
        }

        // 🟢 **Budgets für viele Kategorien**
        @Published var budgets: [Budget] = [
            Budget(name: "Grocery Budget", amount: 500.00, category: Category(symbol: "cart", name: "Groceries", color: .orange, parentCategory: "Essentials")),
            Budget(name: "Entertainment Budget", amount: 150.00, category: Category(symbol: "tv", name: "Streaming", color: .pink, parentCategory: "Entertainment")),
            Budget(name: "Housing Costs", amount: 1800.00, category: Category(symbol: "house", name: "Rent", color: .blue, parentCategory: "Housing")),
            Budget(name: "Shopping Budget", amount: 300.00, category: Category(symbol: "bag.fill", name: "Clothing", color: .cyan, parentCategory: "Shopping")),
            Budget(name: "Utilities", amount: 200.00, category: Category(symbol: "bolt", name: "Electricity", color: .yellow, parentCategory: "Utilities")),
            Budget(name: "Dining Out", amount: 100.00, category: Category(symbol: "fork.knife", name: "Dining Out", color: .red, parentCategory: "Entertainment")),
            Budget(name: "All Expenses", amount: 10000.00, category: Category(symbol: "cart", name: "All Expenses", color: .red, parentCategory: "All Expenses"))
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
            guard let parent = selectedParentCategory else { return }
            let parentColor = parentCategories[parent] ?? .gray
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
                .map { $0.amount }
                .reduce(0, +) // ✅ Fix: Redundante Summierung entfernt
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
                .map { $0.amount }
                .reduce(0, +) // ✅ Fix: Transaktionslose Kategorien vermeiden
        }
    }

    func budgetDataForParentCategories() -> [BudgetChartData] {
        // 🟢 **Falls "All" gewählt ist, zeigen wir ALLE Überkategorien**
        if selectedFilter == "All" {
            let data = parentCategories.map { (parent, color) -> BudgetChartData in
                let totalSpent = transactions
                    .filter { $0.category.parentCategory == parent }
                    .reduce(0) { $0 + $1.amount }

                _ = budgets
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
        // Prüfe, ob der Filter eine gültige Überkategorie oder einzelne Kategorie ist
        guard parentCategories.keys.contains(selectedFilter) || categories.contains(where: { $0.name == selectedFilter }) else {
            return []
        }

        if categories.contains(where: { $0.name == selectedFilter }) {
            // Falls eine spezifische Kategorie gewählt wurde, zeige nur diese Kategorie
            let spent = transactions.filter { $0.category.name == selectedFilter }.reduce(0) { $0 + $1.amount }
            let budget = budgets.first(where: { $0.category.name == selectedFilter })?.amount ?? 0

            guard budget > 0 else { return [] } // ✅ **Kein Budget → Kein Pie-Chart**

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
            guard spent > 0 else { return nil } // ✅ **Keine Ausgaben → Nicht anzeigen**

            let categoryColor = category.color
            let hue = categoryColor.getHSBComponents()?.hue ?? 0.5 // Falls fehlschlägt, Standard-Hue
            let adjustedColor = Color(hue: hue, saturation: 0.1 + (Double(index) / Double(totalSubcategories)) * 0.8, brightness: 1.0)

            return BudgetChartData(name: category.name, amount: spent, color: adjustedColor)
        }.compactMap { $0 } // **Filtert `nil` Werte heraus**

        return data
    }


}
