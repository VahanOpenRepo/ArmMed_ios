//
//  FilterViewModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 17.11.21.
//

import Foundation
import Services
import RxSwift
import RxRelay
import Shared

public class FilterInputServices: CommonServices {

    let patientListService: PatientListService = Services.get()

    public init() {}
}

public typealias MFilterViewModel = ViewModel<FilterInputServices>

public class FilterViewModel: MFilterViewModel {

    public let filters = PublishSubject<[FilterCellModel]>()

    private let dataSource = [FilterCellModel(title: "Անուն Ազգանունի"),
                      FilterCellModel(title: "Անուն Ազգանունի և Ծննդյան տարեթվի"),
                      FilterCellModel(title: "Սոց քարտի")]
    
    public override init(services: FilterInputServices) {
        super.init(services: services)
    }

    public override func viewDidLoad() {

        filters.onNext(dataSource)
    }

    public func getNavigationModel(cellItem: FilterCellModel) -> FilterDetailsNavigationModel {
        let filterDetailsType = FilterDetailsType.type(by: cellItem.title)
        let navigationModel = FilterDetailsNavigationModel(filterDetailsType: filterDetailsType)

        return navigationModel
    }

}
