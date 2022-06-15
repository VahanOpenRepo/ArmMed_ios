//
//  ApplicationCoordinator.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import UIKit
import ViewModel
import Services

final class ApplicationCoordinator: BaseCoordinator<UINavigationController> {

    private lazy var tabbarCoordinator = TabBarCoordinator()

    override func start() {
        let firstViewController = ViewControllerFactory
            .makeFirstViewController(viewModel: FirstNavigationModel())
        firstViewController.coordinator = self
        rootViewController.pushViewController(firstViewController, animated: false)
    }

    func showSecondViewController(with data: LoginNavigationModel) {
        let secondViewController = ViewControllerFactory
            .makeSecondViewController(viewModel: data)
        secondViewController.coordinator = self
        rootViewController.pushViewController(secondViewController, animated: true)
    }
    
    func showScanQRViewController(with data: ScanQRNavigationModel) {
        let scanQRViewController = ViewControllerFactory
            .makeScanQRViewController(viewModel: data)
        scanQRViewController.coordinator = self
        rootViewController.pushViewController(scanQRViewController, animated: true)
    }
    
    func showTabBar(user: User) {
        tabbarCoordinator.user = user
        tabbarCoordinator.start()
    }
}
