//
//  ColorExtension.swift
//  SwiftUICustomLoader
//
//  Created by Aakif Nadeem on 25/09/2023.
//

import Foundation
import SwiftUI

extension Color {
    //Loader
    static let circleRoundStart: Color = Color(hex: "#141414")
    static let circleLoaderColor: Color = Color(hex: "##5A5A5A")
    
    
    init(hex string: String) {
        var hex = string.hasPrefix("#")
        ? String(string.dropFirst())
        : string
        guard hex.count == 3 || hex.count == 6
        else {
            self.init(white: 1.0)
            return
        }
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0)
    }
    
    init(r: Double, g: Double, b: Double) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0)
    }
}
