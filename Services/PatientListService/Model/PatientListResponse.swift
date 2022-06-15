//
//  PatientListResponse.swift
//  Services
//
//  Created by Vahe Makaryan on 05.10.21.
//

import Foundation

// MARK: - Result
public struct PatientListResult: Codable {
    public let patients: [PatientResponse]?
    public let mi: [Mi]?
    let dic: Dic?
   // let futureArr: [String]?

    enum CodingKeys: String, CodingKey {
        case mi, dic
      //  case futureArr = "future_arr"
        case patients = "array"
    }
}

// MARK: - Array
public struct PatientResponse: Codable {
    public let id, visitRoom, visitID, orderDate: String
    public let actionDate, visitStart, visitEnd, realVisitStart: String
    public let realVisitEnd, visitModeCode, visitTypeCode: String
    public let visitColorCode: String
    public let visitStatus, statusFrom, statusTo, doctorID: String
    public let doctorName: String
    public let doctorLastName: String
    public let patientID, patientName, patientLastName, patientPatronymicName: String
    public let patientSsn, dateOfBirth, profilePicture, patientGenderCode: String?
    public let patientHomePhone, patientMobileNumber, patientMobilePhone, patientEmail: String?
    public let patientPassport, sourceID, removed, subdivisionSpecializationCode: String?
    public let departmentTypeCode: String
    public let departmentName: String?
    public let miName: String
    public let hwRpID, patientAddress, services, patientFinanceSourceCode: String?
    public let insuranceStatus: String
    public let diagnoseCode, outcomeCode: String
    public let visitMode: String?
    public let visitType: String
    public let patientGender: String
    public let subdivisionSpecialization: String
    public let departmentType: String?
    public let patientFinanceSource: String?
    public let diagnose: String?
    public let outcome: String
    public let identIDS: IdentIDS
    public let picture: String

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case visitRoom = "visit_room"
        case visitID = "visit_id"
        case orderDate = "order_date"
        case actionDate = "action_date"
        case visitStart = "visit_start"
        case visitEnd = "visit_end"
        case realVisitStart = "real_visit_start"
        case realVisitEnd = "real_visit_end"
        case visitModeCode = "visit_mode_code"
        case visitTypeCode = "visit_type_code"
        case visitColorCode = "visit_color_code"
        case visitStatus = "visit_status"
        case statusFrom = "status_from"
        case statusTo = "status_to"
        case doctorID = "doctor_id"
        case doctorName = "doctor_name"
        case doctorLastName = "doctor_last_name"
        case patientID = "patient_id"
        case patientName = "patient_name"
        case patientLastName = "patient_last_name"
        case patientPatronymicName = "patient_patronymic_name"
        case patientSsn = "patient_ssn"
        case dateOfBirth = "date_of_birth"
        case profilePicture = "profile_picture"
        case patientGenderCode = "patient_gender_code"
        case patientHomePhone = "patient_home_phone"
        case patientMobileNumber = "patient_mobile_number"
        case patientMobilePhone = "patient_mobile_phone"
        case patientEmail = "patient_email"
        case patientPassport = "patient_passport"
        case sourceID = "@source_id"
        case removed
        case subdivisionSpecializationCode = "subdivision_specialization_code"
        case departmentTypeCode = "department_type_code"
        case departmentName = "department_name"
        case miName = "mi_name"
        case hwRpID = "hw_rp_id"
        case patientAddress = "patient_address"
        case services
        case patientFinanceSourceCode = "patient_finance_source_code"
        case insuranceStatus = "insurance_status"
        case diagnoseCode = "diagnose_code"
        case outcomeCode = "outcome_code"
        case visitMode = "visit_mode"
        case visitType = "visit_type"
        case patientGender = "patient_gender"
        case subdivisionSpecialization = "subdivision_specialization"
        case departmentType = "department_type"
        case patientFinanceSource = "patient_finance_source"
        case diagnose, outcome
        case identIDS = "~ident_ids"
        case picture
    }
}

// MARK: - IdentIDS
public struct IdentIDS: Codable {
    let patientID: String

    enum CodingKeys: String, CodingKey {
        case patientID = "patient_id"
    }
}

//enum InsuranceStatus: String, Codable {
//    case empty = ";;;;"
//    case insuranceStatus = ""
//    case purple = ";"
//}
//
//enum MiName: String, Codable {
//    case հվկակ = "ՀՎԿԱԿ"
//    case սերտիֆիկացիոնԿլինիկա = "Սերտիֆիկացիոն կլինիկա"
//    case սուրբԳրիգորԼուսավորիչԲժշկականԿենտրոնՓԲԸ = "Սուրբ Գրիգոր Լուսավորիչ բժշկական կենտրոն ՓԲԸ"
//}
//
//enum Outcome: String, Codable {
//    case administrative = "administrative"
//    case empty = ""
//}
//
//enum PatientFinanceSource: String, Codable {
//    case պետպատվեր = "Պետպատվեր"
//    case վճարովի = "Վճարովի"
//}
//
//enum PatientGender: String, Codable {
//    case empty = ""
//    case արական = "արական"
//    case իգական = "իգական"
//}
//
//enum SubdivisionSpecialization: String, Codable {
//    case ընդհանուրՊրոֆիլի = "Ընդհանուր պրոֆիլի"
//    case ինտենսիվԹերապիայի = "Ինտենսիվ թերապիայի"
//    case ինֆեկցիոն = "Ինֆեկցիոն"
//}
//
//enum VisitColorCode: String, Codable {
//    case visit0 = "visit_0"
//}
//
//enum VisitMode: String, Codable {
//    case ամբուլատորԱյց = "Ամբուլատոր այց"
//    case հիվանդանոցայինԱյց = "Հիվանդանոցային այց"
//}
//
//enum VisitType: String, Codable {
//    case անձնականՆերկայություն = "Անձնական ներկայություն"
//}

// MARK: - Dic
public  struct Dic: Codable {
    let caseType: [Mi]

    enum CodingKeys: String, CodingKey {
        case caseType = "case_type"
    }
}

// MARK: - Mi
public  struct Mi: Codable {
    public let name, id: String
    public let role_uuid: String?
}
