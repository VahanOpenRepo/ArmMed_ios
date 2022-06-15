//
//  QuestionViewController.swift
//  MedUp
//
//  Created by Vahe Makaryan on 12.10.21.
//

import UIKit
import ViewModel

class QuestionViewController: ViewController<QuestionViewModel, PatientsCoordinator> {

    @IBOutlet weak var tableContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var minValueLabel: MedLabel!
    @IBOutlet weak var maxValueLabel: MedLabel!

    @IBOutlet weak var nextButton: MedLoadingButton!

    @IBOutlet weak var booleanConatinerView: UIView!
    @IBOutlet weak var booleanTitleLabel: MedLabel!
    @IBOutlet weak var booleanNoButton: MedLoadingButton!
    @IBOutlet weak var booleanYesButton: MedLoadingButton!

    private var viewType: QuestionViewType!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        viewModel.viewDidLoad()
    }

    func setupView(by type: QuestionViewType) {

        viewType = type

        switch type {
        case .boolean(title: let title):
            booleanTitleLabel.text = title

            booleanConatinerView.isHidden = false
            booleanYesButton.gradient(startColor: UIColor.gradientButtonStart, endColor: UIColor.gradientButtonEnd, gradientFillType: .horizontal)

            booleanNoButton.config(withButtonStyle: .whiteBordered)
            minValueLabel.isHidden = true
            maxValueLabel.isHidden = true
        case .dictioanary:
            tableView.register(SelectableTableViewCell.self)
            tableView.reloadData()

            tableContainerView.isHidden = false
            nextButton.gradient(startColor: UIColor.gradientButtonStart, endColor: UIColor.gradientButtonEnd, gradientFillType: .horizontal)
            minValueLabel.isHidden = true
            maxValueLabel.isHidden = true
        case .input(dataSource: _, range: let range):
            minValueLabel.text = range.minValue
            maxValueLabel.text = range.maxValue
            tableView.register(QuestionTableViewCell.self)
            tableView.reloadData()

            tableContainerView.isHidden = false
            nextButton.gradient(startColor: UIColor.gradientButtonStart, endColor: UIColor.gradientButtonEnd, gradientFillType: .horizontal)
        }
    }

    override func bindViewModel(viewModel: QuestionViewModel) {
        super.bindViewModel(viewModel: viewModel)

        viewModel.viewType.subscribe(onNext: { [weak self] viewType in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.setupView(by: viewType)
            }
        }).disposed(by: disposeBag)

        viewModel.fileUrl.subscribe(onNext: { [weak self] fileUrl in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.coordinator.back()
                if let urlString = fileUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
                   let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                }
            }
        }).disposed(by: disposeBag)
    }

    private func setupNavBar() {

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Chevron Right"), for: .normal)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }

    @objc private func backButtonAction() {
        coordinator.back()
    }

    @IBAction private func nextButtonAction() {
        if let questions = viewModel.nextButtonPressed() {
            coordinator.showQuestion(with: QuestionNavigationModel(questions: questions))
        }
    }

    @IBAction private func booleanYesButtonAction() {
        viewModel.textFieldDidEndEdithing(with: "1")
        if let questions = viewModel.nextButtonPressed() {
            coordinator.showQuestion(with: QuestionNavigationModel(questions: questions))
        }
    }

    @IBAction private func booleanNoButtonAction() {
        viewModel.textFieldDidEndEdithing(with: "0")
        if let questions = viewModel.nextButtonPressed() {
            coordinator.showQuestion(with: QuestionNavigationModel(questions: questions))
        }
    }
}

extension QuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch viewType {
        case .input(dataSource: let dataSource, range: _):
            return dataSource.count
        case .dictioanary(dataSource: let dataSource): return dataSource.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch viewType {
        case .input(dataSource: let dataSource, range: _):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell else { return UITableViewCell() }

            let item = dataSource[indexPath.row]
            cell.cellModel = item
            cell.delegate = self
            return cell
        case .dictioanary(dataSource: let dataSource):

            guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectableTableViewCell.identifier, for: indexPath) as? SelectableTableViewCell else { return UITableViewCell() }

            let item = dataSource[indexPath.row]
            cell.cellModel = item
            return cell

        default:
            return UITableViewCell()
        }
    }
}

extension QuestionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch viewType {
        case .dictioanary(dataSource: let source):

            if let selectedItem = source.filter({ $0.isSelected == true }).first {
                selectedItem.isSelected = false
            }
            let item = source[indexPath.row]
            item.isSelected = true
            viewModel.textFieldDidEndEdithing(with: item.code)
            if let cell = tableView.cellForRow(at: indexPath) as? SelectableTableViewCell {
                cell.cellModel = item
            }

            tableView.reloadData()
        default: break
        }
    }
}

extension QuestionViewController: QuestionTableViewCellDelegate {

    func questionDidFilled(with text: String?) {
        viewModel.textFieldDidEndEdithing(with: text)
    }
}
