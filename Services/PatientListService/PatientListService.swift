//
//  PatientListService.swift
//  Services
//
//  Created by Vahe Makaryan on 05.10.21.
//

import Foundation
import RxSwift

public final class PatientListService: PatientListServicable {

    let manager: IResourceManager = ResourceManager()

    public init() {}

    public func fetch(params: PatientListParameter) -> Single<Response<PatientListResult>> {
        return manager.fetchedObject(for: params)
    }
}

