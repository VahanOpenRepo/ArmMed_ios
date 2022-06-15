//
//  Foundation.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift

public final class FirstService: IFirstService {
    let manager: IResourceManager = ResourceManager()

    public init() {}

    public func fetch(params: FirstParameter) -> Single<WeatherResponse> {
        return manager.fetchedObject(for: params)
    }
}
