//
//  Themed.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import UIKit

protocol Themed {
    var colors: MColors { get }
    var fonts: MFonts { get }
}

extension Themed {
    var colors: MColors { return ThemeManager.current.colors }
    var fonts: MFonts { return ThemeManager.current.fonts }
}

extension UIView: Themed {}

extension UIViewController: Themed {}
