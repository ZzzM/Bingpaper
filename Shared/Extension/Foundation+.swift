//
//  Foundation+Extension.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//

import Foundation
import UIKit

extension Date {

    private var calendar: Calendar {
        Calendar.current
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


    var day: Int {
        calendar.component(.day, from: self)
    }

    var dayName: String {
        day.description
    }

    var weekday: Int {
        calendar.component(.weekday, from: self)
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

extension DateFormatter {
    static var weekday: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter
    }
    static var month: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter
    }
  
}

@available(iOSApplicationExtension, unavailable)
extension URL {
    func open() {
        guard UIApplication.shared.canOpenURL(self) else { return }
        UIApplication.shared.open(self, options:[:], completionHandler: .none)
    }
}