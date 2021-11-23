//
//  Cache.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//

import Kingfisher
import Foundation

struct Cache {
    static func calculate() async -> Double {
        await withCheckedContinuation({ continuation in
            KingfisherManager.shared.cache.calculateDiskStorageSize {
                switch $0 {
                case .success(let size):
                    continuation.resume(returning: Double(size) / 1024 / 1024)
                case .failure:
                    continuation.resume(returning: 0)
                }
            }
        })
    }

    static func clear() async {
        await withCheckedContinuation({ continuation in
            KingfisherManager.shared.cache.clearCache {
                continuation.resume()
            }
        })
    }
}
