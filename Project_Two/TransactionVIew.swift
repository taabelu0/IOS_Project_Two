//
//  TransactionVIew.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//
import SwiftUI

struct Transaction: Identifiable {
    let id = UUID()
    var name: String
    var category: Category
    var amount: Double
}

struct Category: Identifiable {
    let id = UUID()
    var symbol: String
    var name: String
    var color: Color
    var parentCategory: String?
}

struct TransactionsView: View {
    @State private var transactions: [Transaction] = []
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

    let parentCategories: [String: Color] = [
        "House": .blue,
        "Transportation": .green,
        "Groceries": .orange,
        "Entertainment": .purple,
        "Dining": .pink,
        "Health": .red,
        "Utilities": .gray
    ]

    @State private var categories: [Category] = [
        Category(symbol: "bed.double", name: "Furniture", color: .blue, parentCategory: "House"),
        Category(symbol: "house", name: "Rent", color: .blue, parentCategory: "House"),
        Category(symbol: "leaf", name: "Plants", color: .blue, parentCategory: "House"),
        Category(symbol: "car", name: "Car Payment", color: .green, parentCategory: "Transportation"),
        Category(symbol: "fuelpump", name: "Fuel", color: .green, parentCategory: "Transportation"),
        Category(symbol: "cart", name: "Groceries", color: .orange, parentCategory: "Groceries"),
        Category(symbol: "film", name: "Movies", color: .purple, parentCategory: "Entertainment"),
        Category(symbol: "gamecontroller", name: "Games", color: .purple, parentCategory: "Entertainment"),
        Category(symbol: "cup.and.saucer", name: "Coffee", color: .pink, parentCategory: "Dining"),
        Category(symbol: "fork.knife", name: "Restaurants", color: .pink, parentCategory: "Dining"),
        Category(symbol: "heart", name: "Health Insurance", color: .red, parentCategory: "Health"),
        Category(symbol: "hammer", name: "Repairs", color: .gray, parentCategory: "Utilities")
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(transactions) { transaction in
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
                VStack {
                    Text(isEditingTransaction ? "Edit Transaction" : "Add New Transaction")
                        .font(.headline)
                        .padding()

                    TextField("Transaction Name", text: $newTransactionName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    TextField("Amount", text: $newTransactionAmount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: {
                        isShowingCategorySelection = true
                    }) {
                        HStack {
                            Text(selectedCategory?.name ?? "Select Category")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $isShowingCategorySelection) {
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
                                                Text(category.name)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Button(action: {
                        if isEditingTransaction {
                            updateTransaction()
                        } else {
                            addTransaction()
                        }
                        isShowingAddTransaction = false
                    }) {
                        Text("Save")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    .disabled(newTransactionName.isEmpty || newTransactionAmount.isEmpty || selectedCategory == nil)

                    Spacer()
                }
                .padding()
                .presentationDetents([.fraction(0.5)])
                .background(Color.white)
                .cornerRadius(20)
            }
            .sheet(isPresented: $isShowingAddCategory) {
                VStack {
                    Text("Add New Category")
                        .font(.headline)
                        .padding()

                    TextField("Category Name", text: $newCategoryName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Picker("Parent Category", selection: $selectedParentCategory) {
                        ForEach(parentCategories.keys.sorted(), id: \..self) { parent in
                            Text(parent).tag(parent as String?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding()

                    Button(action: {
                        addCategory()
                        isShowingAddCategory = false
                    }) {
                        Text("Save")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    .disabled(newCategoryName.isEmpty || selectedParentCategory == nil)

                    Spacer()
                }
                .padding()
                .presentationDetents([.fraction(0.5)])
                .background(Color.white)
                .cornerRadius(20)
            }
        }
    }

    private func addTransaction() {
        guard let amount = Double(newTransactionAmount), let category = selectedCategory else { return }
        let transaction = Transaction(name: newTransactionName, category: category, amount: amount)
        transactions.append(transaction)
        clearForm()
    }

    private func editTransaction(_ transaction: Transaction) {
        editingTransaction = transaction
        newTransactionName = transaction.name
        newTransactionAmount = String(transaction.amount)
        selectedCategory = transaction.category
        isEditingTransaction = true
        isShowingAddTransaction = true
    }

    private func updateTransaction() {
        guard let index = transactions.firstIndex(where: { $0.id == editingTransaction?.id }), let amount = Double(newTransactionAmount), let category = selectedCategory else { return }
        transactions[index].name = newTransactionName
        transactions[index].amount = amount
        transactions[index].category = category
        clearForm()
    }

    private func addCategory() {
        guard let parent = selectedParentCategory else { return }
        if let color = parentCategories[parent] {
            let category = Category(symbol: "questionmark", name: newCategoryName, color: color, parentCategory: parent)
            categories.append(category)
            newCategoryName = ""
            selectedParentCategory = nil
        }
    }

    private func clearForm() {
        newTransactionName = ""
        newTransactionAmount = ""
        selectedCategory = nil
        isEditingTransaction = false
        editingTransaction = nil
    }
}


