//
//  Palette.swift
//  Bingpaper
//
//  Created by zm on 2021/11/2.
//

import SwiftUI

enum Palette: String, CaseIterable {

    case
    red,
    orange,
    yellow,
    mint,
    teal,
    cyan,
    blue,
    indigo,
    purple,
    pink,
    brown,
    gray

    
    var color: Color {
        switch self {
        case .red: return .red
        case .orange: return .orange
        case .blue: return .blue
        case .yellow: return .yellow
        case .mint:  return .mint
        case .teal: return .teal
        case .cyan: return .cyan
        case .indigo: return .indigo
        case .purple: return .purple
        case .pink: return .pink
        case .brown: return .brown
        case .gray: return .gray
        }
    }

}
