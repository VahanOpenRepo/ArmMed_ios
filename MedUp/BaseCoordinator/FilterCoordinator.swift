//
//  FilterCoordinator.swift
//  MedUp
//
//  Created by Vahe Makaryan on 21.11.21.
//

import Foundation
import UIKit
import ViewModel
import Services

final class FilterCoordinator: Coordinator {

    private let filterViewController = ViewControllerFactory.makeFilterViewController()
    private lazy var filterNavController = UINavigationController(rootViewController: filterViewController)
    private let rootViewController: UIViewController

    public var searchResult: ((PatientFilterRequestModel?) -> Void)?

    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }

    func back() {
        filterNavController.popViewController(animated: true)
    }

    func backToRoot() {
        filterNavController.popToRootViewController(animated: true)
    }

    func start() {

        rootViewController.present(filterNavController, animated: true)
        filterViewController.coordinator = self
        filterNavController.isModalInPresentation = true
    }

    func showPatientFilterDetails(navigationModel: FilterDetailsNavigationModel) {

        let filterDetailsViewController = ViewControllerFactory.makeFilterDetailsViewController(viewModel: navigationModel)
        filterNavController.pushViewController(filterDetailsViewController, animated: true)
        filterDetailsViewController.coordinator = self
    }

    func closeFilter() {
        rootViewController.dismiss(animated: true, completion: nil)
    }
}
