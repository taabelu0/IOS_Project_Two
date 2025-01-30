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
                HStack {
                    NeumorphicStyleTextField(color: viewModel.selectedCategory?.color ?? Color(Color(uiColor: .systemGray6)), textField: TextField("Budget Name", text: $viewModel.newBudgetName), imageName: "pencil")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    NeumorphicStyleTextField(color: viewModel.selectedCategory?.color ?? Color(Color(uiColor: .systemGray6)), textField: TextField("Amount", text: Binding(
                        get: { viewModel.newBudgetAmount },
                        set: { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            viewModel.newBudgetAmount = filtered
                        }
                    )) ,imageName: "dollarsign.circle")
                        .keyboardType(.decimalPad)
                        .frame(width: 120, alignment: .trailing)
                }
                .padding(.horizontal)
                .padding(.top)

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
                    .foregroundColor(viewModel.selectedCategory?.color ?? Color(Color(uiColor: .systemGray)))
                    .cornerRadius(8)
                }
                .padding()
                .sheet(isPresented: $viewModel.showCategoryPicker) {
                    CategorySelectionView(viewModel: viewModel, allowAllCategories: true)
                }

                Spacer()
                
                Button(action: {
                    if let amount = Double(viewModel.newBudgetAmount), amount.isFinite {
                        if viewModel.isEditingBudget {
                            viewModel.updateBudget()
                        } else {
                            viewModel.addBudget()
                        }
                        dismiss()
                    }
                }){
                    Text("Save")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.newBudgetName.isEmpty || viewModel.newBudgetAmount.isEmpty ? Color(UIColor.tertiarySystemBackground) : viewModel.selectedCategory?.color ?? .secondary)
                        .foregroundColor(viewModel.newBudgetName.isEmpty || viewModel.newBudgetAmount.isEmpty ? Color(UIColor.systemGray) : Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .disabled(viewModel.newBudgetName.isEmpty || viewModel.newBudgetAmount.isEmpty)

                Spacer()
            }
            .padding(.top)
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
