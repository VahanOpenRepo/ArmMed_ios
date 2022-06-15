//
//  SecondViewModel.swift
//  ViewModel
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import Services
import RxSwift
import RxRelay
import Shared

public class LoginServiceInputServices: CommonServices {
    public init() {}
}

public class LoginViewModel: ViewModel<LoginServiceInputServices>, IUnitFormatter {

    public init(services: LoginServiceInputServices = LoginServiceInputServices(),
                loginNavigationModel: LoginNavigationModel) {
        super.init(services: services)
    }
}
