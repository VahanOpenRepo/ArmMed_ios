//
//  ImageLoader.swift
//  Services
//
//  Created by Vahe Makaryan on 25.09.21.
//

import Foundation
import UIKit
import SDWebImage

public protocol ImageLoadable {
    static func loadImage(from url: String?, into imageView: UIImageView, placeholder: UIImage?)
    static func loadImage(from url: String?, into imageView: UIImageView)
}

public class ImageLoader: ImageLoadable {
    public static func loadImage(from url: String?, into imageView: UIImageView, placeholder: UIImage?) {

        if let urlString = url, let imageUrl = URL(string: urlString) {
            imageView.sd_setImage(with: imageUrl, placeholderImage: placeholder)
        } else {
            imageView.image = placeholder
        }
    }

    public static func loadImage(from url: String?, into imageView: UIImageView) {
        ImageLoader.loadImage(from: url, into: imageView,placeholder: nil)
    }
}
