//
//  CategoryFormView.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//
import SwiftUI

struct CategoryFormView: View {
    @ObservedObject var viewModel: TransactionsViewModel
    @Environment(\.presentationMode) var presentationMode // Ermöglicht das Schließen des Formulars
    @Environment(\.dismiss) var dismiss // Ermöglicht das Schließen des Filters

    let onSave: () -> Void

    var body: some View {
        NavigationView {
            VStack {
                TextField("Category Name", text: $viewModel.newCategoryName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Picker("Parent Category", selection: $viewModel.selectedParentCategory) {
                    Text("Select a Parent Category").tag(nil as String?)
                    ForEach(viewModel.parentCategories.keys.sorted(), id: \.self) { parent in
                        Text(parent).tag(parent as String?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                
                Button(action: {
                    viewModel.addCategory()
                    viewModel.activeSheet = nil // ✅ Neues Schließen des Modals mit `activeSheet`
                }) {
                    Text("Save")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.newCategoryName.isEmpty || viewModel.selectedParentCategory == nil ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .disabled(viewModel.newCategoryName.isEmpty || viewModel.selectedParentCategory == nil)
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(20)
            .navigationTitle("Add New Category")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                }
            }
            .onDisappear {
                viewModel.activeSheet = nil
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
