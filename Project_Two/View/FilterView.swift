//
//  FilterView.swift
//  Project_Two
//
//  Created by Marco Worni on 29.01.2025.
//
import SwiftUI

struct FilterView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    @Environment(\.dismiss) var dismiss // Ermöglicht das Schließen des Filters

    var body: some View {
        NavigationView {
            VStack {
                List {
                    // ✅ **"All Transactions" Option**
                    Button(action: {
                        viewModel.selectedFilter = "All"
                        dismiss()
                    }) {
                        HStack {
                            Text("All Transactions")
                                .fontWeight(viewModel.selectedFilter == "All" ? .bold : .regular)
                            Spacer()
                            if viewModel.selectedFilter == "All" {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }

                    // ✅ **Filter nach Überkategorien und Kategorien**
                    ForEach(viewModel.parentCategories.keys.sorted(), id: \.self) { parent in
                        Section(header: Text(parent).foregroundColor(viewModel.parentCategories[parent])) {
                            
                            // ✅ Button für "All [ParentCategory]" direkt oben in der Section
                            Button(action: {
                                viewModel.selectedFilter = parent
                                dismiss()
                            }) {
                                HStack {
                                    Text("All \(parent)")
                                        .fontWeight(viewModel.selectedFilter == parent ? .bold : .regular)
                                        .foregroundColor(viewModel.parentCategories[parent])
                                    Spacer()
                                    if viewModel.selectedFilter == parent {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }

                            // ✅ Alle Unterkategorien dieser Überkategorie
                            ForEach(viewModel.categories.filter { $0.parentCategory == parent }, id: \.id) { category in
                                Button(action: {
                                    viewModel.selectedFilter = category.name
                                    dismiss()
                                }) {
                                    HStack {
                                        Text(category.name)
                                            .fontWeight(viewModel.selectedFilter == category.name ? .bold : .regular)
                                            .foregroundColor(viewModel.parentCategories[parent])
                                        Spacer()
                                        if viewModel.selectedFilter == category.name {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.blue)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
        }
    }
}
