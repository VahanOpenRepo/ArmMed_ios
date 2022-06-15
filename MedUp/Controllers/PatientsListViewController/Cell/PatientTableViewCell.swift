//
//  PatientTableViewCell.swift
//  MedUp
//
//  Created by Vahe Makaryan on 25.09.21.
//

import UIKit
import ViewModel

class PatientTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var avatarView: AvatarView!

    @IBOutlet weak var fullNameLabel: MedLabel!

    @IBOutlet weak var birthdateLabel: MedLabel!

    @IBOutlet weak var birthdateValueLabel: MedLabel!

    @IBOutlet weak var typeLabel: MedLabel!

    @IBOutlet weak var visitModeLabel: MedLabel!

    @IBOutlet weak var visitDateLabel: MedLabel!

    @IBOutlet weak var timeRangeLabel: MedLabel!

    var viewModel: PatientCellModel? {
        didSet {
            configure(viewModel)
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        containerView.layer.cornerRadius = 20
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        avatarView.image = nil
        viewModel = nil
    }

    private func configure(_ viewModel: PatientCellModel?) {
        avatarView.url = viewModel?.imageURLString
        fullNameLabel.text = viewModel?.fullName
        birthdateValueLabel.text = viewModel?.birthdate
        visitModeLabel.text = viewModel?.visitModeText
        visitDateLabel.text = viewModel?.visitDateText
        timeRangeLabel.text = viewModel?.timeRangeText
    }
}
