//
//  SecondViewController.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import UIKit
import ViewModel
import IQKeyboardManagerSwift

class LoginViewController: ViewController<LoginViewModel, ApplicationCoordinator>, StoryboardInstantiable {
    
    @IBOutlet weak var submitButton: MedLoadingButton!
    @IBOutlet weak var forgotPassButton: MedLoadingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.config(withButtonStyle: .filledActive)
        forgotPassButton.config(withButtonStyle: .empty)
    }

    override func bindViewModel(viewModel: LoginViewModel) {
        super.bindViewModel(viewModel: viewModel)
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        coordinator.back()
    }
}
