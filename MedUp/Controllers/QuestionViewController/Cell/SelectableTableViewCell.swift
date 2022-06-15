//
//  SelectableTableViewCell.swift
//  MedUp
//
//  Created by Vahe Makaryan on 18.10.21.
//

import UIKit
import ViewModel

class SelectableTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: MedLabel!

    @IBOutlet weak var radioImageView: UIImageView!

    var cellModel: SelectableCellModel? {
        didSet {
            configure(with: cellModel)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellModel = nil
    }

    private func configure(with cellModel: SelectableCellModel? = nil) {
        titleLabel.text = cellModel?.titleText
        let imageName = cellModel?.isSelected == true ? "icon_radio_selected" : "icon_radio"
        radioImageView.image = UIImage(named: imageName)
    }
}
