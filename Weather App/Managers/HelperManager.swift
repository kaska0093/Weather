//
//  HelperManager.swift
//  Weather App
//
//  Created by Nikita Shestakov on 11.02.2024.
//

import Foundation


class HelperManager {
    
    func getWeekDay(time: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        
        var weekDay: String = ""
        if let date = dateFormatter.date(from: time) {
            dateFormatter.dateFormat = "E"
            weekDay = dateFormatter.string(from: date)
        }
        return weekDay
    }
    
    func getHour(time: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        var hour: String = ""
        if let date = dateFormatter.date(from: time) {
            dateFormatter.dateFormat = "HH"
            hour = dateFormatter.string(from: date)
        }
        return hour
    }
    
    func getHourAndMinutes(time: String) -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        var hour: String = ""
        if let date = dateFormatter.date(from: time) {
            dateFormatter.dateFormat = "HH:mm"
            hour = dateFormatter.string(from: date)
        }
        return hour
    }
    
    func getIconWeather(code: Int) -> String {
        
        var weatherIconName: String!
        switch code {
        case 0: weatherIconName = "d000"
        case 2: weatherIconName = "d100"
        case 3: weatherIconName = "d200"
            //Fog and depositing rime fog
        case 45: weatherIconName = "d600"
        case 48: weatherIconName = "d600"
            //Drizzle: Light, moderate, and dense intensity
        case 51: weatherIconName = "n410"
        case 53: weatherIconName = "n420"
        case 55: weatherIconName = "n4301"
            //Freezing Drizzle: Light and dense intensity
        case 56: weatherIconName = "d223"
        case 57: weatherIconName = "d223"
            
        case 61, 63, 65: weatherIconName = "d420"//   Rain: Slight, moderate and heavy intensity
        case  66, 67: weatherIconName = "d422" //    Freezing Rain: Light and heavy intensity
        case 71, 73, 75: weatherIconName = "d422" //    Snow fall: Slight, moderate, and heavy intensity
        case 77: weatherIconName = "d422" //    Snow grains
        case 80, 81, 82: weatherIconName = "d422" //    Rain showers: Slight, moderate, and violent
        case 85, 86: weatherIconName = "d422" //    Snow showers slight and heavy
        case 95 : weatherIconName = "d422" // *    Thunderstorm: Slight or moderate
        case 96, 99: weatherIconName = "d422" //case 96, 9: = "" //9 *    Thunderstorm with slight and heavy hail

        default:
            weatherIconName = "exclamationmark.square"
        }
        return weatherIconName
    }
    
    func getCurrentHour() -> Int {
        
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let formatteddate = formatter.string(from: time as Date)
        return Int(formatteddate) ?? 0
    }
    
}
