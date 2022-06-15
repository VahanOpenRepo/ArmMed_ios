//
//  FilterDetailsNavigationModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 18.11.21.
//

import Foundation

public struct FilterDetailsNavigationModel {

    public let filterDetailsType: FilterDetailsType
}

public enum FilterDetailsType {
    case none
    case nameSurname
    case nameSurnameBirthdate
    case patientSSN

    var title: String {
        switch self {
        case .none: return ""
        case .nameSurname: return "Անուն Ազգանունի"
        case .nameSurnameBirthdate: return "Անուն Ազգանունի և Ծննդյան տարեթվի"
        case .patientSSN: return "Սոց քարտի"
        }
    }

    static func type(by title: String) -> FilterDetailsType {
        switch title {
        case "Անուն Ազգանունի": return .nameSurname
        case "Անուն Ազգանունի և Ծննդյան տարեթվի": return .nameSurnameBirthdate
        case "Սոց քարտի": return .patientSSN
        default: return .none
        }
    }
}
