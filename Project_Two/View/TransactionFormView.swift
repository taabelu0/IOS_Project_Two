//
//  TransactionFormView.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//

import SwiftUI

struct TransactionFormView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    @Environment(\.presentationMode) var presentationMode // Ermöglicht das Schließen des Formulars
    @Environment(\.dismiss) var dismiss // Ermöglicht das Schließen des Filters
    
    let onSave: () -> Void // Callback für das Speichern

    var body: some View {
        NavigationView {
            VStack {
                TextField("Transaction Name", text: $viewModel.newTransactionName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Amount", text: Binding(
                    get: { viewModel.newTransactionAmount },
                    set: { newValue in
                        let filtered = newValue.filter { "0123456789.".contains($0) }
                        viewModel.newTransactionAmount = filtered
                    }
                )).keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
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
                    CategorySelectionView(viewModel: viewModel, allowAllCategories: false)
                }
                
                Button(action: {
                    if viewModel.isEditingTransaction {
                        viewModel.updateTransaction() // Falls Bearbeitung, Update ausführen
                    } else {
                        viewModel.addTransaction() // Falls neu, hinzufügen
                    }
                    presentationMode.wrappedValue.dismiss() // Formular schließen
                }) {
                    Text("Save")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.newTransactionName.isEmpty || viewModel.newTransactionAmount.isEmpty || viewModel.selectedCategory == nil ? Color(UIColor.tertiarySystemBackground) : Color.blue)
                        .foregroundColor(viewModel.newTransactionName.isEmpty || viewModel.newTransactionAmount.isEmpty || viewModel.selectedCategory == nil ? Color(UIColor.systemGray) : Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .disabled(viewModel.newTransactionName.isEmpty || viewModel.newTransactionAmount.isEmpty || viewModel.selectedCategory == nil)
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(20)
            .navigationTitle(viewModel.isEditingTransaction ? "Edit Transaction" : "Add New Transaction")
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
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
