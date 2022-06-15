//
//  UserSettings.swift
//  Services
//
//  Created by Hrant on 10.05.21.
//

import Foundation
import Shared

enum UserSettingsKeys: String, CaseIterable {
    case isDemoVersion = "isDemoVersion"
    case userName = "userName"
}

public protocol IUserSettings {
    static var current: IUserSettings { get }

    var isDemoVersion: Bool { get set }
    var userName: String? { get set }
}


public struct UserSettings: IUserSettings {
    public static var current: IUserSettings = UserSettings()
    static var storage: SettingsStoraging = SettingsStorage()
    public init() {}


    @UserDefault(key: UserSettingsKeys.isDemoVersion.rawValue,
                 defaultValue: false,
                 store: storage)
    public var isDemoVersion: Bool

    @UserDefault(key: UserSettingsKeys.userName.rawValue,
                 defaultValue: nil,
                 store: storage)
    public var userName: String?
}

public extension IUserSettings {

    func removeAllUserSettingsData() {
        UserSettingsKeys.allCases.forEach({
            UserSettings.storage.removeObject(forKey: $0.rawValue)
        })

    }
}

@propertyWrapper
public struct UserDefault<T> {
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
            return store.object(forKey: key) as? T ?? defaultValue
        }
        set {
            store.set(newValue, forKey: key)
        }
    }
}
