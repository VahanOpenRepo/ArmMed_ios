//
//  DeviceInfo.swift
//  Shared
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import UIKit

public struct DeviceInfo {
    public static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }

    public static var isLandscape: Bool {
        UIDevice.current.orientation.isLandscape
    }
}
