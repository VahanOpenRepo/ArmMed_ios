//
//  ApplicationStartController.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import UIKit
import ViewModel

class ApplicationStartController: UINavigationController,
                                  StoryboardInstantiable {

    lazy var applicationCoordinator = ApplicationCoordinator(rootViewController: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        applicationCoordinator.start()
    }

    deinit {
        print("Deinit Application Start")
    }
}
