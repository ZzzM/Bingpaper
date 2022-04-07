//
//  CalendarView.swift
//  BingpaperWidget
//
//  Created by zm on 2022/4/7.
//

import SwiftUI

struct CalendarView<Day: View, Header: View, Week: View>: View {

    private let date: Date, firstWeekday: Int

    private let dayView: (Bool, Date) -> Day, header: () -> Header, weekView: (Date) -> Week

    init(date: Date = Date(),
         firstWeekday: Int = 1,
         @ViewBuilder header: @escaping () -> Header,
         @ViewBuilder weekView: @escaping (Date) -> Week,
         @ViewBuilder dayView: @escaping (Bool, Date) -> Day
    ) {
        self.date = date
        self.firstWeekday = firstWeekday
        self.dayView = dayView
        self.header = header
        self.weekView = weekView
    }

    private let columns = Array(repeating: GridItem(), count: DaysInWeek)

    var body: some View {

        let days = makeDays()
        let spacing: CGFloat = days.count > MinDates ? 2: 4

        LazyVGrid(columns: columns, spacing: spacing) {
            Section(content: {
                ForEach(0..<min(DaysInWeek, days.count), id: \.self) {
                    weekView(days[$0])
                }
                ForEach(days, id: \.self) { day in
                    dayView(date.inSameMonth(as: day), day)
                }
            }, header: header)
        }

    }

    private func makeDays() -> [Date]  {
        var calendar = Calendar.gregorian
        calendar.firstWeekday = firstWeekday
        return calendar.generateDates(for: date)
    }
}
