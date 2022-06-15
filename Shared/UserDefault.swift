//
//  UserDefault.swift
//  Shared
//
//  Created by Hrant on 10.05.21.
//

import Foundation

@propertyWrapper
public struct UserDefaultCustomObject<T: Codable> {
    public init(key: String,
                defaultValue: T,
                store: SettingsStoraging) {
        self.key = key
        self.defaultValue = defaultValue
        self.store = store
    }

    let key: String
    let defaultValue: T
    let store: SettingsStoraging
    public var wrappedValue: T {
        get {
            if let encoded = store.data(forKey: key) {
                let value = try? JSONDecoder().decode(T.self, from: encoded)
                return value ?? defaultValue
            }
            return defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                store.set(encoded, forKey: key)
            }
        }
    }
}

//@propertyWrapper
//public struct UserDefault<T> {
//    public init(key: String,
//                defaultValue: T,
//                store: SettingsStoraging) {
//        self.key = key
//        self.defaultValue = defaultValue
//        self.store = store
//    }
//
//    let key: String
//    let defaultValue: T
//    let store: SettingsStoraging
//    public var wrappedValue: T {
//        get {
//            return store.object(forKey: key) as? T ?? defaultValue
//        }
//        set {
//            store.set(newValue, forKey: key)
//        }
//    }
//}

@propertyWrapper
public struct EnumUserDefault<KeyType, ValueType> where KeyType: RawRepresentable & Hashable,
                                                        KeyType.RawValue: Hashable {
    let key: String
    let defaultValue: [KeyType: ValueType]
    let store: SettingsStoraging

    public var wrappedValue: [KeyType: ValueType] {
        get {
            guard let value = store.object(forKey: key) as? [KeyType.RawValue: Any] else {
                return defaultValue
            }

            var enumValues = [KeyType: ValueType]()
            value.forEach {
                guard  let key = KeyType.init(rawValue: $0.key),
                    let value = $0.value as? ValueType else { return }
                enumValues[key] = value
            }

            return enumValues
        }
        set {
            var rawValues = [KeyType.RawValue: ValueType]()
            newValue.forEach {
                rawValues[$0.key.rawValue] = $0.value
            }
            store.set(rawValues, forKey: key)
        }
    }

    public init(key: String, defaultValue: [KeyType: ValueType], store: SettingsStoraging) {
        self.key = key
        self.defaultValue = defaultValue
        self.store = store
    }
}

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
    private static var settigsDefaultStorageName = "AgMRISettings"
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
