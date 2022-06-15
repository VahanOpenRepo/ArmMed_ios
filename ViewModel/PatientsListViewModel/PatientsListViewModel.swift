//
//  PatientsListViewModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 25.09.21.
//

import Foundation
import Services
import RxSwift
import RxRelay
import Shared

public class PatientsListInputServices: CommonServices {

    let patientListService: PatientListService = Services.get()

    public init() {}
}

public typealias MPatientsListViewModel = ViewModel<PatientsListInputServices>

public class PatientsListViewModel: MPatientsListViewModel {

    public var patients = PublishSubject<[PatientCellModel]>()

    public var filterRequestModel: PatientFilterRequestModel? {
        didSet {
            loadViewData()
        }
    }

    private let navigationModel: PatientListNavigationModel
    
    private var isUpToDate = false
    private var from = 0
    private let count = 20
    private var localDataSource = [PatientResponse]()
    public var myInformation: [Mi]?

    public init(services: PatientsListInputServices, navigationModel: PatientListNavigationModel) {
        self.navigationModel = navigationModel
        super.init(services: services)
    }

    public override func viewDidLoad() {
        loadViewData()
    }

    private func loadViewData() {
        reset()
        getData(from: from, count: count, first: 1, mustReset: true)
    }

    func reset() {
        from = 0
        isUpToDate = false
    }

    public func getData(from: Int, count: Int, first: Int, mustReset: Bool) {

        let params = PatientListParameter(from: "\(from)",
                                          count: "\(count)",
                                          direction: "-1",
                                          first: "\(first)",
                                          token: navigationModel.token,
                                          filter: filterRequestModel)

        isLoading.accept(true)
        services.patientListService.fetch(params: params).subscribe(onSuccess: { [weak self] response in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.processResponse(response: response.result?.patients ?? [], count: count, mustReset: mustReset)
            self.myInformation = response.result?.mi
        }, onFailure: { [weak self] error in
            guard let self = self else { return }
            self.handleServiceError(error: error)
        }).disposed(by: disposeBag)
    }

    public func loadMoreItems() {
        guard !isUpToDate else {

            DispatchQueue.global(qos: .utility).async {
                sleep(1)
                DispatchQueue.main.async {
                    print("animation finished")
                }
            }
            return
        }

        from += count
        getData(from: from, count: count, first: 0, mustReset: false)
    }

    public func processResponse(response: [PatientResponse], count: Int , mustReset: Bool) {

        if count > response.count {
            self.isUpToDate = true
        }

        if mustReset {
            self.localDataSource = []
        }

        if self.localDataSource.count == 0 {
            self.localDataSource = response
        } else {
            self.localDataSource.append(contentsOf: response)
        }

        let dataSource = self.convertResponse(elements: localDataSource)
        patients.onNext(dataSource)
    }

    public func convertResponse(elements: [PatientResponse]) -> [PatientCellModel] {

        let dataSource = elements.map { patientResponse in
            PatientCellModel(id: patientResponse.id,
                             imageURLString: patientResponse.picture,
                             name: patientResponse.patientName,
                             lastName: patientResponse.patientLastName,
                             birthdate: patientResponse.dateOfBirth,
                             visitMode: patientResponse.visitMode,
                             visitStart: patientResponse.visitStart,
                             visitEnd: patientResponse.visitEnd)
        }

        return dataSource
    }

    public func getNavigationModel(cellItem: PatientCellModel) -> PatientNavigationModel? {

        guard let patient = localDataSource.filter({ $0.id == cellItem.id}).first else { return nil }

        return PatientNavigationModel(patientResponse: patient)
    }
}
