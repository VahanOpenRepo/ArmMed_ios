//
//  QuestionNavigationModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 12.10.21.
//

import Services

public struct QuestionNavigationModel {

    let questions: [Question]

    public init(questions: [Question]) {
        self.questions = questions
    }
}
