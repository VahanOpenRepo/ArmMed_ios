//
//  Environment.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation

public struct Environment {
    public static var current: Environment = Environment(path: "https://api.openweathermap.org/data/2.5/weather")
    public var path: String
    
    public enum Keys: String {
        case units = "units"
        case metric = "metric"
        case appid = "appid"
        case cityParam = "q"
        case login = "login"
        case from = "from"
        case count = "count"
        case direction = "direction"
        case first = "first"
        //case token = "7bdf0b28b4b7a4d9e7eaf2a611f95aa9"
        case lat = "lat"
        case lon = "lon"
        
        case filter = "filter"
        
        case questions = "questions"
        case get_protocol = "get_protocol"
        case role_uuid = "role_uuid"
        case token = "token"
        case patient_social_card = "patient_social_card"
        case patient_mobile_number = "patient_mobile_number"
        case visit_start = "visit_start"
        case visit_end = "visit_end"
        case visit_type = "visit_type"
        case reason_of_the_visit = "reason_of_the_visit"
        case source_of_financing = "source_of_financing"
        case health_issue_type = "health_issue_type"
        case health_issue_case_type = "health_issue_case_type"
        case health_issue_start_date = "health_issue_start_date"
        case health_issue_case_number = "health_issue_case_number"
        case patient_email = "patient_email"
        case patient_last_name_EN = "patient_last_name_EN"
        case patient_first_name_EN = "patient_first_name_EN"
        
    }
}
