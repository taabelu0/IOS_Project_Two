//
//  DashboardView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: TransactionsViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {                    
                    // Gesamtbudget Übersicht als Tabelle
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Budget Overview")
                            .font(.title2)
                            .bold()
                        
                        HStack {
                            Text("Budget")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Total")
                                .bold()
                                .frame(maxWidth: .infinity)
                            Text("Remaining")
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 4)
                        .background(Color.gray.opacity(0.2))
                        
                        // Einmal für das Gesamtbudget
                        HStack {
                            Text("Total Budget")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(String(format: "%.2f", viewModel.overallBudgetLimit()))
                                .frame(maxWidth: .infinity)
                            Text(String(format: "%.2f", viewModel.overallTotalBudget()))
                                .foregroundColor(
                                    viewModel.overallTotalBudget() < 0 ? .red : .green)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .bold()
                        .padding(.vertical, 2)
                        
                        ForEach(viewModel.budgets.sorted(by: { $0.amount > $1.amount }), id: \.id) { budget in
                            let spent = viewModel.totalForCategory(budget.category)
                            let remaining = budget.amount - spent
                            
                            HStack {
                                Text(budget.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(String(format: "%.2f", budget.amount))
                                    .frame(maxWidth: .infinity)
                                Text(String(format: "%.2f", remaining))
                                    .foregroundColor(remaining < 0 ? .red : .green)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.vertical, 2)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.1)))
                    
                    // Warnung für überschrittene Budgets
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Exceeded Budgets")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.red)
                        
                        let exceededBudgets = viewModel.budgets.filter { budget in
                            let spent = viewModel.totalForCategory(budget.category)
                            return spent > budget.amount
                        }
                        
                        if exceededBudgets.isEmpty {
                            Text("No budgets exceeded 🎉")
                                .foregroundColor(.green)
                        } else {
                            ForEach(exceededBudgets, id: \.id) { budget in
                                let spent = viewModel.totalForCategory(budget.category)
                                let exceededAmount = spent - budget.amount
                                
                                HStack {
                                    Text(budget.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(String(format: "%.2f", budget.amount))
                                        .frame(maxWidth: .infinity)
                                    Text(String(format: "%.2f", exceededAmount))
                                        .foregroundColor(.red)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding(.vertical, 2)
                            }
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.red.opacity(0.1)))
                    
                    
                    // Übersicht der teuersten 5 Transaktionen
                    VStack(alignment: .leading, spacing: 10) {
                        Text("5 Most Expensive Transactions")
                            .font(.title2)
                            .bold()
                        
                        let topTransactions = viewModel.transactions.sorted(by: { $0.amount > $1.amount }).prefix(5)
                        
                        if topTransactions.isEmpty {
                            Text("No transactions available")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(topTransactions, id: \.id) { transaction in
                                HStack {
                                    Text(transaction.name)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(transaction.category.name)
                                        .frame(maxWidth: .infinity)
                                    Text(String(format: "%.2f", transaction.amount))
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding(.vertical, 2)
                            }
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.orange.opacity(0.1)))
                    
                }
                .padding()
                .navigationTitle("Dashboard")
            }
        }
    }
}
