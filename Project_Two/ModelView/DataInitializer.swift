//
//  DataInitializer.swift
//  Project_Two
//
//  Created by Stefan Simić on 30.01.2025.
//


import SwiftUI

class DataInitializer {
    var initialParentCategories: [String: Color] = [:]
    var initialCategories: [Category] = []
    var initialTransactions: [Transaction] = []
    var budgets: [Budget] = []
    
    
    func loadTransactionViewModelWithSampleData(transactionViewModel: TransactionsViewModel) -> TransactionsViewModel {
        initData()
        
        // set data
        transactionViewModel.parentCategories = initialParentCategories
        transactionViewModel.categories = initialCategories
        transactionViewModel.transactions = initialTransactions
        transactionViewModel.budgets = budgets
        

        return transactionViewModel
    }
    
    
    // Initial alle Daten in Variablen laden. Aus übersicht zu unterst in der Klasse
    func initData() {
        initialParentCategories = [
            "Essentials": Color(hue: 0.75, saturation: 1.0, brightness: 1.0), // Violett
            "Housing": Color(hue: 0.1, saturation: 1.0, brightness: 1.0), // Orange
            "Transportation": Color(hue: 0.3, saturation: 1.0, brightness: 0.8), // Grün
            "Entertainment": Color(hue: 0.0, saturation: 1.0, brightness: 0.8), // Rot
            "Health": Color(hue: 0.16, saturation: 1.0, brightness: 0.9), // Gelb
            "Utilities": Color(hue: 0.6, saturation: 1.0, brightness: 0.9), // Blau
            "Shopping": Color(hue: 0.5, saturation: 1.0, brightness: 0.9), // Türkisblau
            "Food & Drinks": Color(hue: 0.08, saturation: 1.0, brightness: 1.0), // Braun
            "Leisure": Color(hue: 0.58, saturation: 1.0, brightness: 1.0), // Dunkelblau
            "Home & Garden": Color(hue: 0.4, saturation: 1.0, brightness: 0.8) // Waldgrün
            ]
        
        initialCategories = [
            // 🏠 **Essentials**
            Category(symbol: "cart", name: "Groceries", color: initialParentCategories["Essentials"]!, parentCategory: "Essentials"),
            Category(symbol: "cart.fill", name: "Supermarket", color: initialParentCategories["Essentials"]!, parentCategory: "Essentials"),
            Category(symbol: "cart.badge.plus", name: "Bulk Shopping", color: initialParentCategories["Essentials"]!, parentCategory: "Essentials"),
            
            // 🏡 **Housing**
            Category(symbol: "house", name: "Rent", color: initialParentCategories["Housing"]!, parentCategory: "Housing"),
            Category(symbol: "hammer", name: "Repairs", color: initialParentCategories["Housing"]!, parentCategory: "Housing"),
            Category(symbol: "paintbrush", name: "Renovation", color: initialParentCategories["Housing"]!, parentCategory: "Housing"),
            
            // 🚗 **Transportation**
            Category(symbol: "car", name: "Fuel", color: initialParentCategories["Transportation"]!, parentCategory: "Transportation"),
            Category(symbol: "tram.fill", name: "Public Transport", color: initialParentCategories["Transportation"]!, parentCategory: "Transportation"),
            Category(symbol: "bicycle", name: "Bike Maintenance", color: initialParentCategories["Transportation"]!, parentCategory: "Transportation"),
            
            // 🎭 **Entertainment**
            Category(symbol: "fork.knife", name: "Dining Out", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"),
            Category(symbol: "tv", name: "Streaming", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"),
            Category(symbol: "gamecontroller", name: "Gaming", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"),
            Category(symbol: "film", name: "Movies", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"),
            Category(symbol: "music.mic", name: "Concerts", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"),

            
            // ⚕️ **Health**
            Category(symbol: "heart.fill", name: "Medical Bills", color: initialParentCategories["Health"]!, parentCategory: "Health"),
            Category(symbol: "dumbbell", name: "Gym Membership", color: initialParentCategories["Health"]!, parentCategory: "Health"),
            
            // ⚡ **Utilities**
            Category(symbol: "bolt", name: "Electricity", color: initialParentCategories["Utilities"]!, parentCategory: "Utilities"),
            Category(symbol: "drop.fill", name: "Water Bill", color: initialParentCategories["Utilities"]!, parentCategory: "Utilities"),
            Category(symbol: "wifi", name: "Internet", color: initialParentCategories["Utilities"]!, parentCategory: "Utilities"),
            
            // 🛍 **Shopping**
            Category(symbol: "laptopcomputer", name: "Electronics", color: initialParentCategories["Shopping"]!, parentCategory: "Shopping"),
            Category(symbol: "bag.fill", name: "Clothing", color: initialParentCategories["Shopping"]!, parentCategory: "Shopping"),
            Category(symbol: "watch.fill", name: "Accessories", color: initialParentCategories["Shopping"]!, parentCategory: "Shopping"),
            
            // **Home & Garden**
            Category(symbol: "leaf", name: "Plants", color: initialParentCategories["Home & Garden"]!, parentCategory: "Home & Garden"),
            
            // **Food & Drinks**
            Category(symbol: "cup.and.heat.waves", name: "Coffee", color: initialParentCategories["Food & Drinks"]!, parentCategory: "Food & Drinks")
        ]
        
        initialTransactions = [
            // 🏠 **Housing & Essentials**
            Transaction(name: "Monthly Rent", category: Category(symbol: "house", name: "Rent", color: initialParentCategories["Housing"]!, parentCategory: "Housing"), amount: 1500.00),
            Transaction(name: "Electricity Bill", category: Category(symbol: "bolt", name: "Electricity", color: initialParentCategories["Utilities"]!, parentCategory: "Utilities"), amount: 90.30),
            Transaction(name: "Water Bill", category: Category(symbol: "drop.fill", name: "Water Bill", color: initialParentCategories["Utilities"]!, parentCategory: "Utilities"), amount: 50.00),
            Transaction(name: "Internet Subscription", category: Category(symbol: "wifi", name: "Internet", color: initialParentCategories["Utilities"]!, parentCategory: "Utilities"), amount: 40.00),
            Transaction(name: "Grocery Shopping", category: Category(symbol: "cart", name: "Groceries", color: initialParentCategories["Essentials"]!, parentCategory: "Essentials"), amount: 120.50),
            Transaction(name: "Supermarket Visit", category: Category(symbol: "cart.fill", name: "Supermarket", color: initialParentCategories["Essentials"]!, parentCategory: "Essentials"), amount: 75.20),
            Transaction(name: "Bulk Shopping at Costco", category: Category(symbol: "cart.badge.plus", name: "Bulk Shopping", color: initialParentCategories["Essentials"]!, parentCategory: "Essentials"), amount: 230.00),

            // 🚗 **Transportation**
            Transaction(name: "Gas Refill", category: Category(symbol: "car", name: "Fuel", color: initialParentCategories["Transportation"]!, parentCategory: "Transportation"), amount: 45.75),
            Transaction(name: "Uber Ride", category: Category(symbol: "car", name: "Fuel", color: initialParentCategories["Transportation"]!, parentCategory: "Transportation"), amount: 18.90),
            Transaction(name: "Tram Ticket", category: Category(symbol: "tram.fill", name: "Public Transport", color: initialParentCategories["Transportation"]!, parentCategory: "Transportation"), amount: 3.20),
            Transaction(name: "Bike Repair", category: Category(symbol: "bicycle", name: "Bike Maintenance", color: initialParentCategories["Transportation"]!, parentCategory: "Transportation"), amount: 25.00),

            // 🎭 **Entertainment**
            Transaction(name: "Netflix Subscription", category: Category(symbol: "tv", name: "Streaming", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 15.99),
            Transaction(name: "Spotify Premium", category: Category(symbol: "music.note", name: "Streaming", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 9.99),
            Transaction(name: "Dinner at Restaurant", category: Category(symbol: "fork.knife", name: "Dining Out", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 75.00),
            Transaction(name: "Concert Tickets", category: Category(symbol: "music.mic", name: "Concerts", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 120.00),
            Transaction(name: "Cinema Night", category: Category(symbol: "film", name: "Movies", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 35.00),
            Transaction(name: "PS5 Game Purchase", category: Category(symbol: "gamecontroller", name: "Gaming", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment"), amount: 60.00),

            // ⚕️ **Health & Fitness**
            Transaction(name: "Gym Membership", category: Category(symbol: "dumbbell", name: "Gym Membership", color: initialParentCategories["Health"]!, parentCategory: "Health"), amount: 50.00),
            Transaction(name: "Doctor Visit", category: Category(symbol: "stethoscope", name: "Medical Bills", color: initialParentCategories["Health"]!, parentCategory: "Health"), amount: 100.00),
            Transaction(name: "Vitamins & Supplements", category: Category(symbol: "pill", name: "Health", color: initialParentCategories["Health"]!, parentCategory: "Health"), amount: 25.00),
        ]
        
        budgets = [
            Budget(name: "Grocery Budget", amount: 500.00, category: Category(symbol: "cart", name: "Groceries", color: initialParentCategories["Essentials"]!, parentCategory: "Essentials")),
            Budget(name: "Entertainment Budget", amount: 150.00, category: Category(symbol: "tv", name: "Streaming", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment")),
            Budget(name: "Housing Costs", amount: 1800.00, category: Category(symbol: "house", name: "Rent", color: initialParentCategories["Housing"]!, parentCategory: "Housing")),
            Budget(name: "Shopping Budget", amount: 300.00, category: Category(symbol: "bag.fill", name: "Clothing", color: initialParentCategories["Shopping"]!, parentCategory: "Shopping")),
            Budget(name: "Utilities", amount: 200.00, category: Category(symbol: "bolt", name: "Electricity", color: initialParentCategories["Utilities"]!, parentCategory: "Utilities")),
            Budget(name: "Dining Out", amount: 100.00, category: Category(symbol: "fork.knife", name: "Dining Out", color: initialParentCategories["Entertainment"]!, parentCategory: "Entertainment")),
            
        ]
    }
}
