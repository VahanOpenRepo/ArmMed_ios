//
//  FilterDetailTableViewCell.swift
//  MedUp
//
//  Created by Vahe Makaryan on 20.11.21.
//

import UIKit
import ViewModel

protocol FilterDetailTableViewCellDelegate: AnyObject {
    func textDidFilled(with text: String?)
}

class FilterDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!

    private let datepicker = UIDatePicker()

    weak var delegate: FilterDetailTableViewCellDelegate?

    var cellModel: FilterDetailsCellModel? {
        didSet {
            configure(cellModel)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellModel = nil
        delegate = nil
    }

    private func configure(_ cellModel: FilterDetailsCellModel?) {
        textField.text = cellModel?.value
        textField.placeholder = cellModel?.placeholder
        switch cellModel?.keyboardType {
        case .date: setupPickerView(with: textField, pickerType: .date)
        default: textField.keyboardType = .default
        }
    }

    private func setupPickerView(with textField: UITextField = UITextField(), pickerType: UIDatePicker.Mode) {

        datepicker.datePickerMode = pickerType
        if #available(iOS 13.4, *) {
            datepicker.preferredDatePickerStyle = .wheels
        }
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.calendar = calendar

        datepicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        textField.inputView = datepicker

        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Հաստատել", style: .done, target: self, action: #selector(self.hideKeyboard))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }

    @objc func dateChanged(_ sender: UIDatePicker) {

        textField.text = sender.date.string(format: .yyyy_mm_dd_mid_line)
        cellModel?.value = sender.date.string(format: .yyyy_mm_dd_mid_line)
    }

    @objc func hideKeyboard() {

        textField.resignFirstResponder()
    }
}

extension FilterDetailTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text
        cellModel?.value = textField.text
    }
}
