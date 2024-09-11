//
//  ColorMixViewModel.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 10.09.2024.
//

import SwiftUI

final class ColorMixViewModel: ObservableObject {
    var network = NetworkManager.shared
    @Published var colors: [CustomColor] = []
    @Published var colorName: String = ""
    
    func mixColors() -> Color {
        guard !colors.isEmpty else { return .white }
        
        var totalRed: CGFloat = 0
        var totalGreen: CGFloat = 0
        var totalBlue: CGFloat = 0
        
        for color in colors {
            let uiColor = UIColor(color.color)
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0
            uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            
            totalRed += red
            totalGreen += green
            totalBlue += blue
        }
        
        return Color(red: totalRed, green: totalGreen, blue: totalBlue)
    }
    
    func getHex() -> String {
        let uiColor = UIColor(mixColors())
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let _ = uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let redHexValue = String(format: "%02X", Int(red * 255))
        let greenHexValue = String(format: "%02X", Int(green * 255))
        let blueHexValue = String(format: "%02X", Int(blue * 255))
        
        return "\(redHexValue)\(greenHexValue)\(blueHexValue)"
    }
    
    func fetchColorName() {
        network.fetchColor(hex: getHex()) { [weak self] colorName in
            DispatchQueue.main.async { self?.colorName = colorName ?? "Unknown color" }
        }
    }
}
