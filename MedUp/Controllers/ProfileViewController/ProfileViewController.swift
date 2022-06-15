//
//  ProfileViewController.swift
//  MedUp
//
//  Created by Vahan Grigoryan on 7/27/21.
//

import Foundation
import UIKit
import ViewModel
import Services
import IQKeyboardManagerSwift

class ProfileViewController: ViewController<ProfileViewModel, ProfileCoordinator>, StoryboardInstantiable {

    @IBOutlet weak var avatarView: AvatarView!
    @IBOutlet weak var titleLabel: MedLabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewContainerView: UIView!
    @IBOutlet weak var containerView: UIView!

    var dataSource = [PatientDetailCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
        viewModel.viewDidLoad()
    }

    override func bindViewModel(viewModel: ProfileViewModel) {
        super.bindViewModel(viewModel: viewModel)
        viewModel.user.subscribe(onNext: { [weak self] user in
            guard let self = self else { return }
            self.configureUI(with: user)
        }).disposed(by: disposeBag)
    }

    private func setupTableView() {
        tableView.register(PatientDetailTableViewCell.self)
        view.backgroundColor = .white
        tableViewContainerView.layer.cornerRadius = 20
        containerView.backgroundColor = .bgColor
    }

    private func setupNavBar() {
        title = "Հաշիվ"
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        addBackItem()
    }

    private func addBackItem() {

        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "logout_icon"), for: .normal)
        button.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        button.tintColor = .medBlue
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
    }

    private func configureUI(with model: ProfileViewData) {
        titleLabel.text = model.title
        avatarView.url = model.avatarURL
        dataSource = model.dataSource ?? []
        tableView.reloadData()
    }

    @objc func logoutPressed() {
        coordinator.logout()
    }

    deinit {
        print("Deinit ProfileVC")
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatientDetailTableViewCell.identifier, for: indexPath) as? PatientDetailTableViewCell else { return UITableViewCell() }
        let model = dataSource[indexPath.row]
        cell.cellModel = model

        return cell
    }
}
