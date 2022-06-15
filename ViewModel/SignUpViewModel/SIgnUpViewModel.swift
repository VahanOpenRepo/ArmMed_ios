//
//  SIgnUpViewModel.swift
//  ViewModel
//
//  Created by Vahan Grigoryan on 6/15/21.
//

import Foundation
import Services
import RxSwift
import RxRelay

public class SignUpServiceInputServices: CommonServices {
    let firstService: MSignUpService = Services.get()

    public init() {}
}


public typealias MSignUpViewModel = ViewModel<SignUpServiceInputServices>

public class SignUpViewModel: MSignUpViewModel {
    
    public init(services: SignUpServiceInputServices,
                firstNavigationModel: FirstNavigationModel) {
        super.init(services: services)
    }
    
    public func getSecondNavigationModel() -> LoginNavigationModel {
        return LoginNavigationModel(id: 1233)
    }
}
