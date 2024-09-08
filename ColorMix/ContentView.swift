//
//  ContentView.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 08.09.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                VStack {
                    Text("Green")
                    Rectangle()
                        .frame(maxHeight: 100)
                        .foregroundStyle(.green)
                    
                }
                Text("+")
                    .padding(.top, 35)
                    .font(.system(size: 20, weight: .bold))
                VStack {
                    Text("Red")
                    Rectangle()
                        .frame(maxHeight: 100)
                        .foregroundStyle(.red)
                    
                }
            }

            Text("=")
                .font(.system(size: 30, weight: .bold))
            VStack {
                Text("Brown")
                Rectangle()
                    .frame(maxHeight: 100)
                    .foregroundStyle(.black.mix(with: .white).mix(with: .red))
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
