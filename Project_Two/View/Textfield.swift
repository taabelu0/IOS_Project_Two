//
//  Textfield.swift
//  Project_Two
//
//  Created by Marco Worni on 30.01.2025.
//
import SwiftUI

extension Color {
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}

struct NeumorphicStyleTextField: View {
    var color: Color
    var textField: TextField<Text>
    var imageName: String
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.neumorphictextColor)
            textField
            }
            .padding()
            .foregroundColor(.neumorphictextColor)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(6)
            .shadow(color: Color(uiColor: .systemGray2), radius: 3, x: 2, y: 2)
            .shadow(color: color, radius: 1, x: -1, y: -1)
        }
}
