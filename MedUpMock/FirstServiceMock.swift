//
//  FirstServiceMock.swift
//  MedUpMock
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift
@testable import Services

public final class FirstServiceMock: IFirstService, IMockedService {
    public typealias Param = FirstParameter

    public init() {}

    public var paramCheck: ((Param) -> Void)?
    public var valueToReturn: WeatherResponse?
    public var throwError: Bool = false

    public func fetch(params: FirstParameter) -> Single<WeatherResponse> {
        returnData(param: params)
    }
}
