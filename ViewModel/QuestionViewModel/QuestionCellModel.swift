//
//  QuestionCellModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 12.10.21.
//

import Foundation
import UIKit

public struct QuestionCellModel {

    public let titleText: String?

    public let textFieldType: QuestionType?
}

public struct ValueRange {
    public let minValue: String
    public let maxValue: String

    public init(minValue: String, maxValue: String) {
        self.minValue = minValue
        self.maxValue = maxValue
    }
}
