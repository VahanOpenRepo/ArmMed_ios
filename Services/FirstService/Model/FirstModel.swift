//
//  FirstModel.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation

public struct WeatherResponse: Codable {
    public var name: String?
    public var weather: [Weather]?
    public var main: MainData?
    public var wind: Wind?
    public var sys: Sys?

    public init(name: String?,
                weather: [Weather]?,
                main: MainData?,
                wind: Wind?,
                sys: Sys?) {
        self.name = name
        self.weather = weather
        self.main = main
        self.wind = wind
        self.sys = sys
    }
}

public struct Weather: Codable {
    public var id: Int?
    public var main: String?
    public var description: String?

    public init(id: Int?,
         main: String?,
         description: String?) {
        self.id = id
        self.main = main
        self.description = description
    }
}

public struct MainData: Codable {
    public var temp: Double?
    public var pressure: Double?
    public var humidity: Double?
    public var temp_min: Double?
    public var temp_max: Double?

    public init(temp: Double?,
                pressure: Double?,
                humidity: Double?,
                temp_min: Double?,
                temp_max: Double?) {

        self.temp = temp
        self.pressure = pressure
        self.humidity = humidity
        self.temp_min = temp_min
        self.temp_max = temp_max
    }
}

public struct Wind: Codable {
    public var speed: Double?

    public init(speed: Double?) {
        self.speed = speed
    }
}

public struct Sys: Codable {
    public var country: String?
    public var sunrise: Double?
    public var sunset: Double?

    public init(country: String?,
                sunrise: Double?,
                sunset: Double?) {

        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}
