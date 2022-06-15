//
//  PatientListServicable.swift
//  Services
//
//  Created by Vahe Makaryan on 05.10.21.
//

import Foundation
import RxSwift

public protocol PatientListServicable {
    func fetch(params: PatientListParameter) -> Single<Response<PatientListResult>>
}
