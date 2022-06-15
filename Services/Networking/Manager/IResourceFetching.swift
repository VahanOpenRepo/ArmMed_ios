//
//  IResourceFetching.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift

protocol IResourceFetching {
    func fetch(resource: IResource) -> Single<Data>
}
