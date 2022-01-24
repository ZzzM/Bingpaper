//
//  MediumPaperView.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/4.
//

import SwiftUI

struct MediumView: View {

    let entry: Entry

    var body: some View {
        HStack(spacing: 0) {
            GeometryReader { p in
                WidgetPhotoView(entry: entry, width: p.size.height, height:  p.size.height)
            }
            .widgetURL(entry.widgetURL)

            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                MediumWeekdayView()
                MediumDaysView()
                Spacer()
            }
        }
        .padding()
        .background(Color.cellBackground)

    }

}

struct MediumWeekdayView: View {

    private let pref = Preference.shared

    private var weekdaySymbols: [String]  {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = pref.language.locale
        return dateFormatter.veryShortWeekdaySymbols
    }

    var body: some View {

        Text(Date(), formatter: DateFormatter.month)
            .foregroundColor(pref.palette.color)
            .fontWith(.caption, weight: .regular)
        
        LazyVGrid(columns: .weekdayColumns) {
            ForEach(weekdaySymbols.enumerated() + [], id: \.offset) {
                Text($0.1)
                    .fontWith(.caption2)
                    .foregroundColor($0.0 == 0 || $0.0 == 6 ? .secondary : .primary)
            }
        }
        .padding(.init(top: 8, leading: 0, bottom: 4, trailing: 0))

    }

}


struct MediumDaysView: View {

    private let pref = Preference.shared

    private let days = WidgetFetcher.fetchDays()

    private var spacing: CGFloat {
        days.count > 35 ? 2:4
    }

    var body: some View {

        LazyVGrid(columns: .weekdayColumns, spacing: spacing) {
            ForEach(days, id: \.title) { day in
                ZStack {
                    if day.inToday {
                        Rectangle()
                            .foregroundColor(pref.palette.color)
                            .frame(minWidth: 16, maxWidth: 18, minHeight: 16, maxHeight: 18)
                            .cornerRadius(3)
                    }
                    Text(day.title)
                        .fontWith(.caption2)
                        .foregroundColor(day.inToday ? .white:
                                            day.inWeekend ? .secondary:.primary)
                }

            }
        }

    }
}
