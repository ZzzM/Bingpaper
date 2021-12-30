//
//  PhotoLibrary.swift
//  Bingpaper
//
//  Created by zm on 2021/10/25.
//

import Photos
import UIKit

struct PhotoLibrary {

    static var isDeterminedForAddOnly: Bool {
        .notDetermined != PHPhotoLibrary.authorizationStatus(for: .addOnly)
    }

    static var isAuthorizedForAddOnly: Bool {
        .authorized == PHPhotoLibrary.authorizationStatus(for: .addOnly)
    }

    static func requestAuthorizationForAddOnly() async {
        guard .notDetermined == PHPhotoLibrary.authorizationStatus(for: .addOnly) else { return }
        await PHPhotoLibrary.requestAuthorization(for: .addOnly)
    }

    static func saveToAblum(_ image: UIImage) async -> Bool {
        do {
            try await PHPhotoLibrary.shared()
                .performChanges {
                    PHAssetCreationRequest.creationRequestForAsset(from: image)
                }
            return true
        } catch  {
            return false
        }
    }

}
