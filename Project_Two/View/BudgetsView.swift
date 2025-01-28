//
//  BudgetsView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//

import SwiftUI

struct BudgetsView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Budgets")
                    .font(.headline)
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.purple.opacity(0.3))
                        .frame(height: 100)
                        .overlay(Text("Budget 1").foregroundColor(.purple))
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.orange.opacity(0.3))
                        .frame(height: 100)
                        .overlay(Text("Budget 2").foregroundColor(.orange))
                }
                .padding(.horizontal)
                
                HStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.red.opacity(0.3))
                        .frame(height: 100)
                        .overlay(Text("Budget 3").foregroundColor(.red))
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.yellow.opacity(0.3))
                        .frame(height: 100)
                        .overlay(Text("Budget 4").foregroundColor(.yellow))
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Budgets")
        }
    }
}
