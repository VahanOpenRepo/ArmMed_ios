//
//  ProfileCoordinator.swift
//  MedUp
//
//  Created by Vahe Makaryan on 23.11.21.
//


import Foundation
import UIKit
import ViewModel
import Services

final class ProfileCoordinator: Coordinator {

    private let rootViewController: UINavigationController

    public var user: User!

    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    func back() {
        rootViewController.popViewController(animated: true)
    }

    func backToRoot() {
        rootViewController.popToRootViewController(animated: true)
    }

    func start() {

        let profileVC = ViewControllerFactory.makeProfileViewController(viewModel: ProfileNavigationModel(user: user))
        profileVC.coordinator = self
        rootViewController.pushViewController(profileVC, animated: false)
    }

    func logout() {
        let applicationStartController = ApplicationStartController()

        UIWindow.key?.rootViewController?.removeFromParent()
        UIWindow.key?.rootViewController = nil
        UIWindow.key?.rootViewController = applicationStartController
    }
}

