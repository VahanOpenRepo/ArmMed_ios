//
//  ScanQRParametr.swift
//  Services
//
//  Created by Vahan Grigoryan on 7/18/21.
//

import Foundation


public struct ScanQRParameter: IResource {
    let login: String
    let method = ResourceMethod.post

    public init(login: String) {
        self.login = login
    }
    
    var baseUrl: String {
        return "https://preprod.armed.am/am/hwmobile/armed_login"
    }
    
    var parameters: [String: Any] {
        return [Environment.Keys.login.rawValue: login]
    }

    var headers: [String: String] {
        let header = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json"]

        return header
    }
}
