//
//  SettingsView.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import SwiftUI

struct SettingsView: View {

    @StateObject
    private var viewModel = SettingsViewModel()

    @State
    private var isShown = false

    init() {
        UITableView.appearance().backgroundColor = UIColor(.appBackground)
    }

    var body: some View {

        Form {
            GeneralSection()
            AboutSection()

            SettingsFooter()


        }
        .onAppear(perform: {
            viewModel.cacheCalculate()
        })
        .barTitle(L10n.Settings.title)
        .toolbar {

            ToolbarItem(placement: .primaryAction) {
                if viewModel.cacheSize > 0 {
                    Button {
                        isShown.toggle()
                    } label: {
                        Image.clear
                    }
                    .showAlert(L10n.Alert.clear,
                               message: String(format: "%.2g M", viewModel.cacheSize),
                               isPresented: $isShown,
                               action: viewModel.cacheClear)
                }
            }
        }


    }

}


struct GeneralSection: View {

    @EnvironmentObject
    private var pref: Preference

    var body: some View {

        Section {
            //            GeneralPicker(title: L10n.Settings.language,
            //                          items: Language.allCases,
            //                          selection: $pref.language) {
            //                Text($0.title)
            //            }

            GeneralPicker(title: L10n.Settings.theme,
                          items: Theme.allCases,
                          selection: $pref.theme) {
                Text($0.title)
            }

            SettingsRow(title: L10n.Settings.language, action: {
                UIApplication.openSettingsURLString.open()
            }) {
                EmptyView()
            }


        }

    }
}

struct AboutSection: View {
    var body: some View {
        Section {

            Link(destination: URL(string: L10n.changlogs) ?? .gitHub) {
                HStack {
                    Text(L10n.Settings.changelogs).foregroundColor(.primary)
                    NavigationLink {} label: {}
                }
            }
            NavigationLink.init(L10n.Settings.licenses, destination: LicensesView.init)
        }
    }
}

struct SettingsFooter: View {

    let version = "\(AppInfo.version) ( \(AppInfo.gitHash) )"

    var body: some View {
        Section {} footer: {
            Text(version)
                .font(.footnote)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

struct SettingsRow<Label: View>: View {

    let title: LocalizedStringKey, action: VoidClosure

    let label: () -> Label

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title).foregroundColor(.primary)
                ZStack(alignment: .trailing) {
                    label().padding(.horizontal)
                    NavigationLink {} label: {}
                }
            }
        }
    }
}
