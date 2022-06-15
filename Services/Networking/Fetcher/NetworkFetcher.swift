//
//  NetworkFetcher.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift

public class NetworkFetcher: IResourceFetching {

    private func constructUrlComponent(resource: IResource, urlString: String) -> URLComponents? {
        var urlComponents = URLComponents(string: urlString)
        var queryItems = [URLQueryItem]()
        for (key, value) in resource.parameters {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        urlComponents?.queryItems = queryItems

        return urlComponents
    }

    private func createRequest(resource: IResource) -> URLRequest {
        let urlString = "\(resource.baseUrl)\(resource.path)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)

        if resource.method.rawValue == ResourceMethod.get.rawValue {
            let urlComponents = constructUrlComponent(resource: resource, urlString: urlString)
            request = URLRequest(url: (urlComponents?.url)!)
        } else {
            let params = resource.parameters
            if resource.headers["Content-Type"] == "application/x-www-form-urlencoded" {
                let urlComponents = constructUrlComponent(resource: resource, urlString: urlString)
                request.httpBody = urlComponents?.percentEncodedQuery?.data(using: .utf8)

                if resource.containsContentLength {
                    let lenght = request.httpBody!.count
                    request.addValue(String(lenght), forHTTPHeaderField: "Content-Length")
                }
            } else {
                request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            }
        }
        request.httpMethod = resource.method.rawValue
        resource.headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        return request
    }

    func fetch(resource: IResource) -> Single<Data> {
        let request = createRequest(resource: resource)

        return Single.create(subscribe: { observer -> Disposable in
            let task = URLSession
                .shared
                .dataTask(with: request,
                          completionHandler: { data, urlResponse, error -> Void in
                            if let error = error {
                                let nsError = error as NSError
                                let message = nsError.userInfo["NSLocalizedDescription"]
                                    as? String ?? nsError.description
                                observer(.failure(MedUpError.networkError(code: .unknown, message: message)))
                                return
                            }

                            if let response = urlResponse as? HTTPURLResponse, response.statusCode > 299 {
                                let errorCode = ResponseCodes(rawValue: response.statusCode) ?? .unknown
                                let error = MedUpError.networkError(code: errorCode, message: errorCode.message())
                                observer(.failure(error))
                                return
                            }
                            guard let data = data else {
                                observer(.failure(MedUpError.noData))

                                return
                            }
                            observer(.success(data))
                          })
            task.resume()

            return Disposables.create()
        })
    }
}
