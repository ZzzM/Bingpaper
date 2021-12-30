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
                ColorSection()
                PermissionSection()
                Section("其他") {
                    CacheRow(size: viewModel.cacheSize) { viewModel.cacheClear() }
                    VersionRow(version: viewModel.version)
                }
            }
            .listRowBackground(Color.cellBackground)

        }
        .onAppear(perform: {
            viewModel.cacheCalculate()
            viewModel.checkForUpdate()
        })
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("设置")
                    .fontWith(.title2)
                    .foregroundColor(.accentColor)
            }
        }

    }

}

struct ColorSection: View {

    @EnvironmentObject
    private var pref: Preference

    var body: some View {

        Section("色彩偏好") {

            Picker("主题", selection: pref.$theme) {
                ForEach(Theme.allCases, id: \.self) {
                    Text($0.displayName)
                }
            }

            Picker("配色", selection: pref.$palette) {
                ForEach(Palette.allCases, id: \.self) {
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor($0.color)
                }
            }
        }

    }
}

struct PermissionSection: View {

    @State
    private var isPresented = false

    var body: some View {
        if PhotoLibrary.isDeterminedForAddOnly {
            Section("权限") {
                Toggle("相册写入", isOn: .constant(PhotoLibrary.isAuthorizedForAddOnly))
                    .toggleStyle(CheckboxStyle())
                    .onTapGesture {
                        isPresented.toggle()
                    }
            }
            .open("修改相册写入权限？", isPresented: $isPresented)
        }
    }
}


struct CacheRow: View {

    let size: Double, action: VoidClosure

    @State
    private var isPresented = false

    var body: some View {
        SettingsRow(title: "清理缓存") {
            isPresented.toggle()
        } label: {
            Text(String(format: "%.2g M", size))
                .foregroundColor(.secondary)
        }
        .disabled(size <= 0)
        .showAlert("清除缓存？", isPresented: $isPresented, action: action)
    }

}

struct VersionRow: View {

    let version: Version

    @State
    private var isPresented = false

    var body: some View {
        SettingsRow(title: "版本") {
            isPresented.toggle()
        } label: {
            HStack {
                Text("\(AppInfo.version.value)( \(AppInfo.build.value) )").foregroundColor(.secondary)
                if !version.isLatest {
                    Text("检测到更新")
                        .font(.caption)
                        .padding(5)
                        .foregroundColor(.white)
                        .background(.tint)
                        .cornerRadius(5)
                }
            }
        }
        .disabled(version.isLatest)
        .open("下载更新？",
              message: version.changelog,
              urlString: version.installUrl,
              isPresented: $isPresented)

    }

}

struct SettingsRow<Label: View>: View {

    let title: String, action: VoidClosure, label: () -> Label

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title).foregroundColor(.primary)
                Spacer()
                label()
            }
        }
    }
}
