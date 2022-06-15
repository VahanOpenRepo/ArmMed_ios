//
//  AddVisitCoordinator.swift
//  MedUp
//
//  Created by Vahan Grigoryan on 4/10/22.
//

import UIKit
import ViewModel
import Services

final class AddVisitCoordinator: Coordinator {

    var rootViewController: UINavigationController?
    
    private var addVisitVC: AddVisitViewController?
    var myInformation: [Mi]?
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(statusManager),
                                               name: .flagsChanged,
                                               object: nil)
    }

    func start() {

        addVisitVC = ViewControllerFactory.makeAddVisitViewController(navModel: AddVisitNavigationModel(myInformation: myInformation))
        addVisitVC?.coordinator = self
        addVisitVC?.modalPresentationStyle = .overFullScreen

        rootViewController?.pushViewController(addVisitVC!, animated: false)
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
        rootViewController?.popViewController(animated: true)
    }

    func backToRoot() {}

    deinit {
        print("ConnectionCoordinator deinit")
        NotificationCenter.default.removeObserver(self)
    }
}

