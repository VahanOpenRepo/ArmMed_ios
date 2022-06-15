//
//  GetOrganizationServisable.swift
//  Services
//
//  Created by Vahan Grigoryan on 5/1/22.
//

import Foundation
import RxSwift

public protocol GetOrganizationServisable {
    func fetch(params: GetOrganizationParameter) -> Single<Response<GetOrganizationResponse>>
}
