//
//  ViewModelTests.swift
//  Project_Two
//
//  Created by Marco Worni on 30.01.2025.
//


import XCTest
@testable import Project_Two

class TransactionsViewModelTests: XCTestCase {

    var viewModel: TransactionsViewModel!

    override func setUp() {
        super.setUp()
        viewModel = TransactionsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Transaction Tests
    
    func testAddTransaction() {
        viewModel.newTransactionName = "Groceries"
        viewModel.newTransactionAmount = "50.00"
        viewModel.selectedCategory = Category(symbol: "cart", name: "Food", color: .red, parentCategory: nil)

        viewModel.addTransaction()

        XCTAssertEqual(viewModel.transactions.count, 1)
        XCTAssertEqual(viewModel.transactions.first?.name, "Groceries")
        XCTAssertEqual(viewModel.transactions.first?.amount, 50.00)
        XCTAssertEqual(viewModel.transactions.first?.category.name, "Food")
    }

    func testUpdateTransaction() {
        let category = Category(symbol: "cart", name: "Food", color: .red, parentCategory: nil)
        let transaction = Transaction(name: "Old Name", category: category, amount: 30.00)
        
        viewModel.transactions.append(transaction)
        viewModel.startEditingTransaction(transaction)
        
        viewModel.newTransactionName = "New Name"
        viewModel.newTransactionAmount = "40.00"
        viewModel.updateTransaction()
        
        XCTAssertEqual(viewModel.transactions.first?.name, "New Name")
        XCTAssertEqual(viewModel.transactions.first?.amount, 40.00)
    }

    func testDeleteTransaction() {
        let category = Category(symbol: "cart", name: "Food", color: .red, parentCategory: nil)
        let transaction = Transaction(name: "Groceries", category: category, amount: 50.00)
        
        viewModel.transactions.append(transaction)
        XCTAssertEqual(viewModel.transactions.count, 1)

        viewModel.deleteTransaction(at: IndexSet(integer: 0))
        XCTAssertEqual(viewModel.transactions.count, 0)
    }

    // MARK: - Category Tests
    
    func testAddCategory() {
        viewModel.newCategoryName = "Entertainment"
        viewModel.selectedParentCategory = "Leisure"

        viewModel.parentCategories["Leisure"] = .blue
        viewModel.addCategory()

        XCTAssertEqual(viewModel.categories.count, 1)
        XCTAssertEqual(viewModel.categories.first?.name, "Entertainment")
        XCTAssertEqual(viewModel.categories.first?.parentCategory, "Leisure")
    }

    // MARK: - Budget Tests

    func testAddBudget() {
        viewModel.newBudgetName = "Food Budget"
        viewModel.newBudgetAmount = "200.00"
        viewModel.selectedCategory = Category(symbol: "cart", name: "Food", color: .red, parentCategory: nil)

        viewModel.addBudget()

        XCTAssertEqual(viewModel.budgets.count, 1)
        XCTAssertEqual(viewModel.budgets.first?.name, "Food Budget")
        XCTAssertEqual(viewModel.budgets.first?.amount, 200.00)
    }

    func testUpdateBudget() {
        let category = Category(symbol: "cart", name: "Food", color: .red, parentCategory: nil)
        let budget = Budget(name: "Food Budget", amount: 150.00, category: category)

        viewModel.budgets.append(budget)
        viewModel.startEditingBudget(budget)

        viewModel.newBudgetName = "Updated Budget"
        viewModel.newBudgetAmount = "180.00"
        viewModel.updateBudget()

        XCTAssertEqual(viewModel.budgets.first?.name, "Updated Budget")
        XCTAssertEqual(viewModel.budgets.first?.amount, 180.00)
    }

    func testDeleteBudget() {
        let category = Category(symbol: "cart", name: "Food", color: .red, parentCategory: nil)
        let budget = Budget(name: "Food Budget", amount: 200.00, category: category)

        viewModel.budgets.append(budget)
        XCTAssertEqual(viewModel.budgets.count, 1)

        viewModel.deleteBudget(at: IndexSet(integer: 0))
        XCTAssertEqual(viewModel.budgets.count, 0)
    }

    // MARK: - Filtering Tests

    func testFilteredTransactionsByCategory() {
        let foodCategory = Category(symbol: "cart", name: "Food", color: .red, parentCategory: nil)
        let travelCategory = Category(symbol: "car", name: "Travel", color: .blue, parentCategory: nil)

        viewModel.transactions.append(Transaction(name: "Lunch", category: foodCategory, amount: 15.00))
        viewModel.transactions.append(Transaction(name: "Flight", category: travelCategory, amount: 250.00))

        viewModel.selectedFilter = "Food"
        XCTAssertEqual(viewModel.filteredTransactions.count, 1)
        XCTAssertEqual(viewModel.filteredTransactions.first?.name, "Lunch")
    }

    func testFilteredTransactionsByParentCategory() {
        let parentCategory = "Leisure"
        let movieCategory = Category(symbol: "film", name: "Movies", color: .purple, parentCategory: parentCategory)

        viewModel.transactions.append(Transaction(name: "Cinema", category: movieCategory, amount: 20.00))
        viewModel.parentCategories[parentCategory] = .purple

        viewModel.selectedFilter = "Leisure"
        XCTAssertEqual(viewModel.filteredTransactions.count, 1)
        XCTAssertEqual(viewModel.filteredTransactions.first?.name, "Cinema")
    }

    func testTotalBudgetCalculation() {
        let foodCategory = Category(symbol: "cart", name: "Food", color: .red, parentCategory: nil)
        let travelCategory = Category(symbol: "car", name: "Travel", color: .blue, parentCategory: nil)

        viewModel.budgets.append(Budget(name: "Food Budget", amount: 100.00, category: foodCategory))
        viewModel.budgets.append(Budget(name: "Travel Budget", amount: 300.00, category: travelCategory))

        XCTAssertEqual(viewModel.totalBudget(), 400.00)
    }

    func testTotalSpentCalculation() {
        let foodCategory = Category(symbol: "cart", name: "Food", color: .red, parentCategory: nil)
        let travelCategory = Category(symbol: "car", name: "Travel", color: .blue, parentCategory: nil)

        viewModel.transactions.append(Transaction(name: "Lunch", category: foodCategory, amount: 20.00))
        viewModel.transactions.append(Transaction(name: "Flight", category: travelCategory, amount: 250.00))

        XCTAssertEqual(viewModel.totalSpent(), 270.00)
    }
}

