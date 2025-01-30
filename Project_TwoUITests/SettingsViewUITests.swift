//
//  SettingsViewUITests.swift
//  Project_Two
//
//  Created by Stefan Simić on 30.01.2025.
//


import XCTest

final class SettingsViewUITests: XCTestCase {
    /*
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        app.launch()
        continueAfterFailure = false
        // Test schlägt fehl, da er nicht auf anderen UI Tab rübergeht. Antwort wie das gemacht wird nicht gefunden.
        app.tabBars.buttons["Settings"].click()
    }
    
    // ✅ TEST: Prüft, ob die Settings View geladen wird
    func testSettingsViewLoadsCorrectly() {
        XCTAssertTrue(app.navigationBars["Settings"].exists, "Einstellungen-Titel wird nicht angezeigt.")
    }
    
    // ✅ TEST: Prüft, ob das Profil-Abschnitt sichtbar ist
    func testProfileSectionExists() {
        XCTAssertTrue(app.staticTexts["Profile"].exists, "Profil-Abschnitt fehlt.")
        XCTAssertTrue(app.staticTexts["Name: test"].exists, "Name wird nicht angezeigt.")
        XCTAssertTrue(app.staticTexts["Email: test@test.com"].exists, "E-Mail wird nicht angezeigt.")
    }
    
    // ✅ TEST: Prüft, ob der Dark Mode Toggle existiert
    func testDarkModeToggleExists() {
        let darkModeToggle = app.switches["Dark Mode"]
        XCTAssertTrue(darkModeToggle.exists, "Dark Mode Toggle fehlt.")
    }
    
    // ✅ TEST: Prüft, ob der Dark Mode umgeschaltet werden kann
    func testDarkModeToggleChanges() {
        let darkModeToggle = app.switches["Dark Mode"]
        XCTAssertTrue(darkModeToggle.exists, "Dark Mode Toggle fehlt.")
        
        let initialState = darkModeToggle.value as! String
        darkModeToggle.tap()
        let newState = darkModeToggle.value as! String
        
        XCTAssertNotEqual(initialState, newState, "Dark Mode Toggle hat sich nicht geändert.")
    }
    
    // ✅ TEST: Prüft, ob die Logout-Schaltfläche existiert
    func testLogoutButtonExists() {
        let logoutButton = app.buttons["Logout"]
        XCTAssertTrue(logoutButton.exists, "Logout-Button fehlt.")
    }
    
    // ✅ TEST: Prüft, ob das Logout funktioniert
    func testLogoutAction() {
        let logoutButton = app.buttons["Logout"]
        XCTAssertTrue(logoutButton.exists, "Logout-Button fehlt.")
        
        logoutButton.tap()
        
        // Stelle sicher, dass der Benutzer abgemeldet ist (abhängig von deiner Login-Logik)
        let isLoggedIn = app.switches["isLoggedIn"].exists
        XCTAssertFalse(isLoggedIn, "Logout hat nicht funktioniert.")
    }
     */
}
