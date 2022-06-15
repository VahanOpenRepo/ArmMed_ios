//
//  AddVisitViewController.swift
//  MedUp
//
//  Created by Vahan Grigoryan on 4/10/22.
//

import UIKit
import ViewModel

class AddVisitViewController: ViewController<AddVisitViewModel, AddVisitCoordinator> {
    
    @IBOutlet weak var medicalInstituteTextField: UITextField!
    @IBOutlet weak var socialCardTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var startHourTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var endHourTextField: UITextField!
    @IBOutlet weak var visitReasonTextField: UITextField!
    @IBOutlet weak var visitTypeTextField: UITextField!
    @IBOutlet weak var financeTextField: UITextField!
    @IBOutlet weak var healthIssueTypeTextField: UITextField!
    @IBOutlet weak var healthIssueCaseTextField: UITextField!
    @IBOutlet weak var healthIssueStartDateTextField: UITextField!
    @IBOutlet weak var healthIssueStartTimeTextField: UITextField!
    @IBOutlet weak var caseNumberTextField: UITextField!
    @IBOutlet weak var patientNameTextfield: UITextField!
    @IBOutlet weak var patientSurnameTextField: UITextField!
    
    let dateFormatter: DateFormatter = DateFormatter()
    private var isTime: Bool = false
    private var selectedPickerRow: Int = 0
    var selectedTextField: UITextField?
    
