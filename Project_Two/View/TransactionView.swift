//
//  TransactionView.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//

import SwiftUI

struct TransactionsView: View {
    @StateObject private var controller = TransactionsController()

    @State private var newTransactionName: String = ""
    @State private var newTransactionAmount: String = ""
    @State private var selectedCategory: Category? = nil
    @State private var isShowingAddTransaction: Bool = false
    @State private var isShowingCategorySelection: Bool = false
    @State private var isEditingTransaction: Bool = false
    @State private var editingTransaction: Transaction? = nil
    @State private var isShowingAddCategory: Bool = false
    @State private var newCategoryName: String = ""
    @State private var selectedParentCategory: String? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(controller.transactions) { transaction in
                    HStack {
                        Text(transaction.name)
                            .padding()
                            .background(transaction.category.color.opacity(0.3))
                            .cornerRadius(8)
                        Spacer()
                        Text(String(format: "$%.2f", transaction.amount))
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        editTransaction(transaction)
                    }
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingAddCategory = true
                    }) {
                        Image(systemName: "folder.badge.plus")
                    }

                    Button(action: {
                        isShowingAddTransaction = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddTransaction) {
                TransactionFormView(
                    isEditingTransaction: $isEditingTransaction,
                    newTransactionName: $newTransactionName,
                    newTransactionAmount: $newTransactionAmount,
                    selectedCategory: $selectedCategory,
                    categories: controller.categories,
                    parentCategories: controller.parentCategories,
                    onSave: { name, amount, category in
                        if isEditingTransaction, let editingTransaction = editingTransaction {
                            controller.updateTransaction(transaction: editingTransaction, name: name, amount: amount, category: category)
                        } else {
                            controller.addTransaction(name: name, amount: amount, category: category)
                        }
                        isShowingAddTransaction = false
                    },
                    onReset: {
                                newTransactionName = ""
                                newTransactionAmount = ""
                                selectedCategory = nil
                            }
                )
            }
            .sheet(isPresented: $isShowingAddCategory) {
                CategoryFormView(
                    parentCategories: controller.parentCategories.keys.sorted(),
                    newCategoryName: $newCategoryName,
                    selectedParentCategory: $selectedParentCategory,
                    onSave: { name, parent in
                        controller.addCategory(name: name, symbol: "questionmark", parent: parent)
                        isShowingAddCategory = false
                    }
                )
            }
        }
    }

    private func editTransaction(_ transaction: Transaction) {
        editingTransaction = transaction
        newTransactionName = transaction.name
        newTransactionAmount = String(transaction.amount)
        selectedCategory = transaction.category
        isEditingTransaction = true
        isShowingAddTransaction = true
    }
}
