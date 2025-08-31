//
//  Fonts.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 30/08/2025.
//

import Foundation
import CoreText

class FontsManger {
    
    static let shared = FontsManger()
    private init() {}
    
    func registerFonts() {
        // Register Gotham fonts
        let fonts = [
            "Gotham-Black",
            "Gotham-Bold",
            "Gotham-BookItalic",
            "Gotham-Light",
            "Gotham-Thin",
            "GothamMedium",
            "GothamRounded-Bold",
            "GothamRoundedBook_21018",
            "GothamRoundedLight_21020"
        ]
        
        for font in fonts {
            if let fontURL = Bundle.main.url(forResource: font, withExtension: "otf") ??
                Bundle.main.url(forResource: font, withExtension: "ttf") {
                CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, nil)
            }
        }
    }
}
