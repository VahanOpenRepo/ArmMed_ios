//
//  UITableView+Extension.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import UIKit

extension UIView {
    static func autoLayoutView() -> Self {
        let view = Self()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }

    func loadNib<T: UIView>() -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let nibName = type(of: self).description().components(separatedBy: ".").last else {
            return nil
        }

        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? T
    }

    static func nib<T: UIView>() -> T {
        return nib(T.self)
    }

    static func nib<T: UIView>(_ type: T.Type) -> T {
        guard
            let view = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as? T
            else {
                preconditionFailure("Nib file incorrect")
        }
        return view
    }
}
/** Simplifies registrations and dequeueing cells. */
extension UITableView {
    func register<T: UITableViewCell>(_ type: T.Type) {
        register(UINib(nibName: String(describing: type), bundle: nil), forCellReuseIdentifier: T.identifier)
    }

    func dequeue<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T {
            return cell
        }
        fatalError("Could not create cell with identifier: \(T.identifier)")
    }

    func deselectAll(section: Int? = nil) {
        if let indexPaths = self.indexPathsForSelectedRows {
            indexPaths.forEach({
                if section != nil && section != $0.section { return }
                self.deselectRow(at: $0, animated: false)
            })
        }
    }

    func selectItems(indexes: Set<Int>, section: Int) {
        self.deselectAll()
        indexes.forEach({
            let indexPath = IndexPath(row: $0, section: section)
            self.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        })
    }

    func lastIndexPath() -> NSIndexPath? {

        var indexPath: NSIndexPath?
        var section: Int = numberOfSections - 1

        repeat {

            let numberOfRowsInSection = numberOfRows(inSection: section)

            if numberOfRowsInSection > 0 {

                indexPath = NSIndexPath(row: numberOfRowsInSection - 1, section: section)
                break
            }

            section -= 1
        } while section > 0

        return indexPath
    }
}

extension UITableViewCell: IViewInstantiable { }
