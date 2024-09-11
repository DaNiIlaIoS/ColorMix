//
//  ColorMixApp.swift
//  ColorMix
//
//  Created by Даниил Сивожелезов on 08.09.2024.
//

import SwiftUI

@main
struct ColorMixApp: App {
    @State var languageSettings = LanguageSetting()
    
    var body: some Scene {
        WindowGroup {
            ColorMixView()
//                .environment(languageSettings)
//                .environment(\.locale, languageSettings.locale)
        }
    }
}
