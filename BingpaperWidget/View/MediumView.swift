//
//  MediumPaperView.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/4.
//

import SwiftUI

struct MediumView: View {

    let entry: Entry

    private let days = WidgetFetcher.fetchDays()

    private var offset: CGFloat {
        days.count > 35 ? 3:5
    }

    var body: some View {
        HStack(spacing: 0) {
            GeometryReader { p in
                WidgetPhotoView(entry: entry, width: p.size.height, height:  p.size.height)
            }
            .widgetURL(entry.widgetURL)

            VStack(alignment: .trailing, spacing: 0) {
                Spacer()
                MediumWeekdayView(offset: offset)
                MediumDaysView(days: days, offset: offset)
                Spacer()
            }
        }
        .padding()
        .background(Color.cellBackground)

    }

}

struct MediumWeekdayView: View {

    @EnvironmentObject
    private var pref: WidgetPreference

    let  offset: CGFloat

    var body: some View {

        Text(Date().monthName)
            .foregroundColor(pref.tint)
            .fontWith(.caption, weight: .medium)
        
        LazyVGrid(columns: Array.weekdayColumns) {
            ForEach(Array.weekdaySymbols, id: \.offset) {
                Text($0.1)
                    .fontWith(.caption2)
                    .foregroundColor($0.0 == 0 || $0.0 == 6 ? .secondary : .primary)

            }
        }
        .padding(.vertical, offset)
    }

}


struct MediumDaysView: View {

    @EnvironmentObject
    private var pref: WidgetPreference

    let days: [PaperDay] , offset: CGFloat

    var body: some View {

        LazyVGrid(columns: Array.weekdayColumns, spacing: offset - 1) {
            ForEach(days, id: \.title) { day in
                ZStack {
                    if day.inToday {
                        Rectangle()
                            .foregroundColor(pref.tint)
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
