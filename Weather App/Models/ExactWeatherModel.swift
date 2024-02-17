
//  ExactWeatherModel.swift
//  Weather App
//
//  Created by Nikita Shestakov on 04.02.2024.

import Foundation

// MARK: - ExactWeatherModel
struct ExactWeatherModel: Codable {
    let latitude: Double
    let longitude: Int
    let generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let hourly: Hourly

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case hourly
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let time: [String]
    let temperature2M, apparentTemperature, rain: [Double]
    let showers: [Int]
    let snowfall, snowDepth: [Double]
    let weatherCode: [Int]
    let surfacePressure: [Double]
    let cloudCover, visibility: [Int]
    let windSpeed10M: [Double]
    let windDirection10M: [Int]
    let windGusts10M, uvIndex: [Double]
    let isDay: [Int]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case apparentTemperature = "apparent_temperature"
        case rain, showers, snowfall
        case snowDepth = "snow_depth"
        case weatherCode = "weather_code"
        case surfacePressure = "surface_pressure"
        case cloudCover = "cloud_cover"
        case visibility
        case windSpeed10M = "wind_speed_10m"
        case windDirection10M = "wind_direction_10m"
        case windGusts10M = "wind_gusts_10m"
        case uvIndex = "uv_index"
        case isDay = "is_day"
    }
}
