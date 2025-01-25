//
//  TransactionVIew.swift
//  Project_Two
//
//  Created by Luca Bertonazzi on 25.01.2025.
//

import SwiftUI

struct TransactionsView: View {
    var body: some View {
        NavigationView {
            List {
                //transaktionen werden hier aufgelistet
                Text("Transaction 1")
                Text("Transaction 2")
                Text("Transaction 3")
                Text("Transaction 4")
            }
            .navigationTitle("Transactions")
        }
    }
}

