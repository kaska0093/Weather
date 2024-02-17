//
//  API_Manager_Current_Weather.swift
//  Weather App
//
//  Created by Nikita Shestakov on 03.02.2024.
//

import Foundation
import Alamofire

final class APIManager {
    //FIXME: - singletone is't the best way.....
    static let shared = APIManager()
    init() {}
    
    func getCurrentWeather(lat lattitude: Double,long longitude: Double,
                           complition: @escaping (Result<CurrentWeatherModel, Error>) -> Void) {
        
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(lattitude)&longitude=\(longitude)&current=temperature_2m,relativehumidity_2m,apparent_temperature,is_day,precipitation,rain,showers,snowfall,weathercode,cloudcover,pressure_msl,surface_pressure,windspeed_10m,winddirection_10m,windgusts_10m&windspeed_unit=ms&timezone=Europe%2FMoscow&forecast_days=14"
        
        guard let url = URL(string: urlString) else {return}
        
        DispatchQueue.global().async {
            
            AF.request(url).validate().response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        print(error)
                        complition(.failure(error))
                    }
                    return
                }
                
                let decoder = JSONDecoder()
                guard let results = try? decoder.decode(CurrentWeatherModel.self, from: data) else {
                    complition(.failure(NetworkingError.decoderError))
                    return
                }
                complition(.success(results))
            }
        }
    }
    
    func getExactlyWeather(lat lattitude: Double,long longitude: Double,
                           complition: @escaping(Result<ExactWeatherModel, Error>) -> ()) {

        let stringURL = "https://api.open-meteo.com/v1/forecast?latitude=\(lattitude)&longitude=\(longitude)&hourly=temperature_2m,apparent_temperature,rain,showers,snowfall,snow_depth,weather_code,surface_pressure,cloud_cover,visibility,wind_speed_10m,wind_direction_10m,wind_gusts_10m,uv_index,is_day&forecast_days=3"
        
        guard let url = URL(string: stringURL) else {
            complition(.failure(NetworkingError.badURL))
            return
        }
        
        let URLrequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: URLrequest) { data, response, error in
            guard let data else {
                if let error {
                    complition(.failure(error))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(ExactWeatherModel.self, from: data)
                complition(.success(weatherData))
            } catch {
                complition(.failure(NetworkingError.decoderError))
            }
        }.resume()
    }
    
    func getDaylyWeather(lat lattitude: Double,
                         long longitude: Double) async throws -> DailyWeatherModel {
        
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(lattitude)&longitude=\(longitude)&daily=weathercode,temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,sunrise,sunset,uv_index_max,windspeed_10m_max&windspeed_unit=ms&timezone=Europe%2FMoscow&forecast_days=14"

        guard let url = URL(string: urlString) else {
            throw NetworkingError.badURL
        }
        
        let response = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let result = try decoder.decode(DailyWeatherModel.self, from: response.0)
        return result
    }
}

//MARK: - NetworkingError
enum NetworkingError: Error {
    case badURL
    case decoderError
}