    let picker: UIPickerView = UIPickerView()
    let datePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medicalInstituteTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        startDateTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        startHourTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        endDateTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        endHourTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        healthIssueStartDateTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        healthIssueStartTimeTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        visitReasonTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        financeTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        healthIssueTypeTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        healthIssueCaseTextField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))
        // Do any additional setup after loading the view.
        
        viewModel.onVisitAdded.subscribe(onNext: { [weak self] visitorName in
            guard let self = self else { return }
            DispatchQueue.main.sync {
                self.visitSuccessfullyEdded(name: visitorName)
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func doneButtonClicked(_ sender: UITextField) {
            //your code when clicked on done
        datePicker.datePickerMode = isTime ? .time : .date
        dateFormatter.dateFormat = isTime ? "HH:mm" : "yyyy-MM-dd"
        setDataToTextFieldFrom(datePicker: datePicker)
        setDataToTextFeild(row: selectedPickerRow)
    }

    private func addPickerTo(textField: UITextField) {
        
        textField.inputView = picker
        picker.delegate = self
        picker.dataSource = self
    }
    
    private func addDatePickerTo(textField: UITextField, isTime: Bool) {
       
        datePicker.addTarget(self, action: #selector(AddVisitViewController.datePickerValueChanged(_:)), for: .valueChanged)
        datePicker.preferredDatePickerStyle = .wheels
        selectedTextField?.inputView = datePicker
        // Set date format
        self.isTime = isTime
        datePicker.datePickerMode = isTime ? .time : .date
        dateFormatter.dateFormat = isTime ? "HH:mm" : "yyyy-MM-dd"
    }
    
    private func visitSuccessfullyEdded(name: String?) {
        let alert = UIAlertController(title: "Այցը հաջողությամբ գրանցվեց", message: "Այցելուի անունը \(name ?? "")", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Լավ", style: .default, handler: { [weak self] action in
            self?.coordinator.back()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addVisit(_ sender: UIButton) {
        viewModel.patientSocialCard = socialCardTextField.text
        viewModel.patientMobileNumber = phoneTextField.text
        viewModel.healthIssueCaseNumber = caseNumberTextField.text
        viewModel.addVisit()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
           
           // Apply date format
        
        //print("Selected value \(selectedDate)")
        setDataToTextFieldFrom(datePicker: sender)
       }
       
       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }
    
    func setDataToTextFieldFrom(datePicker: UIDatePicker) {
        let selectedDate: String = dateFormatter.string(from: datePicker.date)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let textField = selectedTextField else { return }
        switch textField {
        case startDateTextField:
            startDateTextField.text = selectedDate
            viewModel.visitStart = dateFormatter.string(from: datePicker.date)
        case endDateTextField:
            endDateTextField.text = selectedDate
            viewModel.visitEnd = dateFormatter.string(from: datePicker.date)
        case endHourTextField:
            endHourTextField.text = selectedDate
            viewModel.visitEnd = dateFormatter.string(from: datePicker.date)
        case startHourTextField:
            startHourTextField.text = selectedDate
            viewModel.visitStart = dateFormatter.string(from: datePicker.date)
        case healthIssueStartDateTextField:
            healthIssueStartDateTextField.text = selectedDate
            viewModel.healthIssueStartDate = dateFormatter.string(from: datePicker.date)
        case healthIssueStartTimeTextField:
            healthIssueStartTimeTextField.text = selectedDate
            viewModel.healthIssueStartDate = dateFormatter.string(from: datePicker.date)
        default: break
        }
    }
    
    func setDataToTextFeild(row: Int?) {
        let row = row ?? 0
        guard let textField = selectedTextField else { return }
        switch textField {
        case medicalInstituteTextField:
            medicalInstituteTextField.text = viewModel.medicalInstitutes?[row]
            viewModel.medicalInstitute = medicalInstituteTextField.text
        case visitReasonTextField:
            visitReasonTextField.text = viewModel.vizitReason[row]
            viewModel.reasonOfTheVisit = "\(row + 1)"
        case visitTypeTextField:
            visitTypeTextField.text = viewModel.vizitType[row]
            viewModel.visitType = "\(row + 1)"
        case financeTextField:
            financeTextField.text = viewModel.sourceOfFinance[row]
            viewModel.sourceOfFinancing = "\(row + 1)"
        case healthIssueTypeTextField:
            healthIssueTypeTextField.text = viewModel.healthIssueTypes[row].name
            viewModel.healthIssueType = viewModel.healthIssueTypes[row].key
        case healthIssueCaseTextField:
            healthIssueCaseTextField.text = viewModel.healthIssueCase[row]
            viewModel.healthIssueCaseType = "\(row + 1)"
        default: break
        }
    }
    
}

extension AddVisitViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let textField = selectedTextField else { return 0 }
        switch textField {
        case startDateTextField, endDateTextField, startHourTextField, endHourTextField, healthIssueStartDateTextField, healthIssueStartTimeTextField:
            return 0
        case medicalInstituteTextField:
            return viewModel.medicalInstitutes?.count ?? 0
        case visitReasonTextField:
            return viewModel.vizitReason.count
        case visitTypeTextField:
            return viewModel.vizitType.count
        case financeTextField:
            return viewModel.sourceOfFinance.count
        case healthIssueTypeTextField:
            return viewModel.healthIssueTypes.count
        case healthIssueCaseTextField:
            return viewModel.healthIssueCase.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let textField = selectedTextField else { return "" }
        switch textField {
        case medicalInstituteTextField:
            return viewModel.medicalInstitutes?[row]
        case visitReasonTextField:
            return viewModel.vizitReason[row]
        case visitTypeTextField:
            return viewModel.vizitType[row]
        case financeTextField:
            return viewModel.sourceOfFinance[row]
        case healthIssueTypeTextField:
            return viewModel.healthIssueTypes.map({ $0.name })[row]
        case healthIssueCaseTextField:
            return viewModel.healthIssueCase[row]
        default: return ""
        }
      }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         selectedPickerRow = row
         setDataToTextFeild(row: row)
    }
}

extension AddVisitViewController: UITextFieldDelegate {
    
    internal func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        selectedTextField = textField
        switch textField {
        case startDateTextField, endDateTextField, healthIssueStartDateTextField:
            addDatePickerTo(textField: textField, isTime: false)
        case startHourTextField, endHourTextField, healthIssueStartTimeTextField:
            addDatePickerTo(textField: textField, isTime: true)
        case medicalInstituteTextField, visitReasonTextField, visitTypeTextField, financeTextField, healthIssueTypeTextField, healthIssueCaseTextField:
            addPickerTo(textField: textField)
        default: break
        }
        return true
    }
}
