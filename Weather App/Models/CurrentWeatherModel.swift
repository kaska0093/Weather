//
//  CurrentWeather.swift
//  Weather App
//
//  Created by Nikita Shestakov on 03.02.2024.
//

import Foundation

struct CurrentWeatherModel: Codable {
    var latitude: Double
    var longitude: Double
    var generationtime_ms: Double
    var utc_offset_seconds: Int
    var timezone: String
    var timezone_abbreviation: String
    var elevation: Int
    var current: Current
    
    struct Current: Codable {
        var time: String
        var interval: Int
        var temperature_2m: Double
        var relativehumidity_2m: Int
        var apparent_temperature: Double
        var is_day: Int
        var precipitation: Double
        var rain: Double
        var showers: Double
        var snowfall: Double
        var weathercode: Int
        var cloudcover: Int
        var pressure_msl: Double
        var surface_pressure: Double
        var windspeed_10m: Double
        var winddirection_10m: Int
        var windgusts_10m: Double
    }
}
