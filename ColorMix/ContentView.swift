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
    
    var body: some View {
        VStack(spacing: 50) {
            VStack {
                VStack {
                    HStack {
                        Toggle("", isOn: $redIsOn)
                            .labelsHidden()
                        Slider(value: $redValue, in: 0...255, step: 1)
                            .tint(.red)
                            .disabled(!redIsOn)
                    }
                    Text("Red = \(Int(redValue))")
                        .foregroundStyle(.red)
                        .opacity(redIsOn ? 1 : 0.6)
                        .animation(.easeInOut, value: redIsOn)
                }
                
                VStack {
                    HStack {
                        Toggle("", isOn: $greenIsOn)
                            .labelsHidden()
                        Slider(value: $greenValue, in: 0...255, step: 1)
                            .tint(.green)
                            .disabled(!greenIsOn)
                        
                    }
                    Text("Green = \(Int(greenValue))")
                        .foregroundStyle(.green)
                        .opacity(greenIsOn ? 1 : 0.6)
                }
                
                VStack {
                    HStack {
                        Toggle("", isOn: $blueIsOn)
                            .labelsHidden()
                        Slider(value: $blueValue, in: 0...255, step: 1)
                            .tint(.blue)
                            .disabled(!blueIsOn)
                    }
                    Text("Blue = \(Int(blueValue))")
                        .foregroundStyle(.blue)
                        .opacity(blueIsOn ? 1 : 0.6)
                }
            }
            .font(.system(size: 22, weight: .bold))
            Rectangle()
                .frame(maxHeight: 200)
                .foregroundStyle(changeColor())
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 5))
                .animation(.easeInOut(duration: 0.5), value: changeColor())
        }
        .padding()
    }
    
    func changeColor() -> Color{
        let red = redIsOn ? redValue / 255 : 0
        let green = greenIsOn ? greenValue / 255 : 0
        let blue = blueIsOn ? blueValue / 255 : 0
        
        return Color(red: red, green: green, blue: blue)
    }
}

#Preview {
    ContentView()
}

