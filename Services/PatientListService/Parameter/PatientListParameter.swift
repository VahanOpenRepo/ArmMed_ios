//
//  PatientListParameter.swift
//  Services
//
//  Created by Vahe Makaryan on 05.10.21.
//

import Foundation

public struct PatientListParameter: IResource {
    let from: String
    let count: String
    let direction: String
    let first: String
    let token: String
    let filter: PatientFilterRequestModel?

    let method = ResourceMethod.post

    public init(from: String, count: String, direction: String, first: String, token: String, filter: PatientFilterRequestModel? = nil) {
        self.from = from
        self.count = count
        self.direction = direction
        self.first = first
        self.token = token
        self.filter = filter
    }

    var baseUrl: String {
        return "https://preprod.armed.am/hwmobile/getvisits"
    }

    var parameters: [String: Any] {
        var params = [Environment.Keys.from.rawValue: from,
                Environment.Keys.count.rawValue: count,
                Environment.Keys.direction.rawValue: direction,
                Environment.Keys.first.rawValue: first]

        let encoder = JSONEncoder()
        if let filter = filter,
           let jsonData = try? encoder.encode(filter),
           let jsonString = String(data: jsonData, encoding: .utf8) {

            params[Environment.Keys.filter.rawValue] = jsonString
        }

        return params
    }

    var headers: [String: String] {
        let header = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json",
                      "Authorization": "Bearer \(token)"]

        return header
    }
}
