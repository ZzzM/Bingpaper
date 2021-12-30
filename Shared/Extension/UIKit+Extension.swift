//
//  UIKitExtension.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//
import SwiftUI

extension UIScreen {
   static let width = UIScreen.main.bounds.size.width
   static let height = UIScreen.main.bounds.size.height
   static let size = UIScreen.main.bounds.size
}


extension UIScreen {
    var isDark: Bool {
        traitCollection.userInterfaceStyle == .dark
    }

    var colorScheme: ColorScheme {
        isDark ? .dark:.light
    }
}

