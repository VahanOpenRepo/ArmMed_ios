//
//  ViewModelTests.swift
//  ViewModelTests
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import XCTest
import RxSwift
import ProjectMock
@testable import Services
@testable import ViewModel

class ViewModelBaseXCTestCase: XCTestCase {

    override func setUp() {
        super.setUp()
        Services.deleteAll()

    }

    override func tearDown() {
        Services.deleteAll()
    }
}
