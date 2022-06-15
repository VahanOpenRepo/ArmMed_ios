//
//  SelectableCellModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 18.10.21.
//

import Foundation

public class SelectableCellModel {

    public let titleText: String?
    public var isSelected: Bool
    public let code: String

    init(titleText: String?, isSelected: Bool, code: String) {
        self.titleText = titleText
        self.isSelected = isSelected
        self.code = code
    }
}
