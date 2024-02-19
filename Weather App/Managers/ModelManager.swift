//
//  CurrentWeatherModel.swift
//  Weather App
//
//  Created by Nikita Shestakov on 03.02.2024.
//

import Foundation
import IIDadata

final class ModelManager {
    
    private var items: [CurrentWeatherModel]?
    var controller: ControllerInputProtocol?
}

enum PlaceType: Error {
    case region
    case city
    case street
}

extension ModelManager: ModelInputProtocol {

    
    
    func getNameOfPlace(lattitude: Double, longitude: Double, group: DispatchGroup) {

        var dadata: DadataSuggestions?
        dadata = DadataSuggestions(apiKey: "eefa57d957e4282174bff8e66dab0dfdaa48ea41")
     
        dadata?.reverseGeocode(latitude: lattitude,
                               longitude: longitude,
                               resultsCount: 1,
                               language: .ru,
                               searchRadius: 1000){ [self] result in
            let allData = try? result.get()

            if let data = allData?.suggestions, data.count > 0 {
                
                if let region = data[0].data?.regionWithType ,  let city = data[0].data?.cityWithType, let street = data[0].data?.streetWithType  {
            
                    self.controller?.setGeodata(geo: [PlaceType.region : region,
                                                      PlaceType.city : city ,
                                                      PlaceType.street : street ])
                    group.leave()
                }
            } else {
                print("reverseGeocode error")
                group.leave()
            }
        }
    }
    
    
    func getDailyWeather(lattitude: Double, longitude: Double, group: DispatchGroup) {
        
        Task {
            do {
                let result = try await APIManager.shared.getDaylyWeather(lat: lattitude, long: longitude)
                controller?.onDailyWeatherRetrieval(weather: result)
                group.leave()
            } catch {
                print(error.localizedDescription)
                group.leave()
            }
        }
    }
    
    func getExactWeather(lattitude: Double, longitude: Double, group: DispatchGroup) {

        APIManager.shared.getExactlyWeather(lat: lattitude, long: longitude) { [self] result in
            
            switch result {
            case .failure(let error):
                print(error)
                group.leave()
            case .success(let currentWeatherData):
                let data = currentWeatherData
                controller?.onExactWeatherRetrieval(weather: data)
                group.leave()
            }
        }
    }
    
    
    func getCurrentWeather(lattitude: Double, longitude: Double, group: DispatchGroup) {
        
        DispatchQueue.global().async {
            APIManager.shared.getCurrentWeather(lat: lattitude, long: longitude) { [self] result in
                switch result {
                case .failure(let error):
                    print(error)
                    group.leave()
                case .success(let currentWeatherData):
                    let data = currentWeatherData
                    controller?.onCurrentWeatherRetrieval(weather: data)
                    group.leave()
                }
            }
        }
    }  
}
