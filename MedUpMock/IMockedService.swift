//
//  IMockedService.swift
//  MedUpMock
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift
import Services

public protocol IMockedService {
    associatedtype Response
    associatedtype Param
    var valueToReturn: Response? { get set }
    var throwError: Bool { get set }
    var errorType: MedUpError { get }
    func returnData(param: Param) -> Single<Response>
    func returnOptionalData(param: Param) -> Single<Response?>
}

public extension IMockedService {
    func returnData(param: Param) -> Single<Response> {
        guard !throwError else { return Single.error(MedUpError.internalError("Mocked error")) }
        if let val = self.valueToReturn {
            return Single.just(val)
        } else {
            return Single.error(MedUpError.noData)
        }
    }

    func returnOptionalData(param: Param) -> Single<Response?> {
        guard !throwError else { return Single.error(errorType) }
        return Single.just(valueToReturn)
    }

    var errorType: MedUpError {
        MedUpError.internalError("Mocked error")
    }
}
