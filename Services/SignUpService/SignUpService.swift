//
//  SignUpFoundation.swift
//  Services
//
//  Created by Vahan Grigoryan on 6/15/21.
//

import Foundation
import RxSwift

public final class SignUpService: MSignUpService {
    let manager: IResourceManager = ResourceManager()

    public init() {}

    public func fetch(params: SignUpParameter) -> Single<SignUpModel> {
        return manager.fetchedObject(for: params)
    }
}
