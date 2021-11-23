//
//  Foundation+Extension.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//

import Foundation

extension Date {

    private var calendar: Calendar {
        Calendar.defatult
    }

    var inToday: Bool {
        calendar.isDateInToday(self)
    }

    var inWeekend: Bool {
        calendar.isDateInWeekend(self)
    }

    var month: Int {
        calendar.component(.month, from: self)
    }

    var monthName: String {
        let dateFormatter = DateFormatter.default
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }

    var day: Int {
        calendar.component(.day, from: self)
    }

    var dayName: String {
        day.description
    }

    var weekday: Int {
        return calendar.component(.weekday, from: self)
    }
    
    var weekdayName: String {
        let dateFormatter = DateFormatter.default
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }


    var startOfMonth: Date {
        let dateComponents = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: dateComponents) ?? Date()
    }

    var startOfTomorrow: Date {
        let startOfDay = calendar.startOfDay(for: self)
        return calendar.date(byAdding: .day, value: 1, to: startOfDay) ?? Date()
    }

    var after15min: Date {
        calendar.date(byAdding: .minute, value: 15, to: self) ?? Date()
    }

    var daysOfMonth: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: self) else {
            return []
        }
        // Range(1..<?) to 0..<?
        let addValues = Array(range).indices
        return addValues.compactMap{
            calendar.date(byAdding: .day, value: $0, to: startOfMonth)
        }
    }

}

extension String {
    var urlEncoded: String {
        addingPercentEncoding(withAllowedCharacters:
                                        .alphanumerics) ?? ""
    }

    var urlDecoded: String {
        removingPercentEncoding ?? ""
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
