//
//  QuestionServiceable.swift
//  Services
//
//  Created by Vahe Makaryan on 13.10.21.
//

import Foundation
import RxSwift

public protocol QuestionServiceable {
    func fetch(params: QuestionParameter) -> Single<Response<QuestionResult>>
}
