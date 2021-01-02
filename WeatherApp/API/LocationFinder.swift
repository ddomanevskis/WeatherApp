//
//  LocationFinder.swift
//  WeatherApp
//
//  Created by Dans Domanevskis on 02/01/2021.
//

import Foundation
import CoreLocation

struct LocationFinder: CLLocationManagerDelegate {
    
    let manageLocation = CLLocationManager()
    
    var userCoordinates: CLLocation?
    
    //MARK: User Location Logic
    private func locationInit() {
        manageLocation.delegate = self
        manageLocation.requestWhenInUseAuthorization()
        manageLocation.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, userCoordinates == nil {
            userCoordinates = locations.first
            manageLocation.stopUpdatingLocation()
            requestWeatherAtLoc()
        }
    }
    
    private func requestWeatherAtLoc() {
        guard let testCoordinates = userCoordinates else {
            return
        }
        let longitude = testCoordinates.coordinate.longitude
        let latitude = testCoordinates.coordinate.latitude
        
        let apiKey = "e65c6d06ba5ce7b6c633678b56db8548"
        
        let url = "api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                print("Sorry, something went wrong. Please try again later..")
                return
            }
        })
    }
    
}
