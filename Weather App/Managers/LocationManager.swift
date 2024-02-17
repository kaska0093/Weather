//
//  LocationManager.swift
//  Weather App
//
//  Created by Nikita Shestakov on 03.02.2024.
//

import Foundation
import CoreLocation
//Privacy - Location When In Use Usage Description -> Info.plist

private let location = Location()

final class Location {
    
    class var shared: Location {
        return location
    }
    
    var localManager = CLLocationManager()

    func startLocationManager() {
        localManager.requestWhenInUseAuthorization()
        localManager.desiredAccuracy = kCLLocationAccuracyKilometer
        //localManager.pausesLocationUpdatesAutomatically = false
        localManager.startUpdatingLocation()

    }
}

enum CoordinatesType: Error {
    case lattitude
    case longitude
}
