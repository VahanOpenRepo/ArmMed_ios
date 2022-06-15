//
//  AvatarView.swift
//  MedUp
//
//  Created by Vahe Makaryan on 24.09.21.
//

import UIKit
import Services

final class AvatarView: UIView {

    // MARK: - Private Properties
    private var avatarImageView: UIImageView!

    // MARK: - Public Properties
    public var image: UIImage? {
        didSet {
            createAvatarImageViewIfNeeded()
            avatarImageView.image = image ?? UIImage(named: "avatar_default")
        }
    }

    public var url: String? {
        didSet {
            if let urlString = url {
                createAvatarImageViewIfNeeded()
                ImageLoader.loadImage(from: urlString, into: avatarImageView, placeholder: UIImage(named: "avatar_default"))
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        createAvatarImageViewIfNeeded()
    }

    // MARK: - Private functions

    private func createAvatarImageViewIfNeeded() {
        if avatarImageView == nil {
            avatarImageView = UIImageView(frame: bounds)
            avatarImageView.layer.cornerRadius = frame.width/2
            avatarImageView.contentMode = .scaleAspectFill
            avatarImageView.clipsToBounds = true
            avatarImageView.image = UIImage(named: "avatar_default")
            avatarImageView.isUserInteractionEnabled = false
            addSubview(avatarImageView)
        }
    }
}
