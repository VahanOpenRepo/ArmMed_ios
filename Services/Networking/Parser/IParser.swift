//
//  IParser.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift

public protocol IParser {
    func parse<T: Decodable>(data: Data) -> Single<T>
}
