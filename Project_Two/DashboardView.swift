//
//  DashboardView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Finance Overview")
                    .font(.headline)
                
                //zusammenfassung
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.opacity(0.3))
                    .frame(height: 150)
                    .overlay(Text("Summary Card").foregroundColor(.blue))
                
                //genauere ansicht oder eine art chart
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.green.opacity(0.3))
                    .frame(height: 200)
                    .overlay(Text("Chart/Insight Area").foregroundColor(.green))
                
                Spacer()
            }
            .padding()
            .navigationTitle("Dashboard")
        }
    }
}

