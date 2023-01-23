//
//  ContentView.swift
//  BarChart
//
//  Created by Javlonbek on 23/01/23.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    let viewMonths: [ViewMonth] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), viewCount: 55000),
        .init(date: Date.from(year: 2023, month: 2, day: 1), viewCount: 89000),
        .init(date: Date.from(year: 2023, month: 3, day: 1), viewCount: 45000),
        .init(date: Date.from(year: 2023, month: 4, day: 1), viewCount: 65000),
        .init(date: Date.from(year: 2023, month: 5, day: 1), viewCount: 79000),
        .init(date: Date.from(year: 2023, month: 6, day: 1), viewCount: 29000),
        .init(date: Date.from(year: 2023, month: 7, day: 1), viewCount: 10000),
        .init(date: Date.from(year: 2023, month: 8, day: 1), viewCount: 56000),
        .init(date: Date.from(year: 2023, month: 9, day: 1), viewCount: 99000),
        .init(date: Date.from(year: 2023, month: 10, day: 1), viewCount: 110000),
        .init(date: Date.from(year: 2023, month: 11, day: 1), viewCount: 69000),
        .init(date: Date.from(year: 2023, month: 12, day: 1), viewCount: 82000),
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Youtube Views")
                .bold()
                .font(.title3)
            
            Text("Total: 1,036,000")
                .foregroundColor(.secondary)
            
            Chart {
                RuleMark(y: .value("Goal", 80000))
                    .foregroundStyle(.mint)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(alignment: .leading) {
                        Text("Goal")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                
                ForEach(viewMonths) { item in
                    BarMark(
                        x: .value("Month", item.date, unit: .month),
                        y: .value("Views", item.viewCount)
                    )
                    .foregroundStyle(.pink.gradient)
                    .cornerRadius(5)
                }
            }
            .frame(height: 200)
            .chartYScale(domain: 0...130000)
            .chartXAxis {
                AxisMarks(values: viewMonths.map{ $0.date } ) { date in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.narrow))
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ViewMonth: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let viewCount: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let component = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: component)!
    }
}
