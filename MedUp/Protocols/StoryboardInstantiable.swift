//
//  StoryboardInstantiable.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import UIKit

protocol StoryboardInstantiable {
    static var storyboardName: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {
    static var storyboardName: String {
        return getResourceIdentifier(for: self)
    }

    static func instantiate() -> Self {

        let storyboard = UIStoryboard(name: self.storyboardName, bundle: nil)

        guard let viewController = storyboard.instantiateInitialViewController() else {
            fatalError("Expected storyboard \(storyboardName) to have an initial view controller")
        }
        guard let typedViewController = viewController as? Self else {
            fatalError("Expected storyboard \(storyboardName) with an initial view" +
                       " controller of class \(self) – found \(type(of: viewController))")
        }
        return typedViewController
    }
}

func getResourceIdentifier(for aClass: AnyClass) -> String {
    let fullyQualifiedIdentifier = NSStringFromClass(aClass)
    guard let finalPart = fullyQualifiedIdentifier.split(separator: ".").last else {
        fatalError("Unexpected format of fully qualified identifier: \(fullyQualifiedIdentifier)")
    }
    return String(finalPart)
}
