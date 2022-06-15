//
//  SettingsStorage.swift
//  Shared
//
//  Created by Hrant on 10.05.21.
//

import Foundation

public protocol SettingsStoraging {
    func object(forKey defaultName: String) -> Any?
    func value(forKey key: String) -> Any?
    func set(_ value: Any?, forKey defaultName: String)
    func dictionary(forKey defaultName: String) -> [String: Any]?
    func data(forKey defaultName: String) -> Data?

    func removeObject(forKey defaultName: String)
    func resetData()
}

public class SettingsStorage: UserDefaults, SettingsStoraging {
    private static var settigsDefaultStorageName = "MedUpISettings"
    private var settigsStorageName: String

    public convenience init() {
        self.init(suiteName: SettingsStorage.settigsDefaultStorageName)!
    }

    public override init?(suiteName suitename: String?) {
        settigsStorageName = suitename ?? SettingsStorage.settigsDefaultStorageName

        super.init(suiteName: settigsStorageName)
    }

    public func resetData() {
        removePersistentDomain(forName: settigsStorageName)
    }
}
