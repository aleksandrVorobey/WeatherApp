//
//  ListCell.swift
//  WeatherApp
//
//  Created by Александр Воробей on 24.03.2021.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var conditionCityLabel: UILabel!
    @IBOutlet weak var tempCityLabel: UILabel!
    

    func configure(weather: Weather) {
        nameCityLabel.text = weather.name
        conditionCityLabel.text = weather.conditionString
        tempCityLabel.text = "\(weather.temperature)"
    }
}
