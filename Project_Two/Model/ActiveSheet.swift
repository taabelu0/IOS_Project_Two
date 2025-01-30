//
//  ActionSheets.swift
//  Project_Two
//
//  Created by Marco Worni on 29.01.2025.
//
enum ActiveSheet: Identifiable {
    case transactionForm, categoryForm, budgetForm, filter
    
    var id: Int {
        hashValue
    }
}

