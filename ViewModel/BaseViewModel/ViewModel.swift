//
//  ViewModel.swift
//  ViewModel
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift
import RxRelay
import Services

public struct ErrorModel {
    public let title: String
    public let message: String
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}

public protocol ViewModeling: AnyObject {
    var error: BehaviorRelay<ErrorModel?> { get }
    var isLoading: BehaviorRelay<Bool> { get }
}

public class ViewModel<Services>: ViewModeling where Services: CommonServices {
    public var disposeBag = DisposeBag()

    public let error = BehaviorRelay<ErrorModel?>(value: nil)
    public let isLoading = BehaviorRelay<Bool>(value: false)

    var services: Services

    public init(services: Services) {
        self.services = services
    }

    public func handleServiceError(error: Error?, showAlert: Bool = true) {
        isLoading.accept(false)
        guard let error = error as? MedUpError else { return }

        var message = ""
        switch error {
        case .internalError(let errorMessage):
            message = errorMessage
        case .networkError(let code, let errorMessage):
            message = errorMessage ?? code.message()
        case .unexpectedError(let errorMessage):
            message = errorMessage
        case .noData:
            message = "noData"
        }

        let model = ErrorModel(title: "Error", message: message)
        if showAlert {
            self.error.accept(model)
        }
    }

    public func viewDidLoad() {}
}

import Foundation

public protocol ICommonServices {
    var settingsService: IUserSettings { get set }
}

public class CommonServices: ICommonServices {
    public init(settingsService: IUserSettings = UserSettings.current) {
        self.settingsService = settingsService
    }
   public var settingsService: IUserSettings
}
