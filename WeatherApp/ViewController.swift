//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dans Domanevskis on 02/01/2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    // UserDefaults for Timestamp
    let timeStamp = UserDefaults.standard
    
    //MARK: Connectors, properties and variables
    @IBOutlet var weatherTable: UITableView!
    
    @IBAction func getWeatherRequest(_ sender: Any) {
        getTimestamp()
        locationInit()
    }
    
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
    //MARK: Get timestamp
    func getTimestamp() {
        let time = NSDate.now
        let format = DateFormatter()
        format.dateFormat = "MM-dd-yyyy HH:mm"
        
        let formatString = format.string(from: time)
        timeStamp.set(formatString, forKey: "request")
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
        
        // draw previous time data
        loadSavedData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Get weather for user location
    private func requestWeatherAtLoc() {
        guard let testCoordinates = userCoordinates else {
            return
        }
        let longitude = testCoordinates.coordinate.longitude
        let latitude = testCoordinates.coordinate.latitude
        
        let apiKey = "e65c6d06ba5ce7b6c633678b56db8548"
        
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        
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
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self.model), forKey: "weather")
            
            DispatchQueue.main.async {
                self.weatherTable.reloadData()
                self.weatherTable.tableHeaderView = self.createTableHeader()
            }
            
        }).resume()
    }
    
    func createTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/5))
        
        let requestTimeLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width-20, height: headerView.frame.size.height/5))
        
        headerView.addSubview(requestTimeLabel)
        
        requestTimeLabel.textAlignment = .center
        
        requestTimeLabel.text = timeStamp.string(forKey: "request")
        
        return headerView
    }
    
    func loadSavedData() {
        
        self.weatherTable.tableHeaderView = createTableHeader()
        
        guard let weatherData = UserDefaults.standard.value(forKey: "weather") else {
            return
        }
        guard let savedModel = try? PropertyListDecoder().decode(Array<CurrentWeather>.self, from: weatherData as! Data) else {
            return
        }
        self.model.append(contentsOf: savedModel)
    }

}
