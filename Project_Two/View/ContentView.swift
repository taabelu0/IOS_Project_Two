//
//  ContentView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//
import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @ObservedObject var viewModel: TransactionsViewModel

    var body: some View {
        VStack {
            Text("Dummy Login")
                .font(.largeTitle)
                .padding()
                .foregroundColor(.primary)
            
            Text("No one of us has a paid Apple dev account and access to  \n-Sign in with Apple-")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                viewModel.isLoggedIn = true
            })
            {
                Text("Sign in with Apple")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color(UIColor.blue))
                    .cornerRadius(8)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .multilineTextAlignment(.center)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = DataInitializer().loadTransactionViewModelWithSampleData(transactionViewModel: TransactionsViewModel()) // Shared ViewModel

    var body: some View {
        if viewModel.isLoggedIn {
            TabView {
                DashboardView(viewModel: viewModel)
                    .tabItem {
                        Label("Dashboard", systemImage: "house.fill")
                    }
                
                TransactionsView(viewModel: viewModel)
                    .tabItem {
                        Label("Transactions", systemImage: "list.bullet")
                    }
                
                BudgetsView(viewModel: viewModel)
                    .tabItem {
                        Label("Budgets", systemImage: "chart.pie.fill")
                    }
                
                SettingsView(viewModel: viewModel)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
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
                }
            }
        } else {
            LoginView(viewModel: viewModel)
        }
    }
}
