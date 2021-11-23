//
//  StateViewModel.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//
import SwiftUI

class StateViewModel: ObservableObject {

    @Published
    var state: ViewState = .idle

    func reset() {
        state = .idle
    }

}
