//
//  APIManager.swift
//  WeatherApp
//
//  Created by Dans Domanevskis on 02/01/2021.
//

import Foundation
import CoreLocation

struct Location {
    
    //MARK: Connectors, properties and variables
    var userCoordinates: CLLocation?
    
    //MARK: Request location
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
