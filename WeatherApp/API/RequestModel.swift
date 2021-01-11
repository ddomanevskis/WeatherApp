//
//  RequestModel.swift
//  WeatherApp
//
//  Created by Dans Domanevskis on 02/01/2021.
//

import Foundation

struct Weather: Codable {
    let cod: String
    let message: String
    let cnt: Float
    let list: CurrentWeather
    let city: CityWeather
}

struct CurrentWeather: Codable {
    let dt: Float
    let main: CurrentWeatherMain
    let weather: WeatherWeather
    let clouds: CurrentClouds
    let wind: CurrentWind
    let visibility: Float
    let pop: Float
    let sys: CurrentSys
    let dt_txt: String
}

struct CurrentClouds: Codable {
    let all: Float
}

struct CurrentWind: Codable {
    let speed: Float
    let deg: Float
}

struct CurrentSys: Codable {
    let pod: String
}

struct WeatherWeather: Codable {
    let id: Float
    let main: String
    let description: String
    let icon: String
}

struct CurrentWeatherMain: Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Float
    let sea_level: Float
    let grnd_level: Float
    let humidity: Float
    let temp_kf: Float
}

struct CityWeather: Codable {
    let id: Float
    let name: String
    let coord: CityCoord
    let country: String
    let population: Float
    let timezone: Float
    let sunrise: Float
    let sunset: Float
}

struct CityCoord: Codable {
    let lat: Float
    let lon: Float
}
