//
//  Theme.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//
import SwiftUI

enum Theme: Int, CaseIterable {
    case system, light, dark

    static let `default`: Theme = .system

    var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        default: return .none
        }
    }

    var displayName: String {
        switch self {
        case .light: return "浅色"
        case .dark: return "深色"
        default: return "跟随系统"
        }
    }
}

