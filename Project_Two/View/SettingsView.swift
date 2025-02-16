//
//  SettingsView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: TransactionsViewModel

    var body: some View {
        NavigationView {
            Form {
                // Has to be updated when Login is implemented
                Section(header: Text("Profile")) {
                    Text("Name: test")
                    Text("Email: test@test.com")
                }
                
                Section(header: Text("Preferences")) {
                    Toggle("Dark Mode", isOn: $viewModel.isDarkMode)
                }
                
                Section {
                    Button(action: {
                        viewModel.isLoggedIn = false
                    }) {
                        Text ("Logout")
                    }
                }
            }
            .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
            .navigationTitle("Settings")
        }
    }
}

