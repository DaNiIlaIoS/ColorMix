//
//  RectangleColor.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 10.09.2024.
//

import SwiftUI

struct RectangleColor: View {
    let height: CGFloat
    let color: Color
    
    var body: some View {
        Rectangle()
            .frame(height: height)
            .foregroundStyle(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 5))
    }
}
