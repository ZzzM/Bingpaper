//
//  ChangelogsView.swift
//  Bingpaper
//
//  Created by zm on 2022/1/24.
//


import MarkdownView
import SwiftUI

struct ChangelogsView: View {

    var body: some View {

        ScrollView {
            MarkdownUI(body: source)
        }
        .background(Color.appBackground)
        .barTitle(L10n.Settings.changelogs)
    }

    private var source: String {
        do {
            
            guard let url = Bundle.main.url(forResource: L10n.changlogs, withExtension: "md") else { return "" }
            return try String(contentsOf: url)
        } catch {
            return "No Changlogs"
        }
    }
}
