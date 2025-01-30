//
//  BudgetsView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//
import SwiftUI
import Charts

struct BudgetsView: View {
    @ObservedObject var viewModel: TransactionsViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Button(action: {
                            viewModel.activeSheet = .filter
                        }) {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .font(.title2)
                        }
                        .padding(.leading)

                        Spacer()
                        Text("\(viewModel.selectedFilter == "All" ? "All Categories" : viewModel.selectedFilter) Budgets")
                            .font(.headline)
                        Spacer()

                        Button(action: {
                            viewModel.activeSheet = .budgetForm
                            viewModel.isEditingBudget = false
                            viewModel.resetBudgetForm()
                        }) {
                            Image(systemName: "plus")
                        }
                        .padding(.trailing)
                    }
                    .padding(.top)
                    .padding(.bottom)
                    .background(Color(UIColor.systemBackground)) // Hintergrund für den Header
                        

                    if viewModel.filteredBudgets.isEmpty {
                        // Zeige eine Nachricht an, wenn keine Budgets vorhanden sind
                        VStack {
                            Image(systemName: "tray.fill") // Symbol für leere Liste
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)

                            Text("No Budgets Available")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)

                            Text("Tap the '+' button to add a budget.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List {
                            ForEach(viewModel.filteredBudgets, id: \.id) { budget in
                                HStack {
                                    Image(systemName: budget.category.symbol)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(budget.category.color)
                                    
                                    VStack(alignment: .leading) {
                                        Text(budget.name)
                                            .font(.headline)
                                        Text(budget.category.name)
                                            .font(.subheadline)
                                            .foregroundColor(budget.category.color)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)
                                    
                                    Spacer()
                                    
                                    Text(String(format: "$%.2f", budget.amount))
                                        .foregroundColor(.primary)
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.startEditingBudget(budget)
                                }
                            }
                            .onDelete { indexSet in
                                viewModel.deleteBudget(at: indexSet)
                            }
                        }
                        .listStyle(PlainListStyle())
                        .scrollContentBackground(.visible)
                    }
                }
            }
            .navigationTitle("Budgets")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Total Budget for \(viewModel.selectedFilter == "All" ? "All Categories" : viewModel.selectedFilter)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(String(format: "$%.2f", viewModel.totalBudget()))
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .onDisappear {
            viewModel.activeSheet = nil
        }
    }
}
