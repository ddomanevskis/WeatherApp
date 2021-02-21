//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Dans Domanevskis on 02/01/2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet var displayDayLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var currentTempLabel: UILabel!
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    
    //MARK: Variables
    static let identifier = "WeatherTableViewCell"
    let requestDate = Date()
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    // MARK: Function overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: CurrentWeather) {
        self.minTempLabel.text = "\(model.main.temp_min)°C"
        self.minTempLabel.textAlignment = .center
        self.maxTempLabel.text = "\(model.main.temp_max)°C"
        self.maxTempLabel.textAlignment = .center
        self.currentTempLabel.text = "\(model.main.temp)°C"
        self.currentTempLabel.textAlignment = .center
        
        self.displayDayLabel.text = dateFormat()
        
        self.weatherIcon.image = UIImage(systemName: "sun.min.full")
        self.weatherIcon.contentMode = .scaleAspectFit
    }
    
    func dateFormat() -> String {
        let format = DateFormatter()
        format.dateFormat = "EEEE"
        return format.string(from: requestDate)
    }
}
