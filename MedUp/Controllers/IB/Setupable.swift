//
//  Setupable.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation

public protocol Setupable {
    associatedtype SetupModel

    func setup(with model: SetupModel)
}
