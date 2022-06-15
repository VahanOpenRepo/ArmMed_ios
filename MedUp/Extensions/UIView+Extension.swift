//
//  UIView+Extension.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import UIKit

extension UIView {
    func add(subview: UIView,
             with boards: UIEdgeInsets = UIEdgeInsets.zero,
             onLayoutGuide: Bool = false) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subview)

        let topAnchor = onLayoutGuide ? self.layoutMarginsGuide.topAnchor : self.topAnchor
        NSLayoutConstraint.activate([
            subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: boards.left),
            subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -boards.right),
            subview.topAnchor.constraint(equalTo: topAnchor, constant: boards.top),
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -boards.bottom)
        ])
    }

    func insert(subview: UIView, atIndex: Int = 0, with boards: UIEdgeInsets = UIEdgeInsets.zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(subview, at: atIndex)

        NSLayoutConstraint.activate([
            subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -boards.left),
            subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: boards.right),
            subview.topAnchor.constraint(equalTo: self.topAnchor, constant: boards.top),
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -boards.bottom)
            ])
    }
    
    func gradient(startColor: UIColor, endColor: UIColor, gradientFillType: GradientFillType) {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        var startPoint: CGPoint?
        var endPoint: CGPoint?
        switch gradientFillType {
        case .vertical:
            startPoint = CGPoint(x: 0.5, y: 0.0)
            endPoint = CGPoint(x: 0.5, y: 1.0)
        case .horizontal:
            startPoint = CGPoint(x: 0.0, y: 1.0)
            endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        gradient.startPoint = startPoint!
        gradient.endPoint = endPoint!
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)

        layer.insertSublayer(gradient, at: 0)
    }
    
    func setShadow(shadowOpacity: Float = 0.1, shadowOffset: CGSize = CGSize(width: 2, height: 2), shadowRadius: CGFloat? = nil, shadowColor: UIColor = UIColor.gray, cornerRadius: CGFloat = 15) {
        
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius ?? layer.cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
    }
}

enum GradientFillType {
    case vertical
    case horizontal
}
