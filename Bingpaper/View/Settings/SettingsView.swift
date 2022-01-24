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

    init() {
        UITableView.appearance().backgroundColor = UIColor(.appBackground)
    }

    var body: some View {
        Form {
            Group {
                GeneralSection()
                PermissionSection()
                Section(L10n.Settings.other) {
                    CacheRow(size: viewModel.cacheSize) { viewModel.cacheClear() }
                    ChangelogRow()
                    AboutRow(version: viewModel.version)
                }
            }
            .textCase(.none)
            .listRowBackground(Color.cellBackground)

        }
        .onAppear(perform: {
            viewModel.cacheCalculate()
            viewModel.checkForUpdate()
        })
        .barTitle(L10n.Settings.title)

    }

}


struct GeneralSection: View {

    @EnvironmentObject
    private var pref: Preference

    var body: some View {

        Section(L10n.Settings.general) {

            GeneralPicker(titleKey: L10n.Settings.language,
                          items: Language.allCases,
                          selection: $pref.language) {
                Text($0.displayName)
            }

            GeneralPicker(titleKey: L10n.Settings.theme,
                          items: Theme.allCases,
                          selection: $pref.theme) {
                Text($0.displayName)
            }

            GeneralPicker(titleKey: L10n.Settings.palette,
                          items: Palette.allCases,
                          selection: $pref.palette) {
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor($0.color)

            }

        }

    }
}

struct PermissionSection: View {

    @State
    private var isPresented = false

    var body: some View {
        if PhotoLibrary.isDeterminedForAddOnly {
            Section(L10n.Settings.permission) {
                Toggle(L10n.Permission.addPhotos, isOn: .constant(PhotoLibrary.isAuthorizedForAddOnly))
                    .toggleStyle(CheckboxStyle(active: false))
                    .onTapGesture {
                        isPresented.toggle()
                    }
            }
            .open(L10n.Alert.confirmPermission, isPresented: $isPresented)
        }
    }
}


struct CacheRow: View {

    let size: Double, action: VoidClosure

    @State
    private var isPresented = false

    var body: some View {
        SettingsRow(title: L10n.Settings.cache) {
            isPresented.toggle()
        } label: {
            Text(String(format: "%.2g M", size))
                .foregroundColor(.secondary)
        }
        .disabled(size <= 0)
        .showAlert(L10n.Alert.clear, isPresented: $isPresented, action: action)
    }

}

struct ChangelogRow: View {
    var body: some View {
        NavigationLink.init(L10n.Settings.changelog, destination: ChangelogView.init)
    }

}

struct AboutRow: View {

    @State
    private var isPresented = false

    let version: Version

    var body: some View {

        SettingsRow(title: L10n.Settings.about) {
            isPresented.toggle()
        } label: {
            HStack {
                Text(AppInfo.displayVersion).foregroundColor(.secondary)
                if !version.isLatest {
                    Text(L10n.Alert.new)
                        .font(.caption)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(.tint)
                        .cornerRadius(5)
                }
            }
        }
        .disabled(version.isLatest)
        .open(L10n.Alert.install,
              message: version.changelog,
              urlString: version.installUrl,
              isPresented: $isPresented)

    }

}

struct SettingsRow<Label: View>: View {

    let title: LocalizedStringKey, action: VoidClosure

    @ViewBuilder
    let label: () -> Label

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title).foregroundColor(.primary)
                ZStack(alignment: .trailing) {
                    label().padding(.horizontal)
                    NavigationLink(destination: {}, label: {})
                }
            }
        }
    }
}
