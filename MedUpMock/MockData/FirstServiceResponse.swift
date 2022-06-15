//
//  FirstServiceResponse.swift
//  MedUpMock
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import Services

extension WeatherResponse {
    public static func create() -> Self {
        Self(name: "San Francisco", weather: [Weather.create()],
             main: MainData.create(),
             wind: Wind.create(), sys: Sys.create())
    }
}
extension Weather {
    public static func create() -> Self {
        Self(id: 701, main: "mist", description: "mist")
    }
}

extension MainData {
    public static func create() -> Self {
       Self(temp: 9.51,
            pressure: 1025,
            humidity: 87,
            temp_min: 8.33,
            temp_max: 10.56)
    }
}

extension Wind {
    public static func create() -> Self {
        Self(speed: 2.58)
    }
}

extension Sys {
    public static func create() -> Self {
        Self(country: "US",
             sunrise: 1610033117,
             sunset: 1610067990)
    }
}
