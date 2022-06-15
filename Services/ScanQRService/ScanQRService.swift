//
//  ScanQRService.swift
//  Services
//
//  Created by Vahan Grigoryan on 7/18/21.
//

import Foundation
import RxSwift

public final class ScanQRService: ScanQRServicable {
    let manager: IResourceManager = ResourceManager()

    public init() {}

    public func fetch(params: ScanQRParameter) -> Single<LoginResponse> {
        return manager.fetchedObject(for: params)
    }
}
