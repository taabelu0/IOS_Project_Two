//
//  CategorySelectionView.swift
//  Project_Two
//
//  Created by Marco Worni on 29.01.2025.
//
import SwiftUI

struct CategorySelectionView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    var allowAllCategories: Bool // Steuerung, ob "All Categories" angezeigt wird

    var body: some View {
        VStack {
            Text("Select a Category")
                .font(.headline)
                .padding()

            List {
                // Falls die View "All Categories" erlauben soll (nur für Budgets)
                if allowAllCategories {
                    Button(action: {
                        viewModel.selectedCategory = nil
                        viewModel.showCategoryPicker = false
                    }) {
                        HStack {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                            Text("All Categories")
                        }
                    }
                }

                // Kategorien nach Überkategorien gruppieren
                ForEach(viewModel.parentCategories.keys.sorted(), id: \.self) { parent in
                    Section(header: Text(parent).foregroundColor(viewModel.parentCategories[parent])) {
                        ForEach(viewModel.categories.filter { $0.parentCategory == parent }) { category in
                            Button(action: {
                                viewModel.selectedCategory = category
                                viewModel.showCategoryPicker = false
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
}
