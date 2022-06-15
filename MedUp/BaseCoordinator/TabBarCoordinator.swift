//
//  TabBarCoordinator.swift
//  MedUp
//
//  Created by Vahe Makaryan on 28.09.21.
//

import Foundation
import UIKit
import ViewModel
import Services

final class TabBarCoordinator: Coordinator {

    let patientsNavCont = TabbarControllerItem.patients.viewController
    var patientsCoordinator: PatientsCoordinator!

    let profileNavCont = TabbarControllerItem.profile.viewController
    lazy var profileCoordinator = ProfileCoordinator(rootViewController: profileNavCont)

    private var connectionCoordinator: ConnectionCoordinator!

    private lazy var barItems = [
        TabBarItem(controller: patientsNavCont),
        TabBarItem(controller: profileNavCont)
    ]

    public var user: User!

    func start() {
        patientsNavCont.tabBarItem = TabbarControllerItem.patients.tabBarItem
        patientsCoordinator = PatientsCoordinator(rootViewController: patientsNavCont)
        patientsCoordinator.user = user
        patientsCoordinator.start()

        profileNavCont.tabBarItem = TabbarControllerItem.profile.tabBarItem
        profileCoordinator.user = user
        profileCoordinator.start()

        let tabBarController = MainTabBarViewController(with: self, barItems: barItems, selectedItem: .patients)
        UIWindow.key?.rootViewController = tabBarController

        connectionCoordinator = ConnectionCoordinator()
    }

    func back() {}

    func backToRoot() {}

    deinit {
        print("Tabbar Coordinator deinit")
    }
}
