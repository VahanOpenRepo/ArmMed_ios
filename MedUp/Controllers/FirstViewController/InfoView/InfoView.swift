//
//  InfoView.swift
//  UAE TRA
//
//  Created by Vahe Makaryan on 12/28/20.
//

import UIKit

final class InfoView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var infoTitleLabel: UILabel!
    @IBOutlet private weak var infoMessageLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        Bundle.main.loadNibNamed("InfoView", owner: self, options: nil)
        add(subview: contentView)
    }

    func configure(with infoViewModel: InfoViewModel) {
        infoTitleLabel.text = infoViewModel.title
        infoMessageLabel.text = infoViewModel.description
        imageView.image = infoViewModel.image
        imageView.isHidden = false
    }
    
}
