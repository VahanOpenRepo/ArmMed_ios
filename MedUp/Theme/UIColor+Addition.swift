//
//  UIColor+Addition.swift
//  MedUp
//
//  Created by Vahan Grigoryan on 6/5/21.
//

import UIKit

public extension UIColor {
    
    class var medBlue: UIColor {
        UIColor(red: 0.165, green: 0.557, blue: 1, alpha: 1)
    }
    
    class var gradientButtonStart: UIColor {
        UIColor(red: 0.325, green: 0.353, blue: 1, alpha: 1)
    }
    
    class var gradientButtonEnd: UIColor {
        UIColor(red: 0.047, green: 0.69, blue: 1, alpha: 1)
    }

    class var bgColor: UIColor {
        UIColor(red: 242 / 255, green: 246 / 255, blue: 254 / 255, alpha: 1)
    }

    class var tabColor: UIColor {
        UIColor(red: 7 / 255, green: 10 / 255, blue: 86 / 255, alpha: 0.5)
    }

    class var selectedTabColor: UIColor {
        UIColor(red: 7 / 255, green: 10 / 255, blue: 86 / 255, alpha: 1)
    }
}
