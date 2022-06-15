//
//  LoaderView.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import UIKit
import RxRelay
import RxSwift

extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"

    func rotateAnimation(duration: Double = 2.0) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity
            rotationAnimation.isRemovedOnCompletion = false
            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }

    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}

final class LoaderView: UIView {
    private var referenceCount = BehaviorRelay(value: 0)
    private let loader = UIImageView(image: UIImage(named: "loader_icon"))
    private lazy var color: UIColor = .white
    private let disposeBag = DisposeBag()
    private weak var viewToShow: UIView?

    public init(viewToShow: UIView?) {
        super.init(frame: CGRect.zero)
        self.viewToShow = viewToShow
        setup()
        bind()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        loader.center = self.center
    }

    private func setup() {
        backgroundColor = self.color
        loader.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loader)
        loader.widthAnchor.constraint(equalToConstant: 40).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    private func bind() {
        referenceCount.subscribe(onNext: { [weak self] count  in
            if count > 0 {
                self?.startLoading()
            } else {
                self?.stopLoading()
            }
        }).disposed(by: disposeBag)
    }

    private func startLoading() {
        guard self.superview == nil, let view = self.viewToShow else { return }

        self.loader.backgroundColor = self.color
        self.frame = view.bounds
        view.add(subview: self)
        loader.rotateAnimation()
    }

    private func stopLoading() {
        self.removeFromSuperview()
        loader.stopAnimating()
    }

    func show() {
        referenceCount.accept(referenceCount.value + 1)
    }

    func hide() {
        referenceCount.accept(referenceCount.value - 1)
    }
}
