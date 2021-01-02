//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dans Domanevskis on 02/01/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Connectors and variables
    @IBOutlet var weatherTable: UITableView!
    
    var model = [Weather]()
    
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
        weatherTable.delegate = self
        weatherTable.dataSource = self
    }


}

struct Weather {
    
}
