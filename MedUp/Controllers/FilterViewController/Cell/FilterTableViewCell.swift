//
//  FilterTableViewCell.swift
//  MedUp
//
//  Created by Vahe Makaryan on 17.11.21.
//

import UIKit
import ViewModel

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var titleLabel: MedLabel!

    @IBOutlet weak var arrowImageView: UIImageView!

    var cellModel: FilterCellModel? {
        didSet {
            configure(cellModel: cellModel)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        containerView.layer.cornerRadius = 10
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configure()
    }

    private func configure(cellModel: FilterCellModel? = nil) {
        titleLabel.text = cellModel?.title
    }
    
}
