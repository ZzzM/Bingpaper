//
//  GeneralPicker.swift
//  Bingpaper
//
//  Created by zm on 2022/1/19.
//

import SwiftUI

struct GeneralPicker<Value, Label>: View where Value: Hashable, Label: View {

    let title: LocalizedStringKey, items: [Value]

    @Binding
    var selection: Value

    let label: (Value) -> Label

    var body: some View {
        Picker(title, selection: $selection) {
            ForEach(items, id: \.self) {
                label($0)
            }
        }
    }

}
