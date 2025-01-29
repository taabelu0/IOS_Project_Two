//
//  BudgetPieChart.swift
//  Project_Two
//
//  Created by Marco Worni on 29.01.2025.
//
import SwiftUI
import Charts

struct BudgetPieChartView: View {
    @ObservedObject var viewModel: TransactionsViewModel

    var body: some View {
        VStack {
            Text(viewModel.selectedFilter == "All" ? "Budget by Category" : "Budget by Subcategory")
                .font(.headline)

            ZStack {
                Chart {
                    let data = viewModel.selectedFilter == "All"
                        ? viewModel.budgetDataForParentCategories()
                        : viewModel.budgetDataForSubcategories()

                    ForEach(data, id: \.name) { item in
                        SectorMark(
                            angle: .value("Amount", item.amount),
                            innerRadius: .ratio(0.5),
                            outerRadius: .ratio(1.0)
                        )
                        .foregroundStyle(item.color)
                    }
                }
                .frame(height: 250)

                // **KORREKTUR**: Verbleibender Betrag in der Mitte anzeigen
                Text(String(format: "$%.2f", viewModel.totalBudgetRemaining()))
                    .font(.title)
                    .bold()
            }
        }
        .padding()
    }
}
