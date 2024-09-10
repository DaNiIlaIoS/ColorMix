//
//  ColorModel.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 10.09.2024.
//

import SwiftUI

struct ModelColor: Decodable {
    let name: Name
}

struct Name: Decodable {
    let value: String
}

struct CustomColor: Identifiable {
    let id = UUID()
    let color: Color
    let name: String
}
