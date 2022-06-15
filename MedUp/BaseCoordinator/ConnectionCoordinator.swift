//
//  ConnectionCoordinator.swift
//  MedUp
//
//  Created by Vahe Makaryan on 25.11.21.
//

import UIKit
import ViewModel

final class ConnectionCoordinator: Coordinator {

    var rootViewController: UIViewController? {
        UIWindow.key?.rootViewController
    }

    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(statusManager),
                                               name: .flagsChanged,
                                               object: nil)
    }

    func start() {

        let connectionVC = ConnectionViewController()
        connectionVC.viewModel = ConnectionViewModel(services: ConnectionInputServices())
        connectionVC.modalPresentationStyle = .overFullScreen

        rootViewController?.present(connectionVC, animated: false, completion: nil)
    }

    @objc func statusManager(_ notification: Notification) {
        updateUserInterface()
    }

    func updateUserInterface() {

        switch Network.reachability.status {
        case .unreachable:
            start()
        default:
            back()
        }
        print("Reachability Summary")
        print("Status:", Network.reachability.status)
        print("HostName:", Network.reachability.hostname ?? "nil")
        print("Reachable:", Network.reachability.isReachable)
        print("Wifi:", Network.reachability.isReachableViaWiFi)
    }

    func back() {
        rootViewController?.dismiss(animated: false, completion: nil)
    }

    func backToRoot() {}

    deinit {
        print("ConnectionCoordinator deinit")
        NotificationCenter.default.removeObserver(self)
    }
}

