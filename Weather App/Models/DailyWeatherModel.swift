//
//  DailyWeatherModel.swift
//  Weather App
//
//  Created by Nikita Shestakov on 04.02.2024.
//

import Foundation

struct DailyWeatherModel: Decodable {
    var latitude: Double
    var longitude: Double
    var generationtime_ms: Double
    var utc_offset_seconds: Int
    var timezone: String
    var timezone_abbreviation: String
    var elevation: Int
    var daily: Daily

    struct Daily: Decodable {
        var time: [String]
        var weathercode: [Int]
        var temperature_2m_max: [Double]
        var temperature_2m_min: [Double]
        var apparent_temperature_max: [Double]
        var apparent_temperature_min: [Double]
        var sunrise: [String]
        var sunset: [String]
        var uv_index_max: [Double]
        var windspeed_10m_max: [Double]
    }
}
