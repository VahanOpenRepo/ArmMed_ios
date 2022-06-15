//
//  Resource.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation

protocol IResource {
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var headers: [String: String] { get }
    var containsContentLength: Bool { get }
    var method: ResourceMethod { get }
    var contentType: String { get }
    var body: [String: String] { get }
}

extension IResource {
    var baseUrl: String { return Environment.current.path }
    var path: String { return "" }
    var parameters: [String: Any] { return [:] }
    var headers: [String: String] {
        var header = ["Content-Type": contentType]
        header["Accept"] = "application/json"
        return header
    }

    var containsContentLength: Bool {
        return false
    }
    var method: ResourceMethod { return .get }
    var contentType: String { return "application/json" }
    var body: [String: String] { return [:] }
}

public enum ResourceMethod: String {
    case get = "GET"
    case post = "POST"
    case update = "UPDATE"
}

