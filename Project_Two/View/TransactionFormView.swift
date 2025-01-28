//
//  TransactionFormView.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//
import SwiftUI

struct TransactionFormView: View {
    @ObservedObject var viewModel: TransactionsViewModel // Zugriff auf das ViewModel

    let onSave: () -> Void // Callback für das Speichern

    var body: some View {
        VStack {
            Text(viewModel.isEditingTransaction ? "Edit Transaction" : "Add New Transaction")
                .font(.headline)
                .padding()
                .foregroundColor(Color(UIColor.label))

            TextField("Transaction Name", text: $viewModel.newTransactionName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Amount", text: $viewModel.newTransactionAmount)
                .keyboardType(.decimalPad)
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
            .sheet(isPresented: .constant(viewModel.showCategoryPicker == true && viewModel.selectedCategory == nil)) {
                VStack {
                    Text("Select a Category")
                        .font(.headline)
                        .padding()

                    List {
                        ForEach(viewModel.parentCategories.keys.sorted(), id: \.self) { parent in
                            Section(header: Text(parent).foregroundColor(viewModel.parentCategories[parent])) {
                                ForEach(viewModel.categories.filter { $0.parentCategory == parent }) { category in
                                    Button(action: {
                                        viewModel.selectedCategory = category
                                    }) {
                                        HStack {
                                            Image(systemName: category.symbol)
                                                .foregroundColor(category.color)
                                            Text(category.name)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .background(Color(UIColor.systemBackground))
                .cornerRadius(20)
            }

            Button(action: {
                onSave()
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
        .presentationDetents([.fraction(0.5)])
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
    }
}
