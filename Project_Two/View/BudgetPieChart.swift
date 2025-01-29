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

            let data = viewModel.selectedFilter == "All"
                ? viewModel.budgetDataForParentCategories()
                : viewModel.budgetDataForSubcategories()

            let totalBudget = viewModel.totalBudget()
            let totalSpent = viewModel.totalSpent()
            let remainingBudget = totalBudget - totalSpent
            let isOverBudget = totalSpent > totalBudget

            if !data.isEmpty && totalBudget > 0 {
                ZStack {
                    Chart {
                        ForEach(data, id: \.name) { item in
                            SectorMark(
                                angle: .value("Spent", item.amount),
                                innerRadius: .ratio(0.7),
                                outerRadius: .ratio(1.0)
                            )
                            .foregroundStyle(item.color) // **Jede Kategorie bekommt ihre eigene Farbe**
                        }

                        if remainingBudget > 0 {
                            SectorMark(
                                angle: .value("Remaining", remainingBudget),
                                innerRadius: .ratio(0.7),
                                outerRadius: .ratio(1.0)
                            )
                            .foregroundStyle(Color.gray.opacity(0.3))
                        }
                    }
                    .frame(height: 250)

                    Text(String(format: "$%.2f", remainingBudget))
                        .font(.title)
                        .bold()
                        .foregroundColor(isOverBudget ? .red : .primary)
                }
            } else {
                // Falls kein Budget vorhanden ist, nur Zahl anzeigen
                Text(String(format: "$%.2f", remainingBudget))
                    .font(.title)
                    .bold()
                    .foregroundColor(isOverBudget ? .red : .primary)
            }
        }
        .padding()
    }
}

