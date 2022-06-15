//
//  ScanQRService.swift
//  Services
//
//  Created by Vahan Grigoryan on 7/18/21.
//

import Foundation
import RxSwift

public protocol ScanQRServicable {
    func fetch(params: ScanQRParameter) -> Single<LoginResponse>
}
