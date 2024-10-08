//
//  ColorItemView.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 09.09.2024.
//

import SwiftUI

struct ColorItemView: View {
    @Binding var isOn: Bool
    @Binding var value: Double
    
    let color: Color
    let colorName: String
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Toggle("", isOn: $isOn)
                    .labelsHidden()
                Slider(value: $value, in: 0...255, step: 1)
                    .tint(color)
                    .disabled(!isOn)
                
            }
            Text("\(colorName.localized) = \(Int(value))")
                .foregroundStyle(color)
                .opacity(isOn ? 1 : 0.6)
                .animation(.easeInOut, value: isOn)
        }
    }
}

@Observable
class LanguageManager {
    var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "selectedLanguage")
        }
    }
    
    init() {
        self.currentLanguage = UserDefaults.standard.string(forKey: "selectedLanguage") ?? "en"
    }
}
