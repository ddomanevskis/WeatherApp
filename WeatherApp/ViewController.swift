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
    
    var model = [CurrentWeather]()
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: model[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
        
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else {
                print("Sorry, something went wrong. Please try again later..")
                return
            }
            
            var json: Weather?
            do {
                json = try JSONDecoder().decode(Weather.self, from: data)
            }
            catch {
                print("Error: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            let entry = result.list
            
            self.model.append(contentsOf: entry)
            
            DispatchQueue.main.async {
                self.weatherTable.reloadData()
                
                self.weatherTable.tableHeaderView = self.createTableHeader()
            }
            
        }).resume()
    }
    
    func createTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        let requestTimeLabel = UILabel(frame: CGRect(x: 10, y: 20 + locationLabel.frame.size.height, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        
        headerView.addSubview(locationLabel)
        headerView.addSubview(requestTimeLabel)
        
        locationLabel.textAlignment = .center
        requestTimeLabel.textAlignment = .center
        
        locationLabel.text = "Riga"
        requestTimeLabel.text = "17 January"
        
        return headerView
    }
}
