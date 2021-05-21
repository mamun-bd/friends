//
//  UIColor+Extension.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

extension UIColor {

    convenience init(hex: Int, alpha: CGFloat) {
        let calculatedRed = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let calculatedGreen = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let calculatedBlue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: calculatedRed, green: calculatedGreen, blue: calculatedBlue, alpha: alpha)
    }

    convenience init(hexString str: String, alpha: CGFloat) {
        let range = NSRange(location: 0, length: str.lengthOfBytes(using: .utf8))
        let hex = (str as NSString).replacingOccurrences(of: "[^0-9a-fA-F]", with: "", options: .regularExpression, range: range)
        var color: UInt32 = 0
        Scanner(string: hex).scanHexInt32(&color)
        self.init(hex: Int(color), alpha: alpha)
    }

    var hexString: String? {
        return self.cgColor.hexString
    }

    var RGBa: (red: Int, green: Int, blue: Int, alpha: CGFloat)? {
        return self.cgColor.RGBa
    }

}

extension CGColor {

    var hexString: String? {
        if let rgba = self.RGBa {
            let hex = rgba.red * 0x10000 + rgba.green * 0x100 + rgba.blue
            return NSString(format: "%06x", hex) as String
        } else {
            return nil
        }
    }

    var RGBa: (red: Int, green: Int, blue: Int, alpha: CGFloat)? {
        let colorSpace = self.colorSpace
        let colorSpaceModel = colorSpace!.model
        if colorSpaceModel.rawValue == 1 {
            let elements = self.components
            let red: Int = Int(elements![0] * 255.0)
            let green: Int = Int(elements![1] * 255.0)
            let blue: Int = Int(elements![2] * 255.0)
            let calculatedAlpha: CGFloat = elements![3]
            return (red, green, blue, calculatedAlpha)
        } else {
            return nil
        }
    }

}

