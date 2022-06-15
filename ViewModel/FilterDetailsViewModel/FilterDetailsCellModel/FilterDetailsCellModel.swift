//
//  FilterDetailsCellModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 18.11.21.
//

import UIKit

public class FilterDetailsCellModel {

    public var placeholder: String {
        return cellType.title
    }

    public var keyboardType: FilterDetailCellKeyboardType {
        switch cellType {
        case .name, .surename, .patientSSN: return .text
        case .birthdate: return .date
        }
    }

    public var value: String? = nil

    public var cellType: FilterDetailCellType

    init(cellType: FilterDetailCellType) {
        self.cellType = cellType
    }
}
