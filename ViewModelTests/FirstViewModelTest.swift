//
//  FirstViewModelTest.swift
//  ViewModelTests
//
//  Created by Hrant on 09.05.21.
//

import XCTest
import RxSwift
import RxRelay
import Shared
import ProjectMock
import CoreLocation
@testable import Services
@testable import ViewModel

class FirstViewModelTest: ViewModelBaseXCTestCase, IUnitFormatter {
    var sut: FirstViewModel!
    let firstMockServiceMock = FirstServiceMock()
    let secondMockService = SecondServiceMock()

    override func setUp() {
        super.setUp()
        Services.register(service: firstMockServiceMock)
        Services.register(service: secondMockService)
        sut = FirstViewModel(services: FirstServiceInputServices(), firstNavigationModel: FirstNavigationModel())
        firstMockServiceMock.valueToReturn = WeatherResponse.create()
    }

    func testFirst() {
        let disposeBag = DisposeBag()
        let expectation = XCTestExpectation(description: "Can't get Weather")
        sut.fetchData(by: "")
        let data = sut.weatherDataModel
        sut.isDataLoaded.subscribe(onNext: {  _ in
            XCTAssertEqual(data.cityName, "San Francisco")
            XCTAssertEqual(data.humidity, 87)
            XCTAssertEqual(data.maxTemperature, 10.56)
            XCTAssertEqual(data.minTemperature, 8.33 )
            XCTAssertEqual(data.temperature, 9.51)
            expectation.fulfill()
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 2)
    }

    func testIUnitFormatter() {
        let disposeBag = DisposeBag()
        let expectation = XCTestExpectation(description: "Can't get Weather")
        sut.fetchData(by: "")
        let data = sut.weatherDataModel
        sut.isDataLoaded.subscribe(onNext: { [unowned self] _ in
            XCTAssertEqual(self.formattedTemperature(for: data.temperature), "10 °")
            XCTAssertEqual(self.formattedSunRiseAndSunset(for: data.temperature), "04:00 AM")
            XCTAssertEqual(self.formattedWind(for: data.windSpeed), "3 m/s")
            XCTAssertEqual(self.formattedHumidity(for: data.humidity), "87 %")
            expectation.fulfill()
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 2)
    }

    override func tearDown() {
        super.tearDown()
    }
}
