//
//  PatientDetailsViewModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 25.09.21.
//

import Foundation
import Services
import RxSwift
import RxRelay
import Shared

public class PatientDetailsInputServices: CommonServices {

    public init() {}
}

public typealias MPatientDetailsViewModel = ViewModel<PatientDetailsInputServices>

public class PatientDetailsViewModel: MPatientDetailsViewModel {

    private let patientNavModel: PatientNavigationModel

    public var patientDetailViewModel = PublishSubject<PatientDetailViewModel>()

    public var initialQuestions: [Question] {
        var questions = [Question]()

        if let age = patientNavModel.patientResponse.dateOfBirth?.toDate(format: .yyyy_mm_dd_mid_line)?.calculateAge() {

            questions.append(Question(question: "Տարիք", variables: [QuestionVariable(name: "Տարիք", value: "\(age)")]))
        }

        if let patientGenderCode = patientNavModel.patientResponse.patientGenderCode {
            questions.append(Question(question: "Սեռ",
                                      variables: [QuestionVariable(name: "Սեռ",
                                                                   value: patientGenderCode)]))
        }
        return questions
    }

    public init(services: PatientDetailsInputServices, patientNavModel: PatientNavigationModel) {
        self.patientNavModel = patientNavModel
        super.init(services: services)
    }

    public override func viewDidLoad() {

        let dataSource = processPatientData(patient: patientNavModel.patientResponse)
        let patient = patientNavModel.patientResponse
        let fullName = patient.patientName + " " + patient.patientLastName

        var visitDate = ""
        if let date = patient.visitStart.toDate() {
            visitDate = date.string(format: .yyyy_mm_dd_dot)
        }

        var timeRangeText = ""
        if let startDate = patient.visitStart.toDate(), let endDate = patient.visitEnd.toDate() {
            let start = startDate.string(format: .HH_mm)
            let end = endDate.string(format: .HH_mm)
            timeRangeText = start + " - " + end
        }

        let detailViewModel = PatientDetailViewModel(fullName: fullName,
                                                     imageUrl: patientNavModel.patientResponse.picture,
                                                     lastUpdateTime: timeRangeText,
                                                     lastUpdateDate: visitDate,
                                                     cellModels: dataSource)

        patientDetailViewModel.onNext(detailViewModel)
    }

    private func processPatientData(patient: PatientResponse) -> [PatientDetailCellModel] {
        var patientDetails = [PatientDetailCellModel]()

        if let dateOfBirth = patient.dateOfBirth, let date = dateOfBirth.toDate(format: .yyyy_mm_dd_mid_line) {
            let birthdate = date.string(format: .yyyy_mm_dd_dot)
            patientDetails.append(PatientDetailCellModel(titleText: "Ծննդ. ամսաթիվ",
                                                         valueText: birthdate))
        }

        if let patientMobileNumber = patient.patientMobileNumber, !patientMobileNumber.isEmpty {
            patientDetails.append(PatientDetailCellModel(titleText: "Հեռ. համար",
                                                         valueText: patientMobileNumber))
        }

        if let patientEmail = patient.patientEmail, !patientEmail.isEmpty {
            patientDetails.append(PatientDetailCellModel(titleText: "Էլ. հասցե",
                                                         valueText: patientEmail))
        }

        if let patientSsn = patient.patientSsn, !patientSsn.isEmpty {
            patientDetails.append(PatientDetailCellModel(titleText: "ՀԾՀ",
                                                         valueText: patientSsn))
        }

        if let patientPassport = patient.patientPassport, !patientPassport.isEmpty {
            patientDetails.append(PatientDetailCellModel(titleText: "Անձնագիր",
                                                         valueText: patientPassport))
        }

        if let patientAddress = patient.patientAddress, !patientAddress.isEmpty {
            patientDetails.append(PatientDetailCellModel(titleText: "Հասցե",
                                                         valueText: patientAddress))
        }

        if let patientFinanceSource = patient.patientFinanceSource, !patientFinanceSource.isEmpty {
            patientDetails.append(PatientDetailCellModel(titleText: "Սոցխումբ",
                                                         valueText: patientFinanceSource))
        }

        if let visitMode = patient.visitMode, !visitMode.isEmpty {
            patientDetails.append(PatientDetailCellModel(titleText: "Դեպքի տեսակ",
                                                         valueText: visitMode))
        }

        if let diagnose = patient.diagnose, !diagnose.isEmpty {
            patientDetails.append(PatientDetailCellModel(titleText: "Ախտորոշում",
                                                         valueText: diagnose))
        }

        return patientDetails
    }
}

