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
                // **Filter-Button, Titel und Plus-Button**
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
                        viewModel.isAddingBudget = true
                        viewModel.isEditingBudget = false // Neue Budget-Erstellung
                        viewModel.resetBudgetForm()
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding(.trailing)
                }
                // **Pie Chart**
                BudgetPieChartView(viewModel: viewModel)

                List {
                    ForEach(viewModel.filteredBudgets, id: \.id) { budget in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(budget.name)
                                    .font(.headline)
                                Text("Category: \(budget.category.name)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
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

            }
            .navigationTitle("Budgets")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Total: ")
                        .font(.headline)
                        .foregroundColor(viewModel.overallTotalBudget() < 0 ? .red : .primary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(String(format: "$%.2f", viewModel.overallTotalBudget()))
                        .font(.headline)
                        .foregroundColor(viewModel.overallTotalBudget() < 0 ? .red : .primary)
                }
            }
            .sheet(isPresented: $viewModel.isFilterSheetPresented, onDismiss: {
                viewModel.isShowingTransactionForm = false
                viewModel.isAddingBudget = false
            }) {
                FilterView(viewModel: viewModel)
            }
            .sheet(isPresented: $viewModel.isAddingBudget, onDismiss: {
                viewModel.isFilterSheetPresented = false
            }) {
                BudgetFormView(viewModel: viewModel, onSave: {
                    if viewModel.isEditingBudget {
                        viewModel.updateBudget()
                    } else {
                        viewModel.addBudget()
                    }
                    viewModel.isAddingBudget = false
                })
            }
        }
    }
}
