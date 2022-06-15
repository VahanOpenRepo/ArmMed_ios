//
//  UIWindow+Extension.swift
//  MedUp
//
//  Created by Vahe Makaryan on 05.10.21.
//

import UIKit

public extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
