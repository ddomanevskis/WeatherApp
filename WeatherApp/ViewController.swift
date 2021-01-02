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
    
    var locationRequest = [Location]()
    
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
            locationRequest.requestWeatherAtLoc()
            
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


}
