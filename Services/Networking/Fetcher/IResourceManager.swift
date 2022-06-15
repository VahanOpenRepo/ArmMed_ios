//
//  IResourceManager.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift

protocol IResourceManager {
    func fetchedObject<T: Decodable>(for resource: IResource) -> Single<T>
}
