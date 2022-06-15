//
//  MedUpAlert.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import UIKit

class MedUpAlert {

    let alertController: UIAlertController

    init(title: String?,
         message: String?,
         preferredStyle: UIAlertController.Style = .alert,
         headerView: UIView? = nil,
         height: CGFloat  = 375 ) {
        self.alertController = UIAlertController(title: title,
                                                 message: message,
                                                 preferredStyle: preferredStyle)
        self.alertController.view.tintColor = UIColor.black

        if let header = headerView {
            self.alertController.view.addSubview(header)
            alertController.view.translatesAutoresizingMaskIntoConstraints = false
            alertController.view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }

    @discardableResult
    func addAction(_ action: UIAlertAction) -> MedUpAlert {
        alertController.addAction(action)
        return self
    }

    func addAction(title: String, _ handler: ((UIAlertAction) -> Void)? = nil) -> MedUpAlert {
        return self.addAction(title: title, style: .default, handler)
    }

    func addAction(title: String, style: UIAlertAction.Style,
                   _ handler: ((UIAlertAction) -> Void)? = nil) -> MedUpAlert {
        alertController.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }

    func showOn(viewController: UIViewController, sourceView: UIView? = nil) {
        viewController.present(alertController, animated: true, completion: nil)
    }
}

