//
//  ITheme.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import UIKit

public protocol ITheme: AnyObject {
    static var current: ITheme { get }
    var isBlurred: Bool { get set }
    var isDark: Bool { get set }
    var colors: IColors { get set }
    var fonts: IFonts { get set }
}

public protocol IColors {
    var seasonButtonBackground: UIColor { get }
    var itemTint: UIColor { get }
    var mainColor: UIColor { get }
    
}

public protocol IFonts {
    var primary: UIFont { get }
    var secondary: UIFont { get }
    var secondaryBold: UIFont { get }
    
}

public protocol MTheme {
    static var current: MTheme { get }
    var colors: MColors { get set }
    var fonts: MFonts { get set }
}

public protocol MColors {
    var medBlue: UIColor { get }
    var gradientButtonStart: UIColor { get }
    var gradientButtonEnd: UIColor { get }
}

public protocol MFonts {
    var medMedium: UIFont { get }
    var medTitle: UIFont { get }
    var medSubTitle: UIFont { get }
    var medSubTitleBold: UIFont { get }
}
