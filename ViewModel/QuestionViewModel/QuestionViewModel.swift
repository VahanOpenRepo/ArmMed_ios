//
//  QuestionViewModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 12.10.21.
//

import Foundation
import Services
import RxSwift
import RxRelay
import Shared

public class QuestionInputServices: CommonServices {

    let questionService: QuestionService = Services.get()

    public init() {}
}

public typealias MQuestionViewModel = ViewModel<QuestionInputServices>

public class QuestionViewModel: MQuestionViewModel {

    private let questionNavModel: QuestionNavigationModel

    private var currentQuestion: String?

    private var questionText: String?

    public var viewType = PublishSubject<QuestionViewType>()

    public var fileUrl = PublishSubject<String>()

    public init(services: QuestionInputServices, questionNavModel: QuestionNavigationModel) {
        self.questionNavModel = questionNavModel
        super.init(services: services)
    }

    public override func viewDidLoad() {
        fetchData(with: questionNavModel.questions)
    }

    public func textFieldDidEndEdithing(with text: String?) {

        questionText = text
    }

    public func nextButtonPressed() -> [Question]? {
        guard let text = questionText, let currentQuestion = currentQuestion else {
            let error = MedUpError.unexpectedError("Your Question Can not be empty")
            self.handleServiceError(error: error)
            return nil }

        let question = Question(question: currentQuestion, variables: [QuestionVariable(name: currentQuestion, value: text)])

        var newQuestions = questionNavModel.questions
        newQuestions.append(question)

        return newQuestions
    }

    private func fetchData(with questions: [Question]) {
        let parameter = QuestionParameter(token: "", get_protocol: 0, questions: questions)
        isLoading.accept(true)
        services.questionService.fetch(params: parameter).subscribe(onSuccess: { [weak self] response in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.processResponse(response.result)
        }, onFailure: { [weak self] error in
            guard let self = self else { return }
            self.handleServiceError(error: error)
            self.isLoading.accept(false)
        }).disposed(by: disposeBag)
    }

    private func processResponse(_ response: QuestionResult?) {
        guard let response = response else {
            self.handleServiceError(error: MedUpError.noData)
            return }

        if let file = response.file {
            fileUrl.onNext(file)
            return
        }

        currentQuestion = response.question

        guard let variableTypeCode = Int(response.variableTypeCode ?? "0") else {
            let error = MedUpError.internalError("There is not type named: \(response.variableTypeCode ?? "")")
            handleServiceError(error: error, showAlert: true)
            return }

        switch variableTypeCode {

        case QuestionType.boolean.rawValue:
            openNeededBooleanView(questionTitle: response.question)
        case QuestionType.dictioanary.rawValue, QuestionType.dictionarylocal.rawValue:
            openNeededDictView(dictionaryContent: response.dictionaryContent)

        case QuestionType.number.rawValue:

            let valueRange = ValueRange(minValue: minValueText(with: response.minValue),
                                        maxValue: maxValueText(with: response.maxValue))
            openNeededFieldTypeView(with: response.question, type: .number, valueRange: valueRange)
        case QuestionType.text.rawValue:
            let valueRange = ValueRange(minValue: minValueText(with: response.minValue),
                                        maxValue: maxValueText(with: response.maxValue))
            openNeededFieldTypeView(with: response.question, type: .text, valueRange: valueRange)
        case QuestionType.date.rawValue:
            let valueRange = ValueRange(minValue: minValueText(with: response.minValue),
                                        maxValue: maxValueText(with: response.maxValue))
            openNeededFieldTypeView(with: response.question, type: .date, valueRange: valueRange)
        case QuestionType.datetime.rawValue:
            let valueRange = ValueRange(minValue: minValueText(with: response.minValue),
                                        maxValue: maxValueText(with: response.maxValue))
            openNeededFieldTypeView(with: response.question, type: .datetime, valueRange: valueRange)
        case QuestionType.time.rawValue:
            let valueRange = ValueRange(minValue: minValueText(with: response.minValue),
                                        maxValue: maxValueText(with: response.maxValue))
            openNeededFieldTypeView(with: response.question, type: .time, valueRange: valueRange)

        default:
            let error = MedUpError.internalError("There is not type named: \(variableTypeCode)")
            handleServiceError(error: error, showAlert: true)
        }
    }

    private func minValueText(with value: String?) -> String {
        if let value = value, let intValue = Float(value) {
            return "Min: \(intValue)"
        }

        return ""
    }

    private func maxValueText(with value: String?) -> String {
        if let value = value, let intValue = Float(value) {
            return "Max: \(intValue)"
        }

        return ""
    }

    private func openNeededFieldTypeView(with questionTitle: String?, type: QuestionType, valueRange: ValueRange) {

        var cellModels = [QuestionCellModel]()
        let cellModel = QuestionCellModel(titleText: questionTitle, textFieldType: type)
        cellModels.append(cellModel)
        viewType.onNext(.input(dataSource: cellModels, range: valueRange))
    }

    private func openNeededBooleanView(questionTitle: String?) {
        viewType.onNext(.boolean(title: currentQuestion))
    }

    private func openNeededDictView(dictionaryContent: [DictionaryContent]?) {

        let source = dictionaryContent?.map({ SelectableCellModel(titleText: $0.text, isSelected: false, code: $0.code) }) ?? []

        viewType.onNext(.dictioanary(dataSource: source))
    }
}


