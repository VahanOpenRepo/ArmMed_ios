//
//  AddVisitServicable.swift
//  Services
//
//  Created by Vahan Grigoryan on 5/1/22.
//

import Foundation
import RxSwift

public protocol AddVisitServicable {
    func fetch(params: AddVisitParameter) -> Single<Response<AddVisitResult>>
}
