//
//  LicensesView.swift
//  Bingpaper
//
//  Created by zm on 2022/4/6.
//

import SwiftUI

struct LicensesView: View {
    var body: some View {
        Form {
            ForEach(Dependencies.items, id: \.0) {
                NavigationLink($0.0, destination: LicenseView(dependence: $0))
            }
        }
        .barTitle(L10n.Settings.licenses)
    }
}

struct LicenseView: View {

    let dependence: (String, URL)

    var body: some View {
        
        ScrollView {
            ForEach(Dependencies.license(from: dependence.1), id: \.id) {
                Text($0.footerText)
            }.padding()
        }
        .background(Color.appBackground)
        .barTitle(dependence.0.l10nKey)
    }
}
