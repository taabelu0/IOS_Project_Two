//
//  TransactionsView.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//

import SwiftUI

struct TransactionsView: View {
    @ObservedObject var viewModel: TransactionsViewModel

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Filter-Icon am linken Rand
                    Button(action: {
                        viewModel.isFilterSheetPresented = true
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title2)
                    }
                    .padding(.leading)

                    Spacer(minLength: 1)

                    // Buttons rechts in der Toolbar
                    Button(action: {
                        viewModel.isShowingAddCategory = true
                    }) {
                        Image(systemName: "folder.badge.plus")
                    }
                    .padding(.trailing)

                    Button(action: {
                        viewModel.isShowingTransactionForm = true
                        viewModel.isEditingTransaction = false // Neue Transaktion, keine Bearbeitung
                        viewModel.resetTransactionForm()
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding(.trailing)
                }
                .padding(.top)

                // Gefilterte Liste anzeigen
                List {
                    ForEach(viewModel.filteredTransactions, id: \.id) { transaction in
                        HStack(alignment: .top) {
                            Image(systemName: transaction.category.symbol)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .foregroundColor(transaction.category.color)

                            VStack(alignment: .leading) {
                                Text(transaction.name)
                                    .font(.headline)
                                Text(transaction.category.name)
                                    .font(.subheadline)
                                    .foregroundColor(transaction.category.color)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                            
                            Spacer()

                            Text(String(format: "$%.2f", transaction.amount))
                                .foregroundColor(transaction.amount < 0 ? .red : .primary)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.startEditingTransaction(transaction)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.deleteTransaction(at: indexSet)
                    }
                }
            }
            .navigationTitle("Transactions")
            .sheet(isPresented: $viewModel.isShowingTransactionForm, onDismiss: {
                viewModel.isShowingAddCategory = false
                viewModel.isFilterSheetPresented = false
            }) {
                TransactionFormView(viewModel: viewModel,
                                    onSave: {
                                        if viewModel.isEditingTransaction {
                                            viewModel.updateTransaction()
                                        } else {
                                            viewModel.addTransaction()
                                        }
                                        viewModel.isShowingTransactionForm = false
                                    })
            }
            .sheet(isPresented: $viewModel.isShowingAddCategory, onDismiss: {
                viewModel.isShowingTransactionForm = false
                viewModel.isFilterSheetPresented = false
            }) {
                CategoryFormView(viewModel: viewModel,
                                 onSave: {
                                     viewModel.addCategory()
                                     viewModel.isShowingAddCategory = false
                                 })
            }
            .sheet(isPresented: $viewModel.isFilterSheetPresented, onDismiss: {
                viewModel.isShowingTransactionForm = false
                viewModel.isShowingAddCategory = false
            }) {
                FilterView(viewModel: viewModel)
            }
        }
    }
}
