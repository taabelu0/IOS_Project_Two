//
//  CategoryFormView.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//

import SwiftUI

struct CategoryFormView: View {
    @ObservedObject var viewModel: TransactionsViewModel // Zugriff auf das ViewModel
    
    let onSave: () -> Void // Callback für das Speichern

    var body: some View {
        VStack {
            Text("Add New Category")
                .font(.headline)
                .padding()

            TextField("Category Name", text: $viewModel.newCategoryName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Picker("Parent Category", selection: $viewModel.selectedParentCategory) {
                ForEach(viewModel.parentCategories.keys.sorted(), id: \.self) { parent in
                    Text(parent).tag(parent as String?)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            Button(action: {
                viewModel.addCategory() // Ruft die Logik aus dem ViewModel auf
                viewModel.isShowingAddCategory = false // Schließt das Modal
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
        .presentationDetents([.fraction(0.5)])
        .background(Color(UIColor.systemBackground))
        .cornerRadius(20)
    }
}
