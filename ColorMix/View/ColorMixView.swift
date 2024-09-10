//
//  ColorMixView.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 10.09.2024.
//

import SwiftUI

struct ColorMixView: View {
    @StateObject private var viewModel = ColorMixViewModel()
    private let columns: [GridItem] = [GridItem(.flexible()),
                                       GridItem(.flexible())]
    
    @State private var nameColor: String = ""
    @State private var isPresenting = false
    @State private var colors: [CustomColor] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack {
                    NavigationLink {
                        ContentView(action: .add, colors: $colors)
                    } label: {
                        Text("Add new color")
                            .font(.system(size: 26, weight: .bold))
                    }

                    LazyVGrid(columns: columns) {
                        ForEach(colors) { color in
                            VStack {
                                Text(color.name)
                                NavigationLink {
                                    ContentView(action: .edit(color), colors: $colors)
                                } label: {
                                    RectangleColor(height: 100, color: color.color)
                                }
                            }
                        }
                    }
                }
                
                Text(colors.isEmpty ? "" : "=")
                    .font(.system(size: 28, weight: .bold))
                
                VStack {
                    
                    RectangleColor(height: 150, color: mixColors(colors))
                }
            }
            .padding()

        }
    }
    
    func mixColors(_ colors: [CustomColor]) -> Color {
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
        
        let count = CGFloat(colors.count)
        return Color(red: totalRed / count, green: totalGreen / count, blue: totalBlue / count)
    }
}

#Preview {
    ColorMixView()
}


