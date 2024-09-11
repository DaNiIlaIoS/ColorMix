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
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack {
                    NavigationLink {
                        ContentView(action: .add, colors: $viewModel.colors)
                    } label: {
                        Text("Add new color".localized)
                            .font(.system(size: 26, weight: .bold))
                    }
                    
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.colors) { color in
                            VStack {
                                Text(color.name.localized)
                                    .fontWeight(.bold)
                                NavigationLink {
                                    ContentView(action: .edit(color), colors: $viewModel.colors)
                                } label: {
                                    RectangleColor(height: 100, color: color.color)
                                }
                            }
                        }
                    }
                }
                
                Text(viewModel.colors.isEmpty ? "" : "=")
                    .font(.system(size: 28, weight: .bold))
                
                VStack {
                    Text("Result color: " + viewModel.colorName)
                        .fontWeight(.bold)
                    RectangleColor(height: 150, color: viewModel.mixColors() ?? .white)
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchColorName()
            }
        }
    }
}

#Preview {
    ColorMixView()
}


