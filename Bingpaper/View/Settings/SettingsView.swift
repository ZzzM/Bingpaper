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
                CacheRow(size: viewModel.cacheSize) { viewModel.cacheClear() }
                AboutSection()
            }
            .textCase(.none)
            .listRowBackground(Color.cellBackground)

            VersionView(version: viewModel.version)

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

        Section {
            GeneralPicker(title: L10n.Settings.language,
                          items: Language.allCases,
                          selection: $pref.language) {
                Text($0.title)
            }

            GeneralPicker(title: L10n.Settings.theme,
                          items: Theme.allCases,
                          selection: $pref.theme) {
                Text($0.title)
            }

            GeneralPicker(title: L10n.Settings.palette,
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
            Section {
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

struct AboutSection: View {
    var body: some View {
        Section {
            NavigationLink.init(L10n.Settings.changelogs, destination: ChangelogsView.init)
            NavigationLink.init(L10n.Settings.licenses, destination: LicensesView.init)
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


struct VersionView: View {

    @State
    private var isPresented = false

    let version: Version

    var body: some View {

        Section(content: {}, footer: {
            HStack {
                Spacer()
                Text("Version  \(AppInfo.version) ( \(AppInfo.gitHash) )").foregroundColor(.secondary)
                if !version.isLatest {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Text(L10n.Settings.newVersion)
                            .font(.caption2)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 3)
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .clipShape(Capsule())
                    }
                } 
                Spacer()
            }
        })
        .open(L10n.Alert.install,
              message: version.changelog,
              urlString: version.installUrl,
              isPresented: $isPresented)

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
                    NavigationLink(destination: {}, label: {})
                }
            }
        }
    }
}
