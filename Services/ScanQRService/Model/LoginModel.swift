//
//  LoginModel.swift
//  Services
//
//  Created by Vahan Grigoryan on 7/18/21.
//

import Foundation

public struct LoginResponse: Codable {
    public var result: Result?
    public var roles: [Role]?
}

public struct Role: Codable {
    var role: String?
    var role_uuid: String?
}

public struct Result: Codable {
    var firstName: String?
    var lastname: String?
    var date: String?
    var token: String?
    var socialCard: String?
    var email: String?
    var mobileNumber: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastname = "last_name"
        case date = "date_of_birth"
        case token = "long_token"
        case socialCard = "social_card"
        case mobileNumber = "mobile_number"
        case email = "email"
    }
       
    public func transformToUser() -> User {
        var user = User()
        user.firstName = firstName
        user.lastname = lastname
        user.date = date
        user.token = token
        user.socialCard = socialCard
        user.email = email
        user.mobileNumber = mobileNumber
        return user
    }
}

public struct User: Codable {
    public var firstName: String?
    public var lastname: String?
    public var date: String?
    public var token: String?
    public var socialCard: String?
    public var email: String?
    public var mobileNumber: String?

    public init() { }
}
