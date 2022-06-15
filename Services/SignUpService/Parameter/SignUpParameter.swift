//
//  SionUpParameter.swift
//  Services
//
//  Created by Vahan Grigoryan on 6/15/21.
//

import Foundation

public struct SignUpParameter: IResource {
    let method = ResourceMethod.get


    var parameters: [String: AnyHashable] {
        return [Environment.Keys.units.rawValue: Environment.Keys.metric.rawValue,
                Environment.Keys.appid.rawValue: Environment.Keys.token.rawValue]
    }
}
