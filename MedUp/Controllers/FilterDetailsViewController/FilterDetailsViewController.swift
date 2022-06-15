//
//  FilterDetailsViewController.swift
//  MedUp
//
//  Created by Vahe Makaryan on 18.11.21.
//

import UIKit
import ViewModel
import IQKeyboardManagerSwift

class FilterDetailsViewController: ViewController<FilterDetailsViewModel, FilterCoordinator> {

    @IBOutlet weak var tableView: UITableView!

    private var dataSource: [FilterDetailsCellModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.viewDidLoad()
    }

    override func bindViewModel(viewModel: FilterDetailsViewModel) {
        super.bindViewModel(viewModel: viewModel)

        viewModel.filterFields.subscribe(onNext: { [weak self] dataSource in
            guard let self = self else { return }
                self.dataSource = dataSource
                self.tableView.reloadData()
        }).disposed(by: disposeBag)

        viewModel.filterRequesModel.subscribe(onNext: { [weak self] filterRequesModel in
            guard let self = self else { return }

            if let searchResult = self.coordinator.searchResult {
                searchResult(filterRequesModel)
            }
            self.coordinator.closeFilter()
        }).disposed(by: disposeBag)
    }

    private func setupUI() {

        tableView.register(FilterDetailTableViewCell.self)
        tableView.backgroundColor = .bgColor
        view.backgroundColor = .bgColor
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 40, right: 0)
        addBackItem()
        addConfirmItem()
        title = "Որոնել"
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

    private func addConfirmItem() {

        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        button.setTitle("Հաստատել", for: .normal)
        button.setTitleColor(.medBlue, for: .normal)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }

    @objc private func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func confirmButtonAction() {
        viewModel.searchButtonPressed()
    }
}

extension FilterDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterDetailTableViewCell.identifier, for: indexPath) as? FilterDetailTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        let model = dataSource?[indexPath.row]
        cell.cellModel = model

        return cell
    }
}

extension FilterDetailsViewController: FilterDetailTableViewCellDelegate {
    func textDidFilled(with text: String?) {

    }
}

