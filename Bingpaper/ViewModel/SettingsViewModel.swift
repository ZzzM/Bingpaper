//
//  SettingsViewModel.swift
//  Bingpaper
//
//  Created by zm on 2021/11/16.
//

import Combine
import CoreGraphics

class SettingsViewModel: StateViewModel {

    @Published
    var cacheSize: Double = 0


    @MainActor
    func cacheCalculate() {
        Task{
            cacheSize = await Cache.calculate()
        }
    }


    func cacheClear() {
        Task{
            await Cache.clear()
            cacheSize = 0
        }
    }

}
