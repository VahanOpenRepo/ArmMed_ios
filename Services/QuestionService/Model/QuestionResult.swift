//
//  QuestionResponse.swift
//  Services
//
//  Created by Vahe Makaryan on 13.10.21.
//

import Foundation

// MARK: - Result
public struct QuestionResult: Codable {
    public let question, conditionVariable, minValue, maxValue: String?
    public let variableTypeCode: String?
    public let dictionaryContent: [DictionaryContent]?
    public let protocolName, file: String?

    enum CodingKeys: String, CodingKey {
        case question, conditionVariable
        case minValue = "min_value"
        case maxValue = "max_value"
        case variableTypeCode = "variable_type_code"
        case dictionaryContent = "dictionary_content"
        case protocolName = "protocol_name"
        case file
    }
}

// MARK: - DictionaryContent
public struct DictionaryContent: Codable {
    public let text, textAM, textEN, textRU: String
    public let code: String

    enum CodingKeys: String, CodingKey {
        case text
        case textAM = "text_AM"
        case textEN = "text_EN"
        case textRU = "text_RU"
        case code
    }
}
/*
 // MARK: - Welcome
 // MARK: - Result
 struct Result: Codable {
     let question, conditionVariable, minValue, maxValue: String
     let dictionaryContent: [DictionaryContent]
     let variableTypeCode: String

     enum CodingKeys: String, CodingKey {
         case question, conditionVariable
         case minValue = "min_value"
         case maxValue = "max_value"
         case dictionaryContent = "dictionary_content"
         case variableTypeCode = "variable_type_code"
     }
 }
 */
