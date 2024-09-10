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
    @Published var selectedColor: CustomColor? = nil
    
    func fetchAndUpdateColor(action: ColorAction, hex: String, newColor: Color) {
        network.fetchColor(hex: hex) { colorName in
            DispatchQueue.main.async { [weak self] in
                let newColor = CustomColor(color: newColor, name: colorName ?? "Unknown")
                
                switch action {
                case .add:
                    self?.colors.append(newColor)
                case .edit(let color):
                    if let index = self?.colors.firstIndex(where: { $0.id == color.id }) {
                        self?.colors[index] = newColor
                    }
                }
                print(newColor.name)
            }
        }
    }
}
