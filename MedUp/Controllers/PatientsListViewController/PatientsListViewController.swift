//
//  PatientsListViewController.swift
//  MedUp
//
//  Created by Vahe Makaryan on 25.09.21.
//

import UIKit
import ViewModel

class PatientsListViewController: ViewController<PatientsListViewModel, PatientsCoordinator> {

    @IBOutlet weak var tableView: UITableView!

    private var activityIndicator: LoadMoreActivityIndicator?

    var dataSource: [PatientCellModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.viewDidLoad()
    }

    override func bindViewModel(viewModel: PatientsListViewModel) {
        super.bindViewModel(viewModel: viewModel)

        viewModel.patients.subscribe(onNext: { [weak self] dataSource in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator?.stop()
                self.dataSource = dataSource
                self.tableView.reloadData()

            }
        }).disposed(by: disposeBag)
    }

    private func setupUI() {
        setupNavBar()
        tableView.register(PatientTableViewCell.self)
        tableView.contentInset = UIEdgeInsets(top: 17, left: 0, bottom: 40, right: 0)
        tableView.backgroundColor = UIColor.bgColor
        view.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
        activityIndicator = LoadMoreActivityIndicator(scrollView: tableView, spacingFromLastCell: 12, spacingFromLastCellWhenLoadMoreActionStart: 16)
    }

    private func setupNavBar() {
        title = "Հիվանդներ"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        addSearchBarItem()
    }

    private func addSearchBarItem() {

        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "search_icon"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }

    @objc private func searchButtonAction() {
        coordinator.showPatientFilter { [weak self] requestModel in
            guard let self = self else { return }
            self.viewModel.filterRequestModel = requestModel
        }
    }
    
    @IBAction func addVisitPressed(_ sender: UIButton) {
        coordinator.showAddVisit(myInformation: viewModel.myInformation)
    }
    
    deinit {
        print("Patient Deinit")
    }
}

extension PatientsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatientTableViewCell.identifier, for: indexPath) as? PatientTableViewCell else { return UITableViewCell() }
        let model = dataSource?[indexPath.row]
        cell.viewModel = model

        return cell
    }
}

extension PatientsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource?[indexPath.row],
              let navigationModel = viewModel.getNavigationModel(cellItem: item) else { return }

        coordinator.showPatientDetails(with: navigationModel)
    }
}

extension PatientsListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        activityIndicator?.start { [weak self] in
            guard let self = self else { return }
            self.viewModel.loadMoreItems()
        }
    }
}
