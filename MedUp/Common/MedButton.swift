//
//  MedButton.swift
//  MedUp
//
//  Created by Vahan Grigoryan on 6/5/21.
//

import Foundation


import UIKit

public enum MedButtonStyle {

    case filledActive
    case empty
    case inactive
    case white
    case whiteBordered

    var backgroundColor: UIColor {
        switch self {
        case .filledActive:
            return UIColor.blue
        case .empty:
            return UIColor.clear
        case .inactive:
            return UIColor.black
        case .white:
            return UIColor.white
        case .whiteBordered:
            return UIColor.white
        }
    }

    var titleColor: UIColor {
        switch self {
        case .filledActive:
            return .white
        case .empty:
            return BasicColors().medBlue
        case .inactive:
            return UIColor.gray
        case .white:
            return BasicColors().medBlue
        case .whiteBordered:
            return BasicColors().medBlue
        }
    }

    var font: UIFont {
        switch self {
        case .filledActive, .inactive:
            return BasicFonts().medMedium
        case .empty:
            return BasicFonts().medMedium
        case .white:
            return BasicFonts().medMedium
        case .whiteBordered:
            return BasicFonts().medMedium
        }
    }

    var cornerRadius: CGFloat? {
        switch self {
        case .filledActive, .inactive:
            return 28
        case .empty: return nil
        case .white, .whiteBordered: return 28
        }
    }

    var borderWith: CGFloat {
        switch self {
        case .whiteBordered: return 1
        default: return 0
        }
    }

    var borderColor: CGColor {
        switch self {
        case .whiteBordered: return BasicColors().medBlue.cgColor
        default: return UIColor.clear.cgColor
        }
    }
}



extension MedButtonStyle {

    var activityIndicatorColor: UIColor {
        switch self {
        case .filledActive, .inactive:
            return UIColor.white
        case .empty:
            return UIColor.gray
        case .white, .whiteBordered:
            return BasicColors().medBlue
        }
    }
}

public class MedLoadingButton: MedButtonStylable {

    public var isLoading = false {
        didSet {
            loadIndicator(isLoading)
        }
    }

    private var activityIndicator: UIActivityIndicatorView!

    private func loadIndicator(_ shouldShow: Bool) {
        if shouldShow {
            if activityIndicator == nil {
                activityIndicator = createActivityIndicator()
            }
            self.isEnabled = false
            self.setTitleColor(.clear, for: .disabled)
            showSpinning()
        } else {
            self.isEnabled = true
            setTitleColor(self.buttonStyle.titleColor, for: .normal)
            activityIndicator?.stopAnimating()
        }
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = buttonStyle.activityIndicatorColor
        return activityIndicator
    }

    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        positionActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }

    private func positionActivityIndicatorInButton() {
        let trailingConstraint = NSLayoutConstraint(item: self,
                                                    attribute: .centerX,
                                                    relatedBy: .equal,
                                                    toItem: activityIndicator,
                                                    attribute: .centerX,
                                                    multiplier: 1, constant: 0)
        self.addConstraint(trailingConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}


public class MedButtonStylable: UIButton {
        
    private let imageTitleSpace: CGFloat = -19
    
    internal var buttonStyle: MedButtonStyle = .filledActive {
        didSet {
            self.setUpUI()
        }
    }
    
    private var imageName: String? {
        didSet {
            guard let name = imageName else { return }
            setImage(UIImage.init(named: name)?.withRenderingMode(.alwaysOriginal), for: .normal)
            imageView?.contentMode = .scaleAspectFit
            // set spasing when there is a title and image
            semanticContentAttribute = .forceRightToLeft
            imageEdgeInsets.right = buttonTitle != nil ? imageTitleSpace : 0
        }
    }
    private var buttonTitle: String? {
        didSet {
            setTitle(buttonTitle, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUpUI()
    }
    
    public func config(withButtonStyle style: MedButtonStyle,
                       title: String? = nil,
                       imageName: String? = nil) {
        self.buttonStyle = style
        if let title = title { self.buttonTitle = title }
        self.isUserInteractionEnabled = style != .inactive
        self.imageName = imageName
        self.setButtonStyle(style: style)
    }

    public func setButtonStyle(style: MedButtonStyle) {
        self.isUserInteractionEnabled = style != .inactive
        self.buttonStyle = style
        gradientForStyle()
    }

    private func setUpUI() {
        setTitleColor(buttonStyle.titleColor, for: .normal)
      //  titleLabel?.font = buttonStyle.font
        backgroundColor = buttonStyle.backgroundColor
        layer.cornerRadius = buttonStyle.cornerRadius ?? 0
        layer.masksToBounds = true
        layer.borderColor = buttonStyle.borderColor
        layer.borderWidth = buttonStyle.borderWith
    }
    
    func gradientForStyle() {
        if buttonStyle == .filledActive {
            gradient()
        }
    }
    
    func gradient() {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor.gradientButtonStart.cgColor, UIColor.gradientButtonEnd.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)

        layer.insertSublayer(gradient, at: 0)
    }
    
   
}
