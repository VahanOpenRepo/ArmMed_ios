//
//  PatientDetailsViewController.swift
//  MedUp
//
//  Created by Vahe Makaryan on 25.09.21.
//

import UIKit
import ViewModel

class PatientDetailsViewController: ViewController<PatientDetailsViewModel, PatientsCoordinator> {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewContainerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var titleLabel: MedLabel!
    @IBOutlet weak var secoundaryLabel: MedLabel!
    @IBOutlet weak var timeLabel: MedLabel!
    @IBOutlet weak var dateLabel: MedLabel!

    @IBOutlet weak var nextButton: MedLoadingButton!

    var dataSource = [PatientDetailCellModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavBar()
        nextButton.config(withButtonStyle: .filledActive)
        viewModel.viewDidLoad()
    }

    override func bindViewModel(viewModel: PatientDetailsViewModel) {
        super.bindViewModel(viewModel: viewModel)

        viewModel.patientDetailViewModel.subscribe(onNext: { [weak self] patientDetailViewModel in
            guard let self = self else { return }
            self.setupUI(with: patientDetailViewModel)

        }).disposed(by: disposeBag)
    }

    private func setupUI(with patientDetailViewModel: PatientDetailViewModel) {
        avatarView.url = patientDetailViewModel.imageUrl
        titleLabel.text = patientDetailViewModel.fullName
        secoundaryLabel.text = "Վերջին թարմացում"
        timeLabel.text = patientDetailViewModel.lastUpdateTime
        dateLabel.text = patientDetailViewModel.lastUpdateDate

        dataSource = patientDetailViewModel.cellModels
        tableView.reloadData()
    }

    private func setupTableView() {
        tableView.register(PatientDetailTableViewCell.self)
        view.backgroundColor = .white
        tableViewContainerView.layer.cornerRadius = 20
        containerView.backgroundColor = .bgColor
    }

    private func setupNavBar() {
        title = "Մանրամասներ"
        addBackItem()
    }
    
    private func addBackItem() {

        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        button.setTitle(" Հետ", for: .normal)
        button.setTitleColor(.medBlue, for: .normal)
        button.tintColor = .medBlue
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }

    @objc private func backButtonAction() {
        coordinator.back()
    }

    @IBAction func nextButtonAction(_ sender: MedLoadingButton) {
        coordinator.showQuestion(with: QuestionNavigationModel(questions: viewModel.initialQuestions))
    }
}

extension PatientDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatientDetailTableViewCell.identifier, for: indexPath) as? PatientDetailTableViewCell else { return UITableViewCell() }
        let model = dataSource[indexPath.row]
        cell.cellModel = model

        return cell
    }
}
