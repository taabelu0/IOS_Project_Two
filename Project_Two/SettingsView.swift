//
//  SettingsView.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    Text("Name: test")
                    Text("Email: test@test.com")
                }
                
                Section(header: Text("Preferences")) {
                    Toggle("Notifications Enabled", isOn: .constant(false))
                    Toggle("Dark Mode", isOn: .constant(false))
                }
                
                Section {
                    Button("Log Out") {
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

