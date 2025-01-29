//
//  BudgetsView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//
import SwiftUI

struct BudgetsView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    @State private var isFilterSheetPresented: Bool = false
    @State private var isAddingBudget: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Filter-Icon am linken Rand
                    Button(action: {
                        isFilterSheetPresented = true
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                    }
                    .padding(.leading)
                    Spacer(minLength: 1)
                    // Plus rechts in der Toolbar
                    Button(action: {
                        isAddingBudget = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding(.trailing)
                }
                BudgetPieChartView(viewModel: viewModel)

                // Budget-Liste
                List {
                    ForEach(viewModel.budgets) { budget in
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
            .navigationTitle("Budgets")
            .sheet(isPresented: $isFilterSheetPresented) {
                FilterView(viewModel: viewModel)
            }
            .sheet(isPresented: $isAddingBudget) {
                BudgetFormView(viewModel: viewModel, isPresented: $isAddingBudget)
            }
        }
    }
}
