//
//  FirstParameter.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation

public struct FirstParameter: IResource {
    let cityName: String
    let method = ResourceMethod.get

    public init(cityName: String) {
        self.cityName = cityName
    }

    var parameters: [String: AnyHashable] {
        return [Environment.Keys.units.rawValue: Environment.Keys.metric.rawValue,
                Environment.Keys.appid.rawValue: Environment.Keys.token.rawValue,
                Environment.Keys.cityParam.rawValue: cityName]
    }
}
