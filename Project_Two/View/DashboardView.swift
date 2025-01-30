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
                VStack{
                    HStack{
                        Button(action: {
                            viewModel.activeSheet = .filter
                        }) {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .font(.title2)
                        }
                        .padding(.leading)

                        Spacer()
                        
                        Text("\(viewModel.selectedFilter == "All" ? "All Categories" : viewModel.selectedFilter)")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.activeSheet = .categoryForm
                        }) {
                            Image(systemName: "folder.badge.plus")
                        }
                        .padding(.trailing)
                    }
                    .padding(.top)
                    .padding(.bottom)
                    .background(Color(UIColor.systemBackground))

                    Spacer()
                    
                    BudgetPieChartView(viewModel: viewModel)
                    
                    Spacer()
                    
                    Text("5 Most Expensive Transactions")
                        .font(.title2)
                        .bold()
                        .padding(.leading)
                    
                    if viewModel.filteredTransactions.isEmpty {
                        VStack {
                            Image(systemName: "tray.fill")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                            
                            Text("No Transactions Available")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)
                            
                            Text("Tap the '+' button to add a transaction.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        VStack(spacing: 10) {
                            let topTransactions = viewModel.filteredTransactions
                                .sorted(by: { $0.amount > $1.amount })
                                .prefix(5)
                            
                            ForEach(topTransactions, id: \ .id) { transaction in
                                HStack(alignment: .center) {
                                    Image(systemName: transaction.category.symbol)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(transaction.category.color)
                                    
                                    VStack(alignment: .leading) {
                                        Text(transaction.name)
                                            .font(.headline)
                                        Text(transaction.category.name)
                                            .font(.subheadline)
                                            .foregroundColor(transaction.category.color)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                    
                                    Spacer()
                                    
                                    Text(String(format: "$%.2f", transaction.amount))
                                        .foregroundColor(transaction.amount < 0 ? .red : .primary)
                                }
                                .padding(.vertical, 5)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.startEditingTransaction(transaction)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Remaining for \(viewModel.selectedFilter == "All" ? "All Categories" : viewModel.selectedFilter)")
                        .font(.headline)
                        .foregroundColor(viewModel.overallTotalBudget() < 0 ? .red : .primary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(String(format: "$%.2f", viewModel.totalBudget() - viewModel.totalSpent()))
                        .font(.headline)
                        .bold()
                        .foregroundColor(viewModel.totalSpent() > viewModel.totalBudget() ? .red : .primary)
                }
            }
        }
    }
}
