//
//  AddVisitViewModel.swift
//  ViewModel
//
//  Created by Vahan Grigoryan on 4/10/22.
//

import Foundation
import Services
import RxSwift
import RxRelay

public class AddVisitInputServices: CommonServices {
    
    let addVisitService: AddVisitService = Services.get()
    let getOrganizationService: GetOrganizationService = Services.get()
    
    public init() {}
}

public typealias MAddVisitViewModel = ViewModel<AddVisitInputServices>

public class AddVisitViewModel: MAddVisitViewModel {
    
    public let vizitType = ["Անձնական ներկայություն", "Հեռախոսազանգ", "Հեռահար կոնսուլտացիա", "Հեռաբժշկություն", "Տնային այց"]
    public let vizitReason = ["Հիվանդություն", "Վերահսկողական", "Վարչական", "Այլ", "Վերարտադրողական", "Կանխարգելիչ", "Խորհրդատվական այց", "Հերթական այց", "Ցավային համախտանիշ", "Գեղագիտական", "Ֆունկցիոնալ", "Շուրջօրյա հսկողություն պահանջող", "Շուրջօրյա հսկողություն չպահանջող", "Ցերեկային ստացիոնար", "Փորձաքննություն"]
    public let sourceOfFinance = ["Վճարովի", "Ապահովագրություն(Սոց. Փաթեթ)", "Պետպատվեր", "Ապահովագրություն"]
    public let healthIssueTypes = [(key: "regular_checkup", name: "Uիստեմատիկ ստուգումներ"), (key: "control_case", name: "Վերահսկողական"), (key: "administrative_case", name: "Վարչական"), (key: "preventive_case", name: "Կանխարգելիչ"), (key: "reproductive_case", name: "Վերարտադրողական"), (key: "symptom", name: "Ախտանշան"), (key: "coded_symptom", name: "Կոդավորված ախտանշան"), (key: "symptom_correction", name: "Ախտանիշի ճշգրտում"), (key: "preliminary", name: "Նախնական ախտորաշում"), (key: "final", name: "Վերջնական ախտորոշում"), (key: "correction", name: "Ճշգրտված ախտորոշում"), (key: "coded_adverse_reaction", name: "Կոդավորված կողմնակի ազդեցություն"), (key: "adverse reaction", name: "Կողմնակի ազդեցություն"), (key: "coded_allergy", name: "Կոդավորված ալերգիա"), (key: "allergy", name: "Ալերգիա")]
    public let healthIssueCase = ["Ամբուլատոր", "Հիվանդանոցային", "Ստոմատոլոգիա", "Հղիի հսկում", "Կցագրում", "Շտապ օգնության կանչ"]

    public var medicalInstitutes: [String]? {
        return navigationModel?.myInformation?.map({ $0.name })
    }
    
    let navigationModel: AddVisitNavigationModel?
    
    public var onVisitAdded = PublishSubject<String?>()
    
    public var medicalInstitute: String? {
        didSet {
            getOrganization()
        }
    }
    
    public var patientSocialCard: String?
    public var patientMobileNumber: String?
    public var visitStart: String?
    public var visitEnd: String?
    public var visitType: String?
    public var reasonOfTheVisit: String?
    public var sourceOfFinancing: String?
    public var healthIssueType: String?
    public var healthIssueCaseType: String?
    public var healthIssueStartDate: String?
    public var healthIssueCaseNumber: String?
    public var doctors: String?
    public var doctorUuid: String?
    public var doctorSocialCard: String?
    public var departmentUuid: String?
    public var patientEmail: String?
    public var patientLastNameEN: String?
    public var patientFirstNameEN: String?
    
    private var roleUuid: String? {
        return navigationModel?.myInformation?.first(where: { $0.name == medicalInstitute })?.role_uuid
    }
    
    public init(services: AddVisitInputServices, navigationModel: AddVisitNavigationModel) {
        self.navigationModel = navigationModel
        super.init(services: services)
    }
    
    public override func viewDidLoad() {

    }
    
    public func addVisit() {
        //guard let roleUuid = roleUuid else { return }
        let params = AddVisitParameter(role_uuid: roleUuid,
                                       patient_social_card: patientSocialCard,
                                       patient_mobile_number: patientMobileNumber,
                                       visit_start: visitStart,
                                       visit_end: visitEnd,
                                       visit_type: visitType,
                                       reason_of_the_visit: reasonOfTheVisit,
                                       source_of_financing: sourceOfFinancing,
                                       health_issue_type: healthIssueType,
                                       health_issue_case_type: healthIssueCaseType,
                                       health_issue_start_date: healthIssueStartDate,
                                       health_issue_case_number: healthIssueCaseNumber,
                                       patient_email: patientEmail,
                                       patient_last_name_EN: patientLastNameEN,
                                       patient_first_name_EN: patientFirstNameEN)
        self.isLoading.accept(true)
        services.addVisitService.fetch(params: params).subscribe(onSuccess: { [weak self] response in
            guard let self = self else { return }
            self.isLoading.accept(false)
            self.onVisitAdded.onNext(response.result?.first_name)
        }, onFailure: { [weak self] error in
            guard let self = self else { return }
            self.isLoading.accept(false)
            //self.handleServiceError(error: error)
        }).disposed(by: disposeBag)
    }
    
    private func getOrganization() {
        guard let roleUuid = roleUuid else { return }
        let params = GetOrganizationParameter(role_uuid: roleUuid)
//        services.getOrganizationService.fetch(params: params).subscribe(onSuccess: { [weak self] response in
//            guard let self = self else { return }
//            self.isLoading.accept(false)
//
//        }, onFailure: { [weak self] error in
//            guard let self = self else { rmeturn }
//            //self.handleServiceError(error: error)
//        }).disposed(by: disposeBag)
    }
}
