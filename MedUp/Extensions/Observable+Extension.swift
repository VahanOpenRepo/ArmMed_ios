//
//  Observable+Extension.swift
//  MedUp
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift

 extension ObservableType {
    public func bindOnMainThread(onNext: @escaping (Element) -> Void) -> Disposable {
        return self.observe(on: MainScheduler.instance).subscribe(onNext: onNext)
    }
}
