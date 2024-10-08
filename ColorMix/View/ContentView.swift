//
//  ContentView.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 08.09.2024.
//

import SwiftUI

enum ColorAction {
    case add
    case edit(CustomColor)
}

struct ContentView: View {
    let viewModel = ContentViewModel()
    var action: ColorAction
    
    
    @State private var redIsOn: Bool = false
    @State private var redValue: Double = 127
    
    @State private var greenIsOn: Bool = false
    @State private var greenValue: Double = 127
    
    @State private var blueIsOn: Bool = false
    @State private var blueValue: Double = 127
    
    @Binding var colors: [CustomColor]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                VStack {
                    ColorItemView(isOn: $redIsOn, value: $redValue, color: .red, colorName: "Red")
                    ColorItemView(isOn: $greenIsOn, value: $greenValue, color: .green, colorName: "Green")
                    ColorItemView(isOn: $blueIsOn, value: $blueValue, color: .blue, colorName: "Blue")
                }
                .font(.system(size: 22, weight: .bold))
                
                VStack {
                    RectangleColor(height: 150, color: changeColor())
                        .animation(.easeInOut(duration: 0.5), value: changeColor())
                    Text("Hex value =".localized + "\(rgbToHex())")
                        .font(.system(size: 24, weight: .bold))
                }
                
                Button {
                    // Создаём новый цвет с временным именем
                    let newColor = CustomColor(color: changeColor(), name: "Unknown color")
                    
                    switch action {
                    case .add:
                        colors.append(newColor)
                    case .edit(let color):
                        if let index = colors.firstIndex(where: { $0.id == color.id }) {
                            colors[index] = newColor
                        }
                    }
                    
                    viewModel.fetchColorName(hex: rgbToHex()) { colorName in
                        // Обновляем название цвета в массиве после получения ответа
                        if let index = colors.firstIndex(where: { $0.id == newColor.id }) {
                            colors[index].name = colorName
                        }
                    }

                    dismiss()
                } label: {
                    Text("Add")
                        .padding(.vertical, 12)
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 10)
        .background(Color(.systemGray6))
        .scrollIndicators(.hidden)
    }
    
    func changeColor() -> Color {
        let red = redIsOn ? redValue / 255 : 0
        let green = greenIsOn ? greenValue / 255 : 0
        let blue = blueIsOn ? blueValue / 255 : 0
        
        return Color(red: red, green: green, blue: blue)
    }
    
    func rgbToHex() -> String {
        let redHexValue = String(format: "%02X", redIsOn ? Int(redValue) : 0)
        let greenHexValue = String(format: "%02X", greenIsOn ? Int(greenValue) : 0)
        let blueHexValue = String(format: "%02X", blueIsOn ? Int(blueValue) : 0)
        
        return "#\(redHexValue)\(greenHexValue)\(blueHexValue)"
    }
}

//extension Color {
//    func mix(with color: Color) -> Color {
//        let clampedPercentage = 0.5
//
//        let components1 = UIColor(self).cgColor.components!
//        let components2 = UIColor(color).cgColor.components!
//
//        let red = (1.0 - clampedPercentage) * components1[0] + clampedPercentage * components2[0]
//        let green = (1.0 - clampedPercentage) * components1[1] + clampedPercentage * components2[1]
//        let blue = (1.0 - clampedPercentage) * components1[2] + clampedPercentage * components2[2]
//        let alpha = (1.0 - clampedPercentage) * components1[3] + clampedPercentage * components2[3]
//
//        return Color(red: red, green: green, blue: blue, opacity: alpha)
//    }
//}
