//
//  TransactionFormView.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//

import SwiftUI

struct TransactionFormView: View {
    @Binding var isEditingTransaction: Bool
    @Binding var newTransactionName: String
    @Binding var newTransactionAmount: String
    @Binding var selectedCategory: Category?

    @State private var isShowingCategorySelection: Bool = false

    let categories: [Category]
    let parentCategories: [String: Color]
    var onSave: (String, Double, Category) -> Void
    var onReset: () -> Void // Callback to reset the form

    var body: some View {
        VStack {
            Text(isEditingTransaction ? "Edit Transaction" : "Add New Transaction")
                .font(.headline)
                .padding()
            HStack {
                Button(action: {
                    isShowingCategorySelection = true
                }) {
                    HStack {
                            if let category = selectedCategory {
                                Image(systemName: category.symbol)
                                    .foregroundColor(category.color)
                            } else {
                                Image(systemName: "questionmark.circle")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $isShowingCategorySelection) {
                        VStack {
                            Text("Select a Category")
                                .font(.headline)
                                .padding()
                            
                            List {
                                ForEach(parentCategories.keys.sorted(), id: \..self) { parent in
                                    Section(header: Text(parent).foregroundColor(parentCategories[parent])) {
                                        ForEach(categories.filter { $0.parentCategory == parent }) { category in
                                            Button(action: {
                                                selectedCategory = category
                                                isShowingCategorySelection = false
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
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(20)
                    }
                    TextField("Transaction Name", text: $newTransactionName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    TextField("Amount", text: $newTransactionAmount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
            }

            Button(action: {
                if let amount = Double(newTransactionAmount), let category = selectedCategory {
                    onSave(newTransactionName, amount, category)
                }
            }) {
                Text("Save")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(newTransactionName.isEmpty || newTransactionAmount.isEmpty || selectedCategory == nil ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .disabled(newTransactionName.isEmpty || newTransactionAmount.isEmpty || selectedCategory == nil)

            Spacer()
        }
        .onAppear {
                    if !isEditingTransaction {
                        onReset() // Reset the form when adding a new transaction
                    }
                }
        .padding()
        .presentationDetents([.fraction(0.3)])
        .background(Color.white)
        .cornerRadius(20)
    }
}

#Preview {
    TransactionFormView(
                isEditingTransaction: .constant(false),
                newTransactionName: .constant(""),
                newTransactionAmount: .constant(""),
                selectedCategory: .constant(nil),
                categories: [
                    Category(symbol: "cart", name: "Groceries", color: .orange, parentCategory: "Essentials"),
                    Category(symbol: "house", name: "Rent", color: .blue, parentCategory: "Housing")
                ],
                parentCategories: [
                    "Essentials": .orange,
                    "Housing": .blue
                ],
                onSave: { name, amount, category in
                    print("Transaction saved: \(name), \(amount), \(category.name)")
                },
                onReset: {
                                print("Form reset")
                            }
            )
}
