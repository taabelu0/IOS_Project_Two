//
//  SettingsView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    Text("Name: test")
                    Text("Email: test@test.com")
                }
                
                Section(header: Text("Preferences")) {
                    Toggle("Notifications Enabled", isOn: .constant(false))
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section {
                    Button("Log Out") {
                    }
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .navigationTitle("Settings")
        }
    }
}

