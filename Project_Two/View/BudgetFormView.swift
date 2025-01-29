//
//  BudgetFormView.swift
//  Project_Two
//
//  Created by Marco Worni on 29.01.2025.
//
import SwiftUI

struct BudgetFormView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    @Environment(\.presentationMode) var presentationMode // Erlaubt das Schließen des Formulars
    let onSave: () -> Void // Callback für das Speichern

    var body: some View {
        VStack {
            Text(viewModel.isEditingBudget ? "Edit Budget" : "Add New Budget")
                .font(.headline)
                .padding()
                .foregroundColor(Color(UIColor.label))

            TextField("Budget Name", text: $viewModel.newBudgetName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Amount", text: $viewModel.newBudgetAmount)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Kategorieauswahl als Button
            Button(action: {
                viewModel.showCategoryPicker = true
            }) {
                HStack {
                    Text(viewModel.selectedCategory?.name ?? "Select Category")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
            }
            .padding(.horizontal)
            .sheet(isPresented: $viewModel.showCategoryPicker) {
                CategorySelectionView(viewModel: viewModel, allowAllCategories: true)
            }

            // Speichern-Button
            Button(action: {
                if viewModel.isEditingBudget {
                    viewModel.updateBudget()
                } else {
                    viewModel.addBudget()
                }
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save Budget")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.newBudgetName.isEmpty || viewModel.newBudgetAmount.isEmpty || viewModel.selectedCategory == nil ? Color(UIColor.tertiarySystemBackground) : Color.blue)
                    .foregroundColor(viewModel.newBudgetName.isEmpty || viewModel.newBudgetAmount.isEmpty || viewModel.selectedCategory == nil ? Color(UIColor.systemGray) : Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .disabled(viewModel.newBudgetName.isEmpty || viewModel.newBudgetAmount.isEmpty || viewModel.selectedCategory == nil)

            Spacer()
        }
        .padding()
        .presentationDetents([.fraction(0.5)])
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
    }
}
