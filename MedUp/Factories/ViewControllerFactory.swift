//
//  ViewControllerFactory.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import ViewModel
import Services

final class ViewControllerFactory {
    static func makeFirstViewController(viewModel: FirstNavigationModel) ->
    FirstViewController {
        let viewController = FirstViewController.instantiate()
        let firstService = FirstServiceInputServices()
        viewController.viewModel = FirstViewModel(services: firstService,
                                                  firstNavigationModel: viewModel)
        return viewController
    }

    static func makeSecondViewController(viewModel: LoginNavigationModel) ->
    LoginViewController {
        let viewController = LoginViewController.instantiate()
        viewController.viewModel = LoginViewModel(loginNavigationModel: viewModel)
        return viewController
    }
    
    static func makeScanQRViewController(viewModel: ScanQRNavigationModel) ->
    ScanQRViewController {
        let viewController = ScanQRViewController.instantiate()
        let scanQRService = ScanQRServiceInputServices()
        viewController.viewModel = ScanQRViewModel(services: scanQRService,
                                                   firstNavigationModel: viewModel)
        return viewController
    }
    
    static func makeProfileViewController(viewModel: ProfileNavigationModel) ->
    ProfileViewController {
        let viewController = ProfileViewController.instantiate()
        let profileService = ProfileInputServices()
        viewController.viewModel = ProfileViewModel(services: profileService,
                                                    profileNavigationModel: viewModel)
        return viewController
    }

    static func makePatientsListViewController(viewModel: PatientListNavigationModel) ->
    PatientsListViewController {
        let viewController = PatientsListViewController()
        let profileService = PatientsListInputServices()
        viewController.viewModel = PatientsListViewModel(services: profileService, navigationModel: viewModel)
        return viewController
    }

    static func makeQuestionsViewController(viewModel: QuestionNavigationModel) ->
    QuestionViewController {
        let viewController = QuestionViewController()
        let questionService = QuestionInputServices()
        viewController.viewModel = QuestionViewModel(services: questionService, questionNavModel: viewModel)
        return viewController
    }

    static func makePatientDetailsViewController(viewModel: PatientNavigationModel) ->
    PatientDetailsViewController {
        let viewController = PatientDetailsViewController()
        let patientService = PatientDetailsInputServices()
        viewController.viewModel = PatientDetailsViewModel(services: patientService, patientNavModel: viewModel)
        return viewController
    }
    
    static func makeAddVisitViewController(navModel: AddVisitNavigationModel) ->
    AddVisitViewController {
        let viewController = AddVisitViewController()
        let patientService = AddVisitInputServices()
        viewController.viewModel = AddVisitViewModel(services: patientService, navigationModel: navModel)
        return viewController
    }

    static func makeFilterViewController() -> FilterViewController {
        let viewController = FilterViewController()
        let patientService = FilterInputServices()
        viewController.viewModel = FilterViewModel(services: patientService)
        return viewController
    }

    static func makeFilterDetailsViewController(viewModel: FilterDetailsNavigationModel) ->
    FilterDetailsViewController {
        let viewController = FilterDetailsViewController()
        let patientService = FilterDetailsInputServices()
        viewController.viewModel = FilterDetailsViewModel(services: patientService, filterDetailsNavModel: viewModel)

        return viewController
    }
}
