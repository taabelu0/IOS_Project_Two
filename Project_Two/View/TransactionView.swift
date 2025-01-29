//
//  TransactionView.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//
import SwiftUI

struct TransactionsView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    @State private var isFilterSheetPresented: Bool = false // Für das Filter-Modal

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Filter-Icon am linken Rand
                    Button(action: {
                        isFilterSheetPresented = true
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
                        viewModel.isShowingAddTransaction = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding(.trailing)
                }
                // Gefilterte Liste anzeigen
                List(viewModel.filteredTransactions) { transaction in
                    HStack {
                        Image(systemName: transaction.category.symbol)
                            .foregroundColor(transaction.category.color.opacity(0.3))
                        Text(transaction.name)
                        Spacer()
                        Text(String(format: "$%.2f", transaction.amount))
                    }
                }
            }
            .navigationTitle("Transactions")
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
            // Filter Sheet
            .sheet(isPresented: $isFilterSheetPresented) {
                FilterView(viewModel: viewModel)
            }
        }
    }
}
