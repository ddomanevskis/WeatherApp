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
}

struct CurrentWeather: Codable {
    let dt: Float
    let weather: Float
    let clouds: Float
    let wind: Float
    let visibility: Float
    let pop: Float
    let dt_txt: String
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
    let tamp_kf: Float
}

struct CityWeather: Codable {
    let id: Float
    let name: String
    let country: String
    let population: Float
    let timezone: Float
    let sunrise: Float
    let sunset: Float
}
