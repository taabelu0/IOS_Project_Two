//
//  TransactionView.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//
import SwiftUI

struct TransactionsView: View {
    @StateObject private var viewModel = TransactionsViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.transactions) { transaction in
                    HStack {
                        Text(transaction.name)
                            .padding()
                            .background(transaction.category.color.opacity(0.3))
                            .cornerRadius(8)
                        Spacer()
                        Text(String(format: "$%.2f", transaction.amount))
                    }
                }
            }
            .navigationTitle("Transactions")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Add category",
                           systemImage: "folder.badge.plus",
                           action: {
                                viewModel.isShowingAddCategory = true
                        }
                    )
                    .labelStyle(.iconOnly)
                    
                    Button("Add transaction",
                           systemImage: "plus",
                           action: {
                        viewModel.isShowingAddTransaction = true
                        }
                    )
                    .labelStyle(.iconOnly)
                }
            }
            .sheet(isPresented: $viewModel.isShowingAddTransaction) {
                TransactionFormView(viewModel: viewModel,
                    onSave: {
                        viewModel.addTransaction()
                        viewModel.isShowingAddTransaction = false
                    })
            }
            .sheet(isPresented: $viewModel.isShowingAddCategory) {
                CategoryFormView(viewModel: viewModel,
                    onSave: {
                    viewModel.addCategory()
                    viewModel.isShowingAddCategory = false
                })
            }
        }
    }
}

