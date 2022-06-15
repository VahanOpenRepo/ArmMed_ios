//
//  FilterDetailCellType.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 21.11.21.
//

import Foundation

public enum FilterDetailCellType {

    case name
    case surename
    case birthdate
    case patientSSN

    var title: String {
        switch self {
        case .name: return "Անուն"
        case .surename: return "Ազգանուն"
        case .birthdate: return "Ծննդյան տարեթիվ"
        case .patientSSN: return "Սոց. Քարտ"
        }
    }
}
