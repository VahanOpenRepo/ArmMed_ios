//
//  QuestionTableViewCell.swift
//  MedUp
//
//  Created by Vahe Makaryan on 12.10.21.
//

import UIKit
import ViewModel

protocol QuestionTableViewCellDelegate: AnyObject {
    func questionDidFilled(with text: String?)
}

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var textField: UITextField!

    private let datepicker = UIDatePicker()

    weak var delegate: QuestionTableViewCellDelegate?

    var cellModel: QuestionCellModel? {
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

    private func configure(_ cellModel: QuestionCellModel?) {
        titleLabel.text = cellModel?.titleText

        switch cellModel?.textFieldType {
        case .text: textField.keyboardType = .default
        case .number: textField.keyboardType = .decimalPad
        case .date:
            setupPickerView(with: textField, pickerType: .date)
        case .datetime:
            setupPickerView(with: textField, pickerType: .dateAndTime)
        case .time: textField.keyboardType = .default
            setupPickerView(with: textField, pickerType: .time)
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

        guard let type = cellModel?.textFieldType else { return }

        delegate?.questionDidFilled(with: sender.date.string(format: type.format))
        textField.text = sender.date.string(format: type.formatUI)
    }

    @objc func hideKeyboard() {

        textField.resignFirstResponder()
    }
}

extension QuestionTableViewCell: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        delegate?.questionDidFilled(with: textField.text)

        return true
    }
}
