//
//  PatientFilterRequestModel.swift
//  Services
//
//  Created by Vahe Makaryan on 21.11.21.
//

import Foundation

public struct PatientFilterRequestModel: Codable {
    public var patient_name: String?
    public var patient_last_name: String?
    public var date_of_birth: String?
    public var patient_ssn: String?

    public init() {}
}
