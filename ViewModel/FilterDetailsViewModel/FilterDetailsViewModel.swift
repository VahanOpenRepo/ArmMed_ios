//
//  FilterDetailsViewModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 18.11.21.
//


import Foundation
import Services
import RxSwift
import RxRelay
import Shared

public class FilterDetailsInputServices: CommonServices {

    public init() {}
}

public typealias MFilterDetailsViewModel = ViewModel<FilterDetailsInputServices>

public class FilterDetailsViewModel: MFilterDetailsViewModel {

    private let filterDetailsNavModel: FilterDetailsNavigationModel

    public let filterFields = PublishSubject<[FilterDetailsCellModel]>()

    public let filterRequesModel = PublishSubject<PatientFilterRequestModel>()

    private let nameSurnameFields = [FilterDetailsCellModel(cellType: .name),
                                     FilterDetailsCellModel(cellType: .surename)]

    private let nameSurnameBirthdateFields = [FilterDetailsCellModel(cellType: .name),
                                              FilterDetailsCellModel(cellType: .surename),
                                              FilterDetailsCellModel(cellType: .birthdate)]

    private let patientSSNFields = [FilterDetailsCellModel(cellType: .patientSSN)]

    private var dataSource = [FilterDetailsCellModel]()

    public init(services: FilterDetailsInputServices, filterDetailsNavModel: FilterDetailsNavigationModel) {
        self.filterDetailsNavModel = filterDetailsNavModel
        super.init(services: services)
    }

    public override func viewDidLoad() {

        switch filterDetailsNavModel.filterDetailsType {
        case .nameSurname: dataSource = nameSurnameFields
        case .nameSurnameBirthdate: dataSource = nameSurnameBirthdateFields
        case .patientSSN: dataSource = patientSSNFields
        default: return
        }

        filterFields.onNext(dataSource)
    }

    public func searchButtonPressed() {

        if isValid(with: dataSource) {
            filterRequesModel.onNext(getFilterRequesModel())
        } else {
            let error = MedUpError.internalError("Sorry  All Needed Fields are not fully filled")
            handleServiceError(error: error, showAlert: true)
        }
    }

    private func isValid(with source: [FilterDetailsCellModel]) -> Bool {
        var isValid = true

        source.forEach { model in
            switch model.cellType {
            case .name, .surename:
                if model.value?.count ?? 0 < 5 {
                    isValid = false
                }
            case .birthdate:
                if model.value == nil {
                    isValid = false
                }
            case .patientSSN:
                if model.value?.count ?? 0 < 5 {
                    isValid = false
                }
            }
        }
        return isValid
    }


    private func getFilterRequesModel() -> PatientFilterRequestModel {

        var requestModel = PatientFilterRequestModel()

        dataSource.forEach { model in
            switch model.cellType {
            case .name: requestModel.patient_name = model.value
            case .surename: requestModel.patient_last_name = model.value
            case .birthdate: requestModel.date_of_birth = model.value
            case .patientSSN: requestModel.patient_ssn = model.value
            }
        }
        return requestModel
    }
}
