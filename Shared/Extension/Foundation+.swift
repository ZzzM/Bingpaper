//
//  Foundation+Extension.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//

import Foundation
import UIKit

extension Date {

    var inToday: Bool {
        Calendar.gregorian.isDateInToday(self)
    }

    var inWeekend: Bool {
        Calendar.gregorian.isDateInWeekend(self)
    }

    var month: Int {
        Calendar.gregorian.component(.month, from: self)
    }


    var day: Int {
        Calendar.gregorian.component(.day, from: self)
    }

    var weekday: Int {
        Calendar.gregorian.component(.weekday, from: self)
    }

    var startOfMonth: Date {
        let dateComponents = Calendar.gregorian.dateComponents([.year, .month], from: self)
        return Calendar.gregorian.date(from: dateComponents) ?? self
    }

    var startOfTomorrow: Date {
        let startOfDay = Calendar.gregorian.startOfDay(for: self)
        return Calendar.gregorian.date(byAdding: .day, value: 1, to: startOfDay) ?? self
    }

    var after15min: Date {
        Calendar.gregorian.date(byAdding: .minute, value: 15, to: self) ?? Date()
    }

    func inSameMonth(as date: Date) -> Bool {
        Calendar.gregorian.isDate(self, equalTo: date, toGranularity: .month)
    }

}

extension Calendar {

    func generateDates(for date: Date) -> [Date] {

        var dates: [Date] = []

        guard let range = range(of: .day, in: .month, for: date) else {
            return dates
        }
        // Range(1..<?) to 0..<?
        let startOfMonth = date.startOfMonth
        for value in Array(range).indices {
            let date = self.date(byAdding: .day, value: value, to: startOfMonth) ?? startOfMonth
            dates.append(date)
        }

        var weekday = startOfMonth.weekday
        weekday += weekday >= firstWeekday ? 0 : DaysInWeek

        let lastCount = weekday - firstWeekday

        if lastCount > 0 {
            var lastDates: [Date] = []
            for value in (1...lastCount).reversed() {
                let date = self.date(byAdding: .day, value: -value, to: startOfMonth) ?? startOfMonth
                lastDates.append(date)
            }
            dates = lastDates + dates
        }

        let total = dates.count > MinDates ? MaxDates: MinDates
        let nextCount = total - dates.count

        if nextCount > 0, let endOfMonth = dates.last {
            var nextDates: [Date] = []
            for value in 1...nextCount {
                let date = self.date(byAdding: .day, value: value, to: endOfMonth) ?? endOfMonth
                nextDates.append(date)
            }
            dates += nextDates
        }

        return dates
    }

}

extension String {
    var urlEncoded: String {
        addingPercentEncoding(withAllowedCharacters:
                                        .alphanumerics) ?? self
    }

    var urlDecoded: String {
        removingPercentEncoding ?? self
    }

}

extension URLComponents {
    mutating func setQueryItems(_ parameters: [String: String]) {
        queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }

    var parameters: [String: String] {
        guard queryItems != nil else { return [:] }
        var _parameters: [String: String] = [:]
        for item in queryItems! {
            _parameters[item.name] = item.value
        }
        return _parameters
    }
}



@available(iOSApplicationExtension, unavailable)
extension URL {
    func open() {
        guard UIApplication.shared.canOpenURL(self) else { return }
        UIApplication.shared.open(self, options:[:], completionHandler: .none)
    }
}
