//
//  Category.swift
//  Project_Two
//
//  Created by Marco Worni on 28.01.2025.
//
import SwiftUI

struct Category: Identifiable {
    let id = UUID()
    var symbol: String
    var name: String
    var color: Color
    var parentCategory: String?
}

