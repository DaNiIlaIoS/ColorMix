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
    @State var numberOfPeople = 2
    @State private var selectedLanguage: String = "en"
    @State private var nameColor: String = ""
    @State private var isPresenting = false
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(spacing: 30) {
                        Picker("Language", selection: $selectedLanguage) {
                            Text("English").tag("en")
                            Text("Русский").tag("ru")
                        }
                        .pickerStyle(SegmentedPickerStyle())
        //                .onChange(of: selectedLanguage) {
        //                    languageSettings.locale = Locale(identifier: "en-US")
        //                }
                        VStack {
                            NavigationLink {
                                ContentView(action: .add, colors: $viewModel.colors)
                            } label: {
                                Text("Add new color")
                                    .font(.system(size: 26, weight: .bold))
                            }
                        }
                        
                        VStack {
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
                            
                            Text(viewModel.colors.isEmpty ? "" : "=")
                                .font(.system(size: 28, weight: .bold))
                            
                            VStack {
                                Text("Mixing result".localized + viewModel.colorName.localized)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                
                                RectangleColor(height: 150, color: viewModel.mixColors() ?? .white)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                VStack {
                    Button(action: {
                        withAnimation(.bouncy) {
                            viewModel.colors.removeAll()
                            viewModel.colorName = ""
                        }
                    }, label: {
                        Text("Remove colors")
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .foregroundStyle(.white)
                            .clipShape(Capsule())
                    })
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            .navigationTitle("ColorMix")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.fetchColorName()
            }
        }
    }
}

#Preview {
    ColorMixView()
}


