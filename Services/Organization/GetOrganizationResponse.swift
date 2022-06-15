//
//  GetOrganizationResponse.swift
//  Services
//
//  Created by Vahan Grigoryan on 5/1/22.
//

import Foundation

// MARK: - Welcome
public struct GetOrganizationResponse: Codable {
    let status: Int
    let result: ResultResponse
    let error: String
}

// MARK: - Result
public struct ResultResponse: Codable {
    let name: String
    let medicalDepartments: [MedicalDepartment]
    let nameAM, uuid, taxPayerID: String
    let services: [Service]

    enum CodingKeys: String, CodingKey {
        case name
        case medicalDepartments = "medical_departments"
        case nameAM = "name_AM"
        case uuid
        case taxPayerID = "tax_payer_id"
        case services
    }
}

// MARK: - MedicalDepartment
public struct MedicalDepartment: Codable {
    let departmentTypeCode, departmentSpecializationCode: String
    let uuid: String?
    let doctors: [Doctor]?
    let services: [Service]?

    enum CodingKeys: String, CodingKey {
        case departmentTypeCode = "department_type_code"
        case departmentSpecializationCode = "department_specialization_code"
        case uuid, doctors, services
    }
}

// MARK: - Doctor
public struct Doctor: Codable {
    let firstName, lastName, socialCard, uuid: String
    let name, patronymicName, hwSpecCode, typeCode: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case socialCard = "social_card"
        case uuid, name
        case patronymicName = "patronymic_name"
        case hwSpecCode = "hw_spec_code"
        case typeCode = "type_code"
    }
}

// MARK: - Service
struct Service: Codable {
    let code, name, serviceUUID, healthIssueNote: String
    let insName: String?

    enum CodingKeys: String, CodingKey {
        case code, name
        case serviceUUID = "service_uuid"
        case healthIssueNote = "health_issue_note"
        case insName = "ins_name"
    }
}

