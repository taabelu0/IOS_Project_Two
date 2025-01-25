//
//  ContentView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }
            
            TransactionsView()
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
            
            BudgetsView()
                .tabItem {
                    Label("Budgets", systemImage: "chart.pie.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

