//
//  ScanQRViewModel.swift
//  ViewModel
//
//  Created by Vahan Grigoryan on 7/18/21.
//

import Foundation
import Services
import RxSwift
import RxRelay
import Shared

public class ScanQRServiceInputServices: CommonServices {
    let scanQRService: ScanQRService = Services.get()

    public init() {}
}

public typealias MScanQRViewModel = ViewModel<ScanQRServiceInputServices>

public class ScanQRViewModel: MScanQRViewModel {
    
    private var user: User?
    public var tokenRecived = PublishSubject<Bool>()

    public init(services: ScanQRServiceInputServices,
                firstNavigationModel: ScanQRNavigationModel) {
        super.init(services: services)
        
    }
    
    public func getProfileNavigationModel() -> ProfileNavigationModel {
        return ProfileNavigationModel(user: user)
    }
    
    public func fetchData(loginString: String) {
        self.isLoading.accept(true)
        let params = ScanQRParameter(login: loginString)
        services.scanQRService.fetch(params: params).subscribe(onSuccess: { [weak self] fieldsResponse in
            guard let self = self else { return }
            defer { self.isLoading.accept(false) }

            if let user = fieldsResponse.result?.transformToUser(), user.token != nil {
                self.user = user
                self.tokenRecived.onNext(true)
            } else {
                self.handleServiceError(error: MedUpError.networkError(code: ResponseCodes.unauthorized, message: "Sorry Authorization Failed"))
            }
        }, onFailure: { [weak self] error in
            guard let self = self else { return }
            self.handleServiceError(error: error)
        }).disposed(by: disposeBag)
    }
}
