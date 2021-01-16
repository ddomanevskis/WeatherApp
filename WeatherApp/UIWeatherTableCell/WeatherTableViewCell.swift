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
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    // MARK: Function overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: CurrentWeatherMain) {
        self.minTempLabel.text = "\(model.temp_min)"
        self.maxTempLabel.text = "\(model.temp_max)"
        self.currentTempLabel.text = "\(model.temp)"
    }
    
}
