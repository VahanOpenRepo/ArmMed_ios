//
//  ConnectionViewController.swift
//  MedUp
//
//  Created by Vahe Makaryan on 25.11.21.
//

import UIKit
import ViewModel
import IQKeyboardManagerSwift

class ConnectionViewController: ViewController<ConnectionViewModel, ConnectionCoordinator> {

    @IBOutlet weak var reloadButton: MedLoadingButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad()
        reloadButton.gradient()
    }

    override func bindViewModel(viewModel: ConnectionViewModel) {
        super.bindViewModel(viewModel: viewModel)
    }

    @IBAction private func reloadButtonAction() {}

    deinit {
        print("ConnectionViewController deinit")
    }
}
