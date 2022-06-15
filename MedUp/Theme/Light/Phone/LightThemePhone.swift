//
//  LightThemePhone.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation

final class LightThemePhone: ITheme {
    var isBlurred: Bool = true
    var isDark: Bool = true
    static var current: ITheme = LightThemePhone()

    var colors: IColors = LightColorsPhone()
    var fonts: IFonts = DefaultFontPhone()

    private init() {}
}
