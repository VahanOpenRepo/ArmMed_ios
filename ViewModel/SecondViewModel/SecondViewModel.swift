//
//  SecondViewModel.swift
//  ViewModel
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import Services
import Shared

public class SecondServiceInputServices: CommonServices {
    public init() {}
}

public class SecondViewModel: ViewModel<SecondServiceInputServices>, IUnitFormatter {

    public init(services: SecondServiceInputServices = SecondServiceInputServices(),
                secondNavigationModel: SecondNavigationModel) {
        super.init(services: services)
    }
}
