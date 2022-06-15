//
//  NotificationManager.swift
//  Shared
//
//  Created by Hrant on 10.05.21.
//

import Foundation

public enum NotificationManager: String {
    case themeUpdated

}

public extension NotificationManager {
    static func post(name aName: NotificationManager,
                            object anObject: Any? = nil,
                            userInfo: [String: Any] = [:]) {
        let name = Notification.Name(rawValue: aName.rawValue)
        NotificationCenter.default.post(name: name, object: anObject, userInfo: userInfo)
    }

    static func addObserver(forName name: NotificationManager,
                                   using block: @escaping (Notification) -> Void) -> NSObjectProtocol {
        let center = NotificationCenter.default
        let mainQueue = OperationQueue.main
        let name = Notification.Name(rawValue: name.rawValue)
        return center.addObserver(forName: name,
                                  object: nil,
                                  queue: mainQueue) { note in
            block(note)
        }
    }

    static func removeTokens(tokens: [NSObjectProtocol]) {
        let center = NotificationCenter.default
        tokens.forEach { center.removeObserver($0)}
    }
}
