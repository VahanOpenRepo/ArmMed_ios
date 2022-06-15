//
//  MedView.swift
//  MedUp
//
//  Created by Vahe Makaryan on 24.09.21.
//

import UIKit

@IBDesignable class MedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        // The option to redisplay the view when the bounds change
        self.contentMode = .redraw
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        // The option to redisplay the view when the bounds change
        self.contentMode = .redraw
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        if !self.corners.isEmpty {
            if self.corners.contains(.allCorners) {
                self.layer.cornerRadius = self.cornerRadius
                self.layer.masksToBounds = true
            } else {
                drawCorners()
            }
        }
    }

    enum CornerState {
        case topLeft
        case topRight
        case bottomRight
        case bottomLeft
        case allCorners
    }
    var corners = UIRectCorner()
    let borderLayer = CAShapeLayer()


    func setCorners(_ corner: CornerState) {

        switch corner {
        case .topLeft: corners.insert(.topLeft)
        case .topRight: corners.insert(.topRight)
        case .bottomLeft: corners.insert(.bottomLeft)
        case .bottomRight: corners.insert(.bottomRight)
        case .allCorners: corners.insert(.allCorners)
        }
    }

    func drawCorners()  {
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: self.corners,
                                    cornerRadii: CGSize(width: self.cornerRadius, height: self.cornerRadius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.drawCorners()
    }

    @IBInspectable var cornerRadius: CGFloat = 20.0 {
        didSet {
            if !self.topLeftCornerRadius &&
                !self.topRightCornerRadius &&
                !self.bottomLeftCornerRadius &&
                !self.bottomRightCornerRadius {

                setCorners(.allCorners)
                drawCorners()
            }
        }
    }
    @IBInspectable var topLeftCornerRadius: Bool = false {
        didSet {
            if self.corners.contains(.allCorners)  {
                self.corners.remove(.allCorners)
            }
            if topLeftCornerRadius {
                setCorners(.topLeft)
            }
        }
    }

    @IBInspectable var topRightCornerRadius: Bool = false {
        didSet {
            if self.corners.contains(.allCorners) {
                self.corners.remove(.allCorners)
            }
            if topRightCornerRadius {
                setCorners(.topRight)
            }
        }
    }

    @IBInspectable var bottomRightCornerRadius: Bool = false {
        didSet {
            if self.corners.contains(.allCorners) {
                self.corners.remove(.allCorners)
            }
            if bottomRightCornerRadius {
                setCorners(.bottomRight)
            }
        }
    }

    @IBInspectable var bottomLeftCornerRadius: Bool = false {
        didSet {
            if self.corners.contains(.allCorners) {
                self.corners.remove(.allCorners)
            }
            if bottomLeftCornerRadius {
                setCorners(.bottomLeft)
            }
        }
    }
}
