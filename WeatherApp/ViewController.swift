//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dans Domanevskis on 02/01/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //MARK: Connectors, properties and variables
    @IBOutlet var weatherTable: UITableView!
    
    var model = [Weather]()
    
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
    
    //MARK: TableView Controllers
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    //MARK: Function overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registering the cell
        weatherTable.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        weatherTable.delegate = self
        weatherTable.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationInit()
    }
    
    // MARK: - Get weather for user location
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
