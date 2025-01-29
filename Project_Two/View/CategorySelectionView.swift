//
//  CategorySelectionView.swift
//  Project_Two
//
//  Created by Marco Worni on 29.01.2025.
//
import SwiftUI

struct CategorySelectionView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    var allowAllCategories: Bool

    var body: some View {
        VStack {
            Text("Select a Category")
                .font(.headline)
                .padding()

            List {
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

                ForEach(Array(viewModel.parentCategories.keys).sorted(), id: \.self) { parent in
                    let filteredCategories = viewModel.categories.filter { $0.parentCategory == parent }

                    if !filteredCategories.isEmpty {
                        Section(header: Text(parent).foregroundColor(viewModel.parentCategories[parent])) {
                            ForEach(filteredCategories, id: \.id) { category in
                                HStack {
                                    Image(systemName: category.symbol)
                                        .foregroundColor(category.color)
                                    Text(category.name)
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    viewModel.selectedCategory = category
                                    viewModel.showCategoryPicker = false
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
