//
//  BudgetFormView.swift
//  Project_Two
//
//  Created by Marco Worni on 29.01.2025.
//
import SwiftUI

struct BudgetFormView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    @Environment(\.dismiss) var dismiss // Ermöglicht das Schließen des Modals
    
    let onSave: () -> Void // Callback für das Speichern

    var body: some View {
        NavigationView {
            VStack {
                TextField("Budget Name", text: $viewModel.newBudgetName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Amount", text: Binding(
                    get: { viewModel.newBudgetAmount },
                    set: { newValue in
                        let filtered = newValue.filter { "0123456789.".contains($0) }
                        viewModel.newBudgetAmount = filtered
                    }
                ))
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                Button(action: {
                    viewModel.showCategoryPicker = true
                }) {
                    HStack {
                        Text(viewModel.selectedCategory?.name ?? "All Categories")
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

                Button(action: {
                    if let amount = Double(viewModel.newBudgetAmount), amount.isFinite {
                        if viewModel.isEditingBudget {
                            viewModel.updateBudget()
                        } else {
                            viewModel.addBudget()
                        }
                        dismiss()
                    }
                }) {
                    Text("Save Budget")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.newBudgetName.isEmpty || viewModel.newBudgetAmount.isEmpty ? Color(UIColor.tertiarySystemBackground) : Color.blue)
                        .foregroundColor(viewModel.newBudgetName.isEmpty || viewModel.newBudgetAmount.isEmpty ? Color(UIColor.systemGray) : Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .disabled(viewModel.newBudgetName.isEmpty || viewModel.newBudgetAmount.isEmpty)

                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(20)
            .navigationTitle(viewModel.isEditingBudget ? "Edit Budget" : "Add New Budget")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .onDisappear {
                viewModel.activeSheet = nil
            }
        }
    }
}
