//
//  AddVisitService.swift
//  Services
//
//  Created by Vahan Grigoryan on 5/1/22.
//

import Foundation
import RxSwift

public final class AddVisitService: AddVisitServicable {

    let manager: IResourceManager = ResourceManager()

    public init() {}

    public func fetch(params: AddVisitParameter) -> Single<Response<AddVisitResult>> {
        return manager.fetchedObject(for: params)
    }
    
}
