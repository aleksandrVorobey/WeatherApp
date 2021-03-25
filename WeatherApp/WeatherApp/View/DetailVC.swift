//
//  DetailVC.swift
//  WeatherApp
//
//  Created by Александр Воробей on 24.03.2021.
//

import UIKit
import SwiftSVG

class DetailVC: UIViewController {

    @IBOutlet weak var nameCityLabel: UILabel!
    @IBOutlet weak var viewCity: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tempCity: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var weatherModel: Weather?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       refreshLables()
    }
    
    func refreshLables() {
        nameCityLabel.text = weatherModel?.name
        
        let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weatherModel!.conditionCodeIcon).svg")
        let weatherImage = UIView(SVGURL: url!) { image in
            image.resizeToFit(self.viewCity.bounds)
        }
        viewCity.addSubview(weatherImage)
        
        conditionLabel.text = weatherModel?.conditionString
        tempCity.text = "\(weatherModel?.temperature ?? 0)"
        pressureLabel.text = "\(weatherModel?.pressureMm ?? 0)"
        windSpeedLabel.text = "\(weatherModel?.windSpeed ?? 0)"
        minTempLabel.text = "\(weatherModel?.tempMin ?? 0)"
        maxTempLabel.text = "\(weatherModel?.tempMax ?? 0)"
        
    }
   
}
