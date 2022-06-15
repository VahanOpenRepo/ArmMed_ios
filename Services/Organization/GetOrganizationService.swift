//
//  GetOrganizationService.swift
//  Services
//
//  Created by Vahan Grigoryan on 5/1/22.
//

import Foundation
import RxSwift

public final class GetOrganizationService: GetOrganizationServisable {

    let manager: IResourceManager = ResourceManager()

    public init() {}

    public func fetch(params: GetOrganizationParameter) -> Single<Response<GetOrganizationResponse>> {
        return manager.fetchedObject(for: params)
    }
    
}
