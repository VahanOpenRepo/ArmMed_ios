//
//  PatientDetailViewModel.swift
//  ViewModel
//
//  Created by Vahe Makaryan on 03.10.21.
//

import Foundation

public struct PatientDetailViewModel {
    public let fullName: String?
    public let imageUrl: String?
    public let lastUpdateTime: String?
    public let lastUpdateDate: String?
    public let cellModels: [PatientDetailCellModel]
}
