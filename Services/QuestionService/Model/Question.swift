//
//  Question.swift
//  Services
//
//  Created by Vahe Makaryan on 13.10.21.
//

import Foundation

public struct Question: Codable {

    public let question: String
    public let variables: [QuestionVariable]

    public init(question: String, variables: [QuestionVariable]) {
        self.question = question
        self.variables = variables
    }
}

public struct QuestionVariable: Codable {
    public let name: String
    public let value: String

    public init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}
