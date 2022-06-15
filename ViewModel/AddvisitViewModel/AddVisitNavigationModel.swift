//
//  AddVisitNavigationModel.swift
//  ViewModel
//
//  Created by Vahan Grigoryan on 4/10/22.
//

import Foundation
import Services

public struct AddVisitNavigationModel {
    public let myInformation: [Mi]?
    public init(myInformation: [Mi]?) {
        self.myInformation = myInformation
    }
}
