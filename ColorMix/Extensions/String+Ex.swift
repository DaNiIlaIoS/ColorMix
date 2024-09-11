//
//  String+Ex.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 11.09.2024.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
