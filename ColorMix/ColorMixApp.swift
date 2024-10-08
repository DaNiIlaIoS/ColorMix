//
//  ColorMixApp.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 08.09.2024.
//

import SwiftUI

@main
struct ColorMixApp: App {
    @State private var languageManager = LanguageManager()
    
    var body: some Scene {
        WindowGroup {
            ColorMixView()
                .environment(languageManager) /// Управление языком приложения
                .environment(\.locale, .init(identifier: languageManager.currentLanguage))
        }
    }
}
