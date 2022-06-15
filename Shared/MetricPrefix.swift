//
//  MetricPrefix.swift
//  Shared
//
//  Created by Hrant on 09.05.21.
//

import Foundation

public enum MetricPrefix {
    public static let notAvailableSymbol = "N/A"
    public static let pressent = "%"
}

extension Double {
    public func secondsToTime() -> String {
        let dateTime = Date(timeIntervalSince1970: (Double(self)))
        let apiTimeOnlyFormatter = DateFormatter()
        apiTimeOnlyFormatter.timeZone = TimeZone.current
        apiTimeOnlyFormatter.dateFormat = "HH:mm a"
        return apiTimeOnlyFormatter.string(from: dateTime)
    }
}
