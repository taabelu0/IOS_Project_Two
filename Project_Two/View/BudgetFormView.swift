//
//  BudgetFormView.swift
//  Project_Two
//
//  Created by Marco Worni on 29.01.2025.
//
import SwiftUI

struct BudgetFormView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    @Binding var isPresented: Bool
    @State private var budgetName: String = ""
    @State private var budgetAmount: String = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Budget Name", text: $budgetName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Budget Amount", text: $budgetAmount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Kategorieauswahl als Button
                Button(action: {
                    viewModel.showCategoryPicker = true
                }) {
                    HStack {
                        Text(viewModel.selectedCategory?.name ?? "All Categories")
                            .foregroundColor(viewModel.selectedCategory == nil ? .gray : .primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                }
                .padding(.horizontal)

                Spacer()

                // Speichern-Button
                Button(action: {
                    if let amount = Double(budgetAmount), !budgetName.isEmpty {
                        viewModel.addBudget(name: budgetName, amount: amount, category: viewModel.selectedCategory)
                        isPresented = false
                    }
                }) {
                    Text("Save Budget")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(budgetName.isEmpty || budgetAmount.isEmpty ? Color.gray : Color.blue)
                        .cornerRadius(10)
                        .padding()
                }
                .disabled(budgetName.isEmpty || budgetAmount.isEmpty)
            }
            .navigationTitle("Add Budget")
            .sheet(isPresented: $viewModel.showCategoryPicker) {
                CategorySelectionView(viewModel: viewModel, allowAllCategories: true) // "All Categories" wird angezeigt
            }
        }
    }
}
