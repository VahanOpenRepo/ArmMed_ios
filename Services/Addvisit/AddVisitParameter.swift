//
//  AddVisitParameter.swift
//  Services
//
//  Created by Vahan Grigoryan on 5/1/22.
//

import Foundation

public struct AddVisitParameter: IResource {
    let role_uuid: String?
    let patient_social_card: String?
    let patient_mobile_number: String?
    let visit_start: String?
    let visit_end: String?
    let visit_type: String?
    let reason_of_the_visit: String?
    let source_of_financing: String?
    let health_issue_type: String?
    let health_issue_case_type: String?
    let health_issue_start_date: String?
    let health_issue_case_number: String?
    let patient_email: String?
    let patient_last_name_EN: String?
    let patient_first_name_EN: String?

    let method = ResourceMethod.post

    public init(role_uuid: String?, patient_social_card: String?, patient_mobile_number: String?, visit_start: String?, visit_end: String?, visit_type: String?, reason_of_the_visit: String?, source_of_financing: String?, health_issue_type: String?, health_issue_case_type: String?, health_issue_start_date: String?, health_issue_case_number: String?, patient_email: String?, patient_last_name_EN: String?, patient_first_name_EN: String?) {
        self.role_uuid = role_uuid
        self.patient_social_card = patient_social_card
        self.patient_mobile_number = patient_mobile_number
        self.visit_start = visit_start
        self.visit_end = visit_end
        //self.visit_mode = visit_mode
        self.visit_type = visit_type
        self.reason_of_the_visit = reason_of_the_visit
        self.source_of_financing = source_of_financing
        self.health_issue_type = health_issue_type
        self.health_issue_case_type = health_issue_case_type
        self.health_issue_start_date = health_issue_start_date
        self.health_issue_case_number = health_issue_case_number
        self.patient_email = patient_email
        self.patient_last_name_EN = patient_last_name_EN
        self.patient_first_name_EN = patient_first_name_EN
    }

    var baseUrl: String {
        return "https://preprod.armed.am/am/hwmobile/add_visit"
    }

//    var body: [String : String] {
//      return  [Environment.Keys.role_uuid.rawValue: role_uuid!,
//                Environment.Keys.patient_social_card.rawValue: patient_social_card!,
//                Environment.Keys.patient_mobile_number.rawValue: patient_mobile_number!,
//                Environment.Keys.visit_start.rawValue: visit_start!,
//                      Environment.Keys.visit_end.rawValue: visit_end!,
//                      Environment.Keys.visit_type.rawValue: visit_type!,
//                      Environment.Keys.reason_of_the_visit.rawValue: reason_of_the_visit!,
//                            Environment.Keys.source_of_financing.rawValue: source_of_financing!,
//                      Environment.Keys.health_issue_type.rawValue: health_issue_type!,
//                      Environment.Keys.health_issue_case_number.rawValue: health_issue_case_number!
//        ]
//    }
    var parameters: [String: Any] {
        var params = [Environment.Keys.role_uuid.rawValue: role_uuid!,
                      Environment.Keys.patient_social_card.rawValue: patient_social_card!,
                      Environment.Keys.patient_mobile_number.rawValue: patient_mobile_number!,
                      Environment.Keys.visit_start.rawValue: visit_start!,
                      Environment.Keys.visit_end.rawValue: visit_end!,
                      Environment.Keys.visit_type.rawValue: visit_type!,
                      Environment.Keys.reason_of_the_visit.rawValue: reason_of_the_visit!,
                      Environment.Keys.source_of_financing.rawValue: source_of_financing!,
                      Environment.Keys.health_issue_type.rawValue: health_issue_type!,
                      Environment.Keys.health_issue_case_type.rawValue: health_issue_case_type!,
                      Environment.Keys.health_issue_start_date.rawValue: health_issue_start_date!,
                      Environment.Keys.health_issue_case_number.rawValue: health_issue_case_number!
        ]

        return params as [String : Any]
    }

    var headers: [String: String] {
        guard let accessToken = KeychainStorage.shared.string(for: Environment.Keys.token.rawValue) else { return [:] }
        let header = ["Content-Type": "application/x-www-form-urlencoded",
                      "Accept": "application/json",
                      "Authorization": "Bearer \(accessToken)"]

        return header
    }
}
