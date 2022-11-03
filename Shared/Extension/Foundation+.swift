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
        get {
            return Calendar.gregorian.component(.month, from: self)
        }
        set {
            guard newValue > 0 else { return }
            added(component: .month, value: newValue - month)
        }
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

    private mutating func added(_ calendar: Calendar = .gregorian, component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
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

    @available(iOSApplicationExtension, unavailable)
    func open() {
        guard let url = URL(string: self) else {
            return
        }
        url.open()
    }

}

extension URLComponents {
    mutating func setQueryItems(_ parameters: [String: String]) {
        queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }

    subscript(key: String) -> String? {
        guard queryItems != .none else { return .none }
        return queryItems!.first(where: { $0.name == key })?.value
    }
}


extension URL: Identifiable {
    public var id: String { absoluteString }
}

@available(iOSApplicationExtension, unavailable)
extension URL {


    func open() {
        guard UIApplication.shared.canOpenURL(self) else { return }
        UIApplication.shared.open(self, options:[:], completionHandler: .none)
    }

    subscript(key: String) -> String? {
        guard let components = URLComponents(string: self.absoluteString) else { return nil }
        return components[key]
    }
}


