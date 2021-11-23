//
//  Paperday.swift
//  BingpaperWidget
//
//  Created by zm on 2021/11/4.
//

import Foundation

struct PaperDay {

    let title: String
    let inToday: Bool, inWeekend: Bool

    init() {
        title = ""
        inToday = false
        inWeekend = false
    }

    init(_ date: Date) {
        title = date.dayName
        inToday = date.inToday
        inWeekend = date.inWeekend
    }

}
