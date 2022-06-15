//
//  ProfileNavigationModel.swift
//  ViewModel
//
//  Created by Vahan Grigoryan on 7/27/21.
//

import Foundation
import Services

public struct ProfileNavigationModel {
    public let user: User?

    public init(user: User?) {
        self.user = user
    }
}
