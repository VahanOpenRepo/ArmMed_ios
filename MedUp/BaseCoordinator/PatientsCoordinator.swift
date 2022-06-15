//
//  PatientsCoordinator.swift
//  MedUp
//
//  Created by Vahe Makaryan on 23.11.21.
//

import Foundation
import UIKit
import ViewModel
import Services

final class PatientsCoordinator: Coordinator {

    private let rootViewController: UINavigationController

    private lazy var filterCoordinator = FilterCoordinator(rootViewController: rootViewController)
    
    private lazy var addVizitCoordinator = AddVisitCoordinator(rootViewController: rootViewController)

    private var patientsListVC: PatientsListViewController!

    private var patientDetailsVC: PatientDetailsViewController!

    private var questionVC: QuestionViewController!

    public var user: User!

    public var searchResult: ((PatientFilterRequestModel) -> Void)?

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
        guard let token = user.token else { return }
        patientsListVC = ViewControllerFactory.makePatientsListViewController(viewModel: PatientListNavigationModel(token: token))
        rootViewController.pushViewController(patientsListVC, animated: false)
        patientsListVC.coordinator = self
    }

    func showPatientDetails(with data: PatientNavigationModel) {
        let patientDetailsVC = ViewControllerFactory
            .makePatientDetailsViewController(viewModel: data)
        rootViewController.pushViewController(patientDetailsVC, animated: true)
        patientDetailsVC.coordinator = self
    }

    func showQuestion(with data: QuestionNavigationModel) {
        questionVC = ViewControllerFactory.makeQuestionsViewController(viewModel: data)
        rootViewController.pushViewController(questionVC, animated: true)
        questionVC.coordinator = self
    }

    func showPatientFilter(filterRequestModel: @escaping (PatientFilterRequestModel?) -> Void) {

        filterCoordinator.start()
        filterCoordinator.searchResult = { requestModel in
            filterRequestModel(requestModel)
        }
    }
    
    func showAddVisit(myInformation: [Mi]?) {
        addVizitCoordinator.myInformation = myInformation
        addVizitCoordinator.start()
    }
}

