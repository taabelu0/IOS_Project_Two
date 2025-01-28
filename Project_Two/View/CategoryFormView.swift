//
//  CategoryFormView.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//

import SwiftUI

struct CategoryFormView: View {
    let parentCategories: [String]
    @Binding var newCategoryName: String
    @Binding var selectedParentCategory: String?
    var onSave: (String, String) -> Void

    var body: some View {
        VStack {
            Text("Add New Category")
                .font(.headline)
                .padding()

            TextField("Category Name", text: $newCategoryName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Picker("Parent Category", selection: $selectedParentCategory) {
                ForEach(parentCategories, id: \..self) { parent in
                    Text(parent).tag(parent as String?)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()

            Button(action: {
                if let parent = selectedParentCategory {
                    onSave(newCategoryName, parent)
                }
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
