//
//  ProfileViewModel.swift
//  ViewModel
//
//  Created by Vahan Grigoryan on 7/27/21.
//

import Foundation
import Services
import RxSwift
import RxRelay
import Shared

public class ProfileInputServices: CommonServices {

    public init() {}
}

public typealias MProfileViewModel = ViewModel<ProfileInputServices>

public class ProfileViewModel: MProfileViewModel {
    
    public var user = PublishSubject<ProfileViewData>()

    var profileNavigationModel: ProfileNavigationModel

    public init(services: ProfileInputServices,
                profileNavigationModel: ProfileNavigationModel) {
        self.profileNavigationModel = profileNavigationModel
        super.init(services: services)
    }

    public override func viewDidLoad() {
        guard let user = profileNavigationModel.user else { return }

        let title = (user.firstName ?? "") + " " + (user.lastname ?? "")
        let avatarURL: String? = nil
        var dataSource = [PatientDetailCellModel]()

        if let date = user.date, !date.isEmpty {
            dataSource.append(PatientDetailCellModel(titleText: "Ծննդ. ամսաթիվ", valueText: date))
        }

        if let mobileNumber = user.mobileNumber, !mobileNumber.isEmpty {
            dataSource.append(PatientDetailCellModel(titleText: "Հեռ. համար", valueText: mobileNumber))
        }

        if let email = user.email, !email.isEmpty {
            dataSource.append(PatientDetailCellModel(titleText: "Էլ. հասցե", valueText: email))
        }

        if let socialCard = user.socialCard, !socialCard.isEmpty {
            dataSource.append(PatientDetailCellModel(titleText: "ՀԾՀ", valueText: socialCard))
        }

        let profileViewData = ProfileViewData(avatarURL: avatarURL,
                                              title: title,
                                              dataSource: dataSource)
        self.user.onNext(profileViewData)
    }
}
