//
//  FirstViewController.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import UIKit
import ViewModel
import Shared

final class FirstViewController: ViewController<FirstViewModel, ApplicationCoordinator>, StoryboardInstantiable, IUnitFormatter {

    @IBOutlet weak private var scanButton: MedLoadingButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        scanButton.config(withButtonStyle: .white, title: "ՍԿԱՆԱՎՈՐԵԼ")
        self.view.gradient(startColor: UIColor.gradientButtonStart, endColor: UIColor.gradientButtonEnd, gradientFillType: .vertical)
    }

    override func bindViewModel(viewModel: FirstViewModel) {
        super.bindViewModel(viewModel: viewModel)
        
        viewModel.dataLoaded.subscribe(onNext: { data in
            print(data)
          }).disposed(by: disposeBag)
    }
    
    @IBAction func showSecondScreen(_ sender: UIButton) {
        showNextPage()
    }
    
    private func showNextPage() {
        let model = viewModel.getScanQRNavigationModel()
        coordinator.showScanQRViewController(with: model)
    }

    deinit {
        print("Deinit FirstVC")
    }
}
