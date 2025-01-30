//
//  TransactionViewModelTests.swift
//  Project_Two
//
//  Created by Stefan Simić on 30.01.2025.
//


import XCTest
@testable import Project_Two

final class TransactionViewModelTests: XCTestCase {
    
    var viewModel: TransactionsViewModel!

    override func setUp() {
        super.setUp()
        viewModel = TransactionsViewModel()
        
        // Initialisiere Testdaten
        let groceryCategory = Category(symbol: "cart", name: "Groceries", color: .blue, parentCategory: "Essentials")
        let rentCategory = Category(symbol: "house", name: "Rent", color: .orange, parentCategory: "Housing")
        viewModel.categories = [groceryCategory, rentCategory]
        
        let groceryTransaction = Transaction(name: "Supermarket Visit", category: groceryCategory, amount: 75.20)
        let rentTransaction = Transaction(name: "Monthly Rent", category: rentCategory, amount: 1500.00)
        viewModel.transactions = [groceryTransaction, rentTransaction]
        
        let groceryBudget = Budget(name: "Grocery Budget", amount: 500.00, category: groceryCategory)
        let rentBudget = Budget(name: "Housing Budget", amount: 1800.00, category: rentCategory)
        viewModel.budgets = [groceryBudget, rentBudget]
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // 🛠 TEST: Transaktionen hinzufügen
    func testAddTransaction() {
        viewModel.newTransactionName = "Coffee"
        viewModel.newTransactionAmount = "4.50"
        viewModel.selectedCategory = viewModel.categories.first
        
        viewModel.addTransaction()
        
        XCTAssertEqual(viewModel.transactions.count, 3, "Transaktion wurde nicht korrekt hinzugefügt.")
        XCTAssertEqual(viewModel.transactions.last?.name, "Coffee", "Falscher Transaktionsname.")
        XCTAssertEqual(viewModel.transactions.last?.amount, 4.50, "Falscher Transaktionsbetrag.")
    }

    // 🛠 TEST: Transaktionen löschen
    func testDeleteTransaction() {
        XCTAssertEqual(viewModel.transactions.count, 2, "Anfangsanzahl an Transaktionen sollte 2 sein.")
        
        viewModel.deleteTransaction(at: IndexSet(integer: 0))
        
        XCTAssertEqual(viewModel.transactions.count, 1, "Transaktion wurde nicht korrekt entfernt.")
    }

    // 🛠 TEST: Gesamtausgaben berechnen
    func testTotalSpent() {
        XCTAssertEqual(viewModel.totalSpent(), 1575.20, "Die berechneten Gesamtausgaben sind nicht korrekt.")
    }
    
    // 🛠 TEST: Gesamtausgaben für eine Kategorie
    func testTotalForCategory() {
        let groceriesCategory = viewModel.categories.first!
        XCTAssertEqual(viewModel.totalForCategory(groceriesCategory), 75.20, "Die berechneten Ausgaben für Groceries sind nicht korrekt.")
    }

    // 🛠 TEST: Budgets filtern
    func testFilteredBudgets() {
        viewModel.selectedFilter = "Housing"
        XCTAssertEqual(viewModel.filteredBudgets.count, 1, "Filterfunktion für Budgets funktioniert nicht korrekt.")
        XCTAssertEqual(viewModel.filteredBudgets.first?.name, "Housing Budget", "Falsches Budget wurde gefiltert.")
    }

    // 🛠 TEST: Budgets hinzufügen
    func testAddBudget() {
        viewModel.newBudgetName = "Entertainment"
        viewModel.newBudgetAmount = "200.00"
        viewModel.selectedCategory = viewModel.categories.first
        
        viewModel.addBudget()
        
        XCTAssertEqual(viewModel.budgets.count, 3, "Budget wurde nicht korrekt hinzugefügt.")
        XCTAssertEqual(viewModel.budgets.last?.name, "Entertainment", "Falscher Budgetname.")
        XCTAssertEqual(viewModel.budgets.last?.amount, 200.00, "Falscher Budgetbetrag.")
    }

    // 🛠 TEST: Budgets löschen
    func testDeleteBudget() {
        XCTAssertEqual(viewModel.budgets.count, 2, "Anfangsanzahl an Budgets sollte 2 sein.")
        
        viewModel.deleteBudget(at: IndexSet(integer: 0))
        
        XCTAssertEqual(viewModel.budgets.count, 1, "Budget wurde nicht korrekt entfernt.")
    }

    // 🛠 TEST: Budgetüberschreitung erkennen
    func testExceededBudgets() {
        let exceededBudget = viewModel.budgets.first { budget in
            let spent = viewModel.totalForCategory(budget.category)
            return spent > budget.amount
        }
        
        XCTAssertNil(exceededBudget, "Es sollte keine überschrittenen Budgets geben.")
        
        // Budgetlimit künstlich senken
        viewModel.budgets[0].amount = 50.00
        
        let exceededBudgetNow = viewModel.budgets.first { budget in
            let spent = viewModel.totalForCategory(budget.category)
            return spent > budget.amount
        }
        
        XCTAssertNotNil(exceededBudgetNow, "Budgetüberschreitung wurde nicht erkannt.")
    }

    // 🛠 TEST: Kategorie hinzufügen
    func testAddCategory() {
        viewModel.newCategoryName = "Travel"
        viewModel.selectedParentCategory = "Transportation"
        
        viewModel.addCategory()
        
        XCTAssertEqual(viewModel.categories.count, 3, "Kategorie wurde nicht korrekt hinzugefügt.")
        XCTAssertEqual(viewModel.categories.last?.name, "Travel", "Falscher Kategoriename.")
    }
    
    // 🛠 TEST: Gesamtbudget-Berechnung
    func testTotalBudget() {
        XCTAssertEqual(viewModel.totalBudget(), 2300.00, "Gesamtbudget ist falsch berechnet.")
    }
    
    // 🛠 TEST: Gesamtbudget nach Abzug der Transaktionen
    func testOverallTotalBudget() {
        XCTAssertEqual(viewModel.overallTotalBudget(), 724.80, "Das verbleibende Budget ist falsch berechnet.")
    }
}
