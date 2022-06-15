//
//  BaseTheme.swift
//  MedUp
//
//  Created by Vahan Grigoryan on 6/15/21.
//

import UIKit

final class BaseTheme: MTheme {
    static var current: MTheme = BaseTheme()

    var colors: MColors = BasicColors()
    var fonts: MFonts = BasicFonts()

    private init() {

    }
}
