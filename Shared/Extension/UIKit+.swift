//
//  UIKitExtension.swift
//  Bingpaper
//
//  Created by zm on 2021/10/26.
//
import SwiftUI

extension UIScreen {
   static let width = UIScreen.main.bounds.size.width
   static let height = UIScreen.main.bounds.size.height
   static let size = UIScreen.main.bounds.size
}

extension UIImage {
    var averageColor: UIColor? {

        guard let inputImage = CIImage(image: self) else { return .none }

        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return .none }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)

        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: .none)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
}

