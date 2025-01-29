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
            VStack {
                // **Filter-Button und Plus-Button**
                HStack {
                    Button(action: {
                        viewModel.isFilterSheetPresented = true
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                    }
                    .padding(.leading)

                    Spacer()
                    Text("Budgets for \(viewModel.selectedFilter == "All" ? "All Categories" : viewModel.selectedFilter)")
                                            .font(.headline)
                    Spacer()
                    Button(action: {
                        viewModel.isShowingAddTransaction = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding(.trailing)
                }
                // **Pie Chart**
                BudgetPieChartView(viewModel: viewModel)

                List {
                    let filteredBudgets = viewModel.budgets.filter { budget in
                        viewModel.selectedFilter == "All" ||
                        budget.category.parentCategory == viewModel.selectedFilter ||
                        budget.category.name == viewModel.selectedFilter
                    }
                    if filteredBudgets.isEmpty {
                        Text("No Budgets Available")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    } else {
                        ForEach(filteredBudgets) { budget in
                            VStack(alignment: .leading) {
                                Text(budget.name)
                                    .font(.headline)
                                Text("Category: \(budget.category.name)")
                                    .foregroundColor(.secondary)
                                Text(String(format: "$%.2f", budget.amount))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Budgets")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Total: ")
                        .font(.headline)
                        .foregroundColor(viewModel.totalSpent() > viewModel.totalBudget() ? .red : .primary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(String(format: "$%.2f", viewModel.totalBudget() - viewModel.totalSpent()))
                        .font(.headline)
                        .foregroundColor(viewModel.totalSpent() > viewModel.totalBudget() ? .red : .primary)
                }
            }
            .sheet(isPresented: $viewModel.isFilterSheetPresented) {
                FilterView(viewModel: viewModel)
            }
            .sheet(isPresented: $viewModel.isAddingBudget) {
                BudgetFormView(viewModel: viewModel, onSave: {
                    viewModel.addBudget()
                    viewModel.isAddingBudget = false
                    })            }
        }
    }
}

