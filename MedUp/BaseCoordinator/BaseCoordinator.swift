//
//  BaseCoordinator.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import UIKit
import ViewModel

extension BaseCoordinator where T: UINavigationController {
    func back() {
        _ = rootViewController.popViewController(animated: true)
    }

    func backToRoot() {
        rootViewController.viewControllers.removeAll()
    }
}

class BaseCoordinator<T: UIViewController>: NSObject, Coordinator {
    unowned var rootViewController: T

    required init(rootViewController: T) {
        self.rootViewController = rootViewController
    }

    func start() { preconditionFailure() }
    func back() { preconditionFailure() }
    func backToRoot() { preconditionFailure() }
}
