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
            ZStack {
                Color(UIColor.systemBackground)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    HStack {
                        Button(action: {
                            viewModel.activeSheet = .filter
                        }) {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .font(.title2)
                        }
                        .padding(.leading)

                        Spacer(minLength: 1)

                        Button(action: {
                            viewModel.activeSheet = .categoryForm
                        }) {
                            Image(systemName: "folder.badge.plus")
                        }
                        .padding(.trailing)

                        Button(action: {
                            viewModel.activeSheet = .transactionForm
                            viewModel.isEditingTransaction = false
                            viewModel.resetTransactionForm()
                        }) {
                            Image(systemName: "plus")
                        }
                        .padding(.trailing)
                    }
                    .padding(.top)
                    .padding(.bottom)
                    .background(Color(UIColor.systemBackground))

                    if viewModel.filteredTransactions.isEmpty {
                        VStack {
                            Image(systemName: "tray.fill") 
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)

                            Text("No Transactions Available")
                                .font(.title2)
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)

                            Text("Tap the '+' button to add a transaction.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
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
                        .listStyle(PlainListStyle())
                        .scrollContentBackground(.hidden)
                        .background(Color(UIColor.systemBackground))
                    }
                }
            }
            .navigationTitle("Transactions")
        }
        .onDisappear {
            viewModel.activeSheet = nil
        }
    }
}
