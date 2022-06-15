//
//  TabbarControllerItem.swift
//  MedUp
//
//  Created by Vahe Makaryan on 28.09.21.
//

import UIKit

public enum TabbarControllerItem: Int {
    
    case patients
    case profile

    var tabBarItem: UITabBarItem {
        switch self {
        case .patients:
            return UITabBarItem(title: "Հիվանդներ",
                                image: UIImage(named: "patient_tab_0"),
                                selectedImage: UIImage(named: "patient_tab_0"))
        case .profile:
            return UITabBarItem(title: "Հաշիվ",
                                image: UIImage(named: "patient_tab_2"),
                                selectedImage: UIImage(named: "patient_tab_2"))
        }
    }

    var viewController: UINavigationController {

        return UINavigationController()
    }
}
