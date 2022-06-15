//
//  QuestionParameter.swift
//  Services
//
//  Created by Vahe Makaryan on 13.10.21.
//

import Foundation

public struct QuestionParameter: IResource {

    let get_protocol: Int
    let questions: [Question]
    let token: String

    let method = ResourceMethod.post

    public init(token: String, get_protocol: Int, questions: [Question]) {
        self.token = token
        self.get_protocol = get_protocol
        self.questions = questions
    }

    var baseUrl: String {
        return "https://preprod.armed.am/am/hwmobile/getquestions"

    }

    var parameters: [String: Any] {

        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(questions) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {

                return ["questions": jsonString]
            }
        }

        return ["questions": []]
    }

    var headers: [String: String] {
        let header = ["Content-Type": "application/x-www-form-urlencoded", "Accept": "application/json"]

        return header
    }

    var containsContentLength: Bool {
        return true
    }
}
