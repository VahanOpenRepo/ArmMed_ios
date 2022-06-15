//
//  ResourceManager.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift

final public class ResourceManager: IResourceManager {
    var parser: IParser = CodableParser()
    var fetcher: IResourceFetching = NetworkFetcher()

    func fetchedObject<T: Decodable>(for resource: IResource) -> Single<T> {
        let response = fetcher.fetch(resource: resource)
        let parsed: Single<T> = response.flatMap(parser.parse)

        return parsed
    }
}
