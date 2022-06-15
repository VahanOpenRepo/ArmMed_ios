//
//  ViewController.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import UIKit
import Foundation
import ViewModel
import RxSwift

protocol Coordinated: AnyObject {
    associatedtype Coordinator
    var coordinator: Coordinator! { get set }
}

protocol Coordinator: AnyObject {
    func start()
    func back()
    func backToRoot()
}

class ViewController<T: ViewModeling, C: Coordinator>: UIViewController, Coordinated {
    var viewModel: T!
    unowned var coordinator: C!
    lazy var loaderView = LoaderView(viewToShow: view)
    lazy var disposeBag = DisposeBag()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel(viewModel: viewModel)
        bindLoader(viewModel: viewModel)
        bindError(viewModel: viewModel)
    }

    public func bindViewModel(viewModel: T) {}

    private func bindError(viewModel: T) {
        viewModel
            .error
            .filter { $0 != nil }
            .bindOnMainThread { [unowned self] errorModel in
                self.handleError(errorModel: errorModel)
            }.disposed(by: disposeBag)
    }

    private func bindLoader(viewModel: T) {
        viewModel
            .isLoading
            .skip(1)
            .bindOnMainThread {[unowned self] isLoading in
                self.handleLoading(isLoading: isLoading)
            }
            .disposed(by: disposeBag)
    }

    private func handleLoading(isLoading: Bool) {
        if isLoading {
            loaderView.show()
        } else {
            loaderView.hide()
        }
    }

    private func handleError(errorModel: ErrorModel?) {
        guard let errorModel = errorModel else { return }
        let alert = MedUpAlert(title: errorModel.title,
                                 message: errorModel.message).addAction(title: "Ok")
        alert.showOn(viewController: self)
        self.handleError()
    }

    public func handleError() {}

}
