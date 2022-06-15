//
//  LightTheme.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import UIKit

final class LightTheme: ITheme {
    var isBlurred: Bool = true
    var isDark: Bool = false
    static var current: ITheme = LightTheme()

    var colors: IColors = LightColors()
    var fonts: IFonts = DefaultFont()

    private init() {

    }
}
