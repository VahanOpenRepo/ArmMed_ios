//
//  QuestionService.swift
//  Services
//
//  Created by Vahe Makaryan on 13.10.21.
//

import Foundation
import RxSwift

public final class QuestionService: QuestionServiceable {

    let manager: IResourceManager = ResourceManager()

    public init() {}

    public func fetch(params: QuestionParameter) -> Single<Response<QuestionResult>> {
        return manager.fetchedObject(for: params)
    }
}
