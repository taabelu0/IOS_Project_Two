//
//  DashboardViewUITests.swift
//  Project_Two
//
//  Created by Stefan Simić on 30.01.2025.
//


import XCTest

final class DashboardViewUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app.launch()
        continueAfterFailure = false
    }
    
    // ✅ TEST: Prüft, ob das Dashboard geladen wird
    func testDashboardViewLoadsCorrectly() {
        XCTAssertTrue(app.navigationBars["Dashboard"].exists, "Dashboard-Titel wird nicht angezeigt.")
    }
    
    // ✅ TEST: Prüft, ob die Budget-Tabelle angezeigt wird
    func testBudgetOverviewDisplaysCorrectly() {
        let budgetTitle = app.staticTexts["Budget Overview"]
        XCTAssertTrue(budgetTitle.exists, "Budget Overview wird nicht angezeigt.")
        
        let budgetColumns = ["Budget", "Total", "Remaining"]
        for column in budgetColumns {
            XCTAssertTrue(app.staticTexts[column].exists, "\(column) Spalte fehlt in der Budget-Tabelle.")
        }
    }
    
    // ✅ TEST: Prüft, ob das Gesamtbudget angezeigt wird
    func testTotalBudgetIsDisplayed() {
        let totalBudgetLabel = app.staticTexts["Total Budget"]
        XCTAssertTrue(totalBudgetLabel.exists, "Gesamtbudget fehlt.")
    }
    
    
    // ✅ TEST: Prüft, ob überschrittene Budgets korrekt angezeigt werden
    func testExceededBudgetsWarningDisplaysCorrectly() {
        let exceededBudgetsTitle = app.staticTexts["Exceeded Budgets"]
        XCTAssertTrue(exceededBudgetsTitle.exists, "Warnung für überschrittene Budgets fehlt.")
        
        let exceededBudgetCells = app.staticTexts.matching(identifier: "ExceededBudgetCell")
        if exceededBudgetCells.count > 0 {
            XCTAssertTrue(exceededBudgetCells.firstMatch.exists, "Überschrittene Budgets werden nicht korrekt angezeigt.")
        } else {
            XCTAssertTrue(app.staticTexts["No budgets exceeded 🎉"].exists, "Meldung für keine überschrittenen Budgets fehlt.")
        }
    }
    
    // ✅ TEST: Prüft, ob die teuersten 5 Transaktionen korrekt angezeigt werden
    func testTop5TransactionsDisplayCorrectly() {
        let transactionsTitle = app.staticTexts["5 Most Expensive Transactions"]
        XCTAssertTrue(transactionsTitle.exists, "Titel für teuerste Transaktionen fehlt.")
    }
    
    // ✅ TEST: Scrollt durch das Dashboard
    func testDashboardScrolls() {
        let firstElement = app.staticTexts["Budget Overview"]
        let lastElement = app.staticTexts["5 Most Expensive Transactions"]
        
        app.swipeUp()
        XCTAssertTrue(lastElement.isHittable, "Das Dashboard scrollt nicht korrekt.")
        
        app.swipeDown()
        XCTAssertTrue(firstElement.isHittable, "Das Dashboard scrollt nicht zurück.")
    }
}
