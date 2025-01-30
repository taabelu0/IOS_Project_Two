//
//  ContentView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TransactionsViewModel() // Shared ViewModel

    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
                }

            TransactionsView(viewModel: viewModel)
                .tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                .onAppear {
                    viewModel.activeSheet = nil
                }

            BudgetsView(viewModel: viewModel)
                .tabItem {
                    Label("Budgets", systemImage: "chart.pie.fill")
                }
                .onAppear {
                    viewModel.activeSheet = nil
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .sheet(item: $viewModel.activeSheet, onDismiss: {
            viewModel.activeSheet = nil
        }) { sheet in
            switch sheet {
            case .budgetForm:
                BudgetFormView(viewModel: viewModel, onSave: {
                    if viewModel.isEditingBudget {
                        viewModel.updateBudget()
                    } else {
                        viewModel.addBudget()
                    }
                    viewModel.activeSheet = nil
                })
                .presentationDetents([.fraction(0.5)])

            case .transactionForm:
                TransactionFormView(viewModel: viewModel, onSave: {
                    if viewModel.isEditingTransaction {
                        viewModel.updateTransaction()
                    } else {
                        viewModel.addTransaction()
                    }
                    viewModel.activeSheet = nil
                })
                .presentationDetents([.fraction(0.5)])

            case .categoryForm:
                CategoryFormView(viewModel: viewModel, onSave: {
                    viewModel.addCategory()
                    viewModel.activeSheet = nil
                })
                .presentationDetents([.fraction(0.5)])

            case .filter:
                FilterView(viewModel: viewModel)

            default:
                EmptyView()
            }
        }
    }
}
