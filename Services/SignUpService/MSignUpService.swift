//
//  SignUpService.swift
//  Services
//
//  Created by Vahan Grigoryan on 6/15/21.
//

import Foundation
import RxSwift

public protocol MSignUpService {
    func fetch(params: SignUpParameter) -> Single<SignUpModel>
}
