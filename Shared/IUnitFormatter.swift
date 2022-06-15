//
//  IUnitFormatter.swift
//  Shared
//
//  Created by Hrant on 09.05.21.
//

import Foundation

public protocol IUnitFormatter {
    func formattedTemperature(for value: Double?) -> String
}

public extension IUnitFormatter {
    func formattedTemperature(for value: Double?) -> String {
        guard let value = value else { return MetricPrefix.notAvailableSymbol }
        return "\(String(format: "%.0f", value)) \(MetricPrefix.pressent)"
    }
}
