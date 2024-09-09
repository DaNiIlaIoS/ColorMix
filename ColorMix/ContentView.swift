//
//  ContentView.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 08.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var redIsOn: Bool = false
    @State private var redValue: Double = 127
    
    @State private var greenIsOn: Bool = false
    @State private var greenValue: Double = 127
    
    @State private var blueIsOn: Bool = false
    @State private var blueValue: Double = 127
    
    @State private var selectedLanguage: String = "en"

    var body: some View {
        ScrollView {
            VStack(spacing: 50) {
                Picker("Language", selection: $selectedLanguage) {
                    Text("English").tag("en")
                    Text("Русский").tag("ru")
                }
                .pickerStyle(SegmentedPickerStyle())
                
                VStack {
                    ColorItemView(isOn: $redIsOn, value: $redValue, color: .red, colorName: "Red")
                    ColorItemView(isOn: $greenIsOn, value: $greenValue, color: .green, colorName: "Green")
                    ColorItemView(isOn: $blueIsOn, value: $blueValue, color: .blue, colorName: "Blue")
                }
                .font(.system(size: 22, weight: .bold))
                
                VStack {
                    Rectangle()
                        .frame(height: 150)
                        .foregroundStyle(changeColor())
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 5))
                        .animation(.easeInOut(duration: 0.5), value: changeColor())
                    Text("Hex color = \(rgbToHex())")
                        .font(.system(size: 24, weight: .bold))
                }
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 10)
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

#Preview {
    ContentView()
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
