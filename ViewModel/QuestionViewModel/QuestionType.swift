//
//  QuestionType.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 17.10.21.
//

import Foundation

public enum QuestionViewType {
    case boolean(title: String?)
    case input(dataSource: [QuestionCellModel], range: ValueRange)
    case dictioanary(dataSource: [SelectableCellModel])
}

public enum QuestionType: Int {

    case boolean = 1
    case number = 2
    case dictioanary = 3
    case text = 5
    case date = 6
    case datetime = 7
    case time = 8
    case dictionarylocal = 9

    public var format: DateFormat {
        switch self {
        case .date: return .yyyy_mm_dd_mid_line
        case .datetime: return .yyyy_MM_dd_HH_mm
        case .time: return .HH_mm
        default: return .none
        }
    }

    public var formatUI: DateFormat {
        switch self {
        case .date: return .yyyy_mm_dd_mid_line
        case .datetime: return .yyyy_MM_dd_HH_mm
        case .time: return .HH_mm
        default: return .none
        }
    }
}
