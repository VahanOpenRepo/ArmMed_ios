//
//  FirstViewModel.swift
//  ViewModel
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import Services
import RxSwift
import RxRelay
import Shared

public class FirstServiceInputServices: CommonServices {
    let firstService: IFirstService = Services.get()

    public init() {}
}

public typealias IFirstViewModel = ViewModel<FirstServiceInputServices>

public class FirstViewModel: IFirstViewModel {
    
    public var dataLoaded = PublishSubject<String>()

    public init(services: FirstServiceInputServices,
                firstNavigationModel: FirstNavigationModel) {
        super.init(services: services)

    }
    
    public func getSecondNavigationModel() -> LoginNavigationModel {
        return LoginNavigationModel(id: 1233)
    }
    
    public func getScanQRNavigationModel() -> ScanQRNavigationModel {
        return ScanQRNavigationModel()
    }
    
    public func fetchData() {
        self.isLoading.accept(true)
        let params = FirstParameter(cityName: "Yeravan")
        services.firstService.fetch(params: params).subscribe(onSuccess: {[weak self] fieldsResponse in
            defer { self?.isLoading.accept(false) }
            self?.dataLoaded.onNext("Vahana")
            print("++")
            print("++")
            print("++")
            print("++")
        }, onFailure: { [unowned self] (error) in
            self.handleServiceError(error: error)
        }).disposed(by: disposeBag)
        
    }
}
