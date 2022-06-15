//
//  IFirstService.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift

public protocol IFirstService {
    func fetch(params: FirstParameter) -> Single<WeatherResponse>
}
