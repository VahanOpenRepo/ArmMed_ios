//
//  FilterViewController.swift
//  MedUp
//
//  Created by Vahe Makaryan on 17.11.21.
//


import UIKit
import ViewModel

class FilterViewController: ViewController<FilterViewModel, FilterCoordinator> {

    @IBOutlet weak var tableView: UITableView!

    var dataSource: [FilterCellModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.viewDidLoad()
    }

    override func bindViewModel(viewModel: FilterViewModel) {
        super.bindViewModel(viewModel: viewModel)

        viewModel.filters.subscribe(onNext: { [weak self] dataSource in
            guard let self = self else { return }
                self.dataSource = dataSource
                self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }

    private func setupUI() {
        setupNavBar()
        tableView.register(FilterTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 40, right: 0)
        view.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.bgColor
    }

    private func setupNavBar() {
        title = "Որոնել Ըստ"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        addBackItem()
    }

    private func addBackItem() {

        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close_icon"), for: .normal)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        button.setTitle(" Չեղարկել", for: .normal)
        button.adjustsImageWhenHighlighted = false
        button.setTitleColor(.medBlue, for: .normal)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }

    @objc private func backButtonAction() {
        if let searchResult = coordinator.searchResult {
            searchResult(nil)
        }
        coordinator.closeFilter()
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as? FilterTableViewCell else { return UITableViewCell() }
        let model = dataSource?[indexPath.row]
        cell.cellModel = model

        return cell
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource?[indexPath.row] else { return }
        let navigationModel = viewModel.getNavigationModel(cellItem: item)
        coordinator.showPatientFilterDetails(navigationModel: navigationModel)
    }
}
