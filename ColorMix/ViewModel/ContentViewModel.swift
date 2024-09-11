//
//  ContentViewModel.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 10.09.2024.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    let network = NetworkManager.shared
    
    func fetchColorName(hex: String, completion: @escaping (String) -> Void) {
        network.fetchColor(hex: hex) { colorName in
            DispatchQueue.main.async {
                completion(colorName ?? "Unknown color")
            }
        }
    }
}
