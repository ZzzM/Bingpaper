//
//  ChangelogView.swift
//  Bingpaper
//
//  Created by zm on 2022/1/24.
//


import MarkdownUI
import SwiftUI

struct ChangelogView: View {


    private let pref = Preference.shared

    var body: some View {

        ScrollView {
            Markdown(source).padding()
        }
        .background(Color.appBackground)
        .barTitle(L10n.Settings.changelog)
    }

    private var source: String {
        do {
            guard let url = Bundle.main.url(forResource: pref.language.changlog, withExtension: "md") else { return "" }
            return try String(contentsOf: url)
        } catch {
            return ""
        }
    }
}
