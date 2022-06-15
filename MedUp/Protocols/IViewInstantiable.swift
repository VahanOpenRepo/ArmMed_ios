//
//  IViewInstantiable.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import UIKit

/** Implementations know their (i.e. reuse or storyboard) identifiers. */
public protocol IViewInstantiable {

    /** The story board identifier for this view controller. */
    static var identifier: String { get }

}

/** Normally, the views or the storyboards identifier should be equal to a view controllers class name. */
extension IViewInstantiable {

    public static var identifier: String { return String(describing: self) }
    static var storyboard: UIStoryboard { return UIStoryboard(name: String(describing: self), bundle: nil) }
}
