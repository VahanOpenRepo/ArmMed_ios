//
//  GetOrganizationParameter.swift
//  Services
//
//  Created by Vahan Grigoryan on 5/1/22.
//

import Foundation

public struct GetOrganizationParameter: IResource {
    let role_uuid: String
    
    let method = ResourceMethod.post

    public init(role_uuid: String) {
        self.role_uuid = role_uuid
    }

    var baseUrl: String {
        return "https://preprod.armed.am/am/hwmobile/get_organization"
    }

    var parameters: [String: Any] {
        return [Environment.Keys.role_uuid.rawValue: role_uuid]
    }

    var headers: [String: String] {
        guard let accessToken = KeychainStorage.shared.string(for: Environment.Keys.token.rawValue) else { return [:] }
        let header = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json",
                      "Authorization": "Bearer \(accessToken)"]
        return header
    }
}
