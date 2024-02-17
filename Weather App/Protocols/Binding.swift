//
//  Binding.swift
//  Weather App
//
//  Created by Nikita Shestakov on 03.02.2024.
//

import Foundation
import CoreLocation
/// *View* sends user actions to the *Controller*.
///
/// **Controller** conforms to this protocol
protocol ViewOutputProtocol: AnyObject {
    var itemsView: ControllerOutputProtocol? { get set }
    var itemsModel: ModelInputProtocol? { get set }
    
    var currentWeather: CurrentWeatherModel? { get set }
    var dailyWeather: DailyWeatherModel? { get set }
    var exactWeather: ExactWeatherModel? { get set }
    var geo: [PlaceType : String]? { get set }
    
    func currentLocationCoordinates()
}

/// *Controller* tells the *Model* what to do based on the input
///
/// **Model** conforms to this protocol
protocol ModelInputProtocol: AnyObject {
    var controller: ControllerInputProtocol? { get set }
    
    func getCurrentWeather(lattitude: CLLocationDegrees, longitude: CLLocationDegrees, group: DispatchGroup)
    func getDailyWeather(lattitude: CLLocationDegrees, longitude: CLLocationDegrees, group: DispatchGroup)
    func getExactWeather(lattitude: CLLocationDegrees, longitude: CLLocationDegrees, group: DispatchGroup)
    func getNameOfPlace(lattitude: CLLocationDegrees, longitude: CLLocationDegrees, group: DispatchGroup)

    
    

}

/// *Model* returns the result to the *Controller*
///
/// **Controller** conforms to this protocol
protocol ControllerInputProtocol: AnyObject {
    func onCurrentWeatherRetrieval(weather: CurrentWeatherModel)
    func onDailyWeatherRetrieval(weather: DailyWeatherModel)
    func onExactWeatherRetrieval(weather: ExactWeatherModel)
    func setGeodata(geo: [PlaceType : String])
}

/// *Controller* returns a UI-representable result to the *View*
///
/// **View** conforms to this protocol
protocol ControllerOutputProtocol: AnyObject {
    var controller: ViewOutputProtocol? { get set }
    
    func setupAllData()
    func reloadTable()
    func reloadCollection()
    func setupCurrentLocation()
}



//MARK: - DetailViewControllerProtocols

/// *View* sends user actions to the *Controller*.
///
/// **Controller** conforms to this protocol
protocol PreviewViewOutputProtocol: AnyObject {
    var itemsView: PreviewControllerOutputProtocol? { get set }
    var currentWeather: ExactWeatherModel? { get set }
}

/// *Controller* returns a UI-representable result to the *View*
///
/// **View** conforms to this protocol
protocol PreviewControllerOutputProtocol: AnyObject {
    var controller: PreviewViewOutputProtocol? { get set }
    
    func setupAllData(currentWeatherDetail: ExactWeatherModel, index: Int)
}
