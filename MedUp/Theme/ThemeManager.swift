//
//  ThemeManager.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import Shared

public final class ThemeManager {
    private (set) public static var current: MTheme = {
//        if DeviceInfo.isIPad {
//            return LightTheme.current
//        } else {
//            return LightThemePhone.current
//        }
        return BaseTheme.current
    }()

    class func setTheme(current: MTheme) {
        self.current = current

//        NotificationManager.post(name: .themeUpdated)
    }
}
