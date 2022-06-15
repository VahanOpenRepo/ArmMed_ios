//
//  PatientDetailTableViewCell.swift
//  MedUp
//
//  Created by Vahe Makaryan on 10.10.21.
//

import UIKit
import ViewModel

class PatientDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: MedLabel!

    @IBOutlet weak var valueLabel: MedLabel!

    var cellModel: PatientDetailCellModel? {
        didSet {
            configure(with: cellModel)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellModel = nil
    }

    private func configure(with cellModel: PatientDetailCellModel?) {
        titleLabel.text = cellModel?.titleText
        valueLabel.text = cellModel?.valueText
    }
}
