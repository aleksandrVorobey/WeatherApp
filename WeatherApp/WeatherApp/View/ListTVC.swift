//
//  ListTVC.swift
//  WeatherApp
//
//  Created by Александр Воробей on 18.03.2021.
//

import UIKit
import CoreLocation

class ListTVC: UITableViewController {
    
    var emptyCity = Weather()
    
    var citiesArray = [Weather]()
    
    let nameCitiesArray = ["Москва", /*"Петербург", "Пенза", "Уфа", "Новосибирск", "Челябинск", "Омск", "Екатеринбург", "Томск", "Сочи"*/]
    
    var networkWeatherManager = NetworkWeatherManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        addCities()
        
    }

    func addCities() {
        getCityWeather(citiesArray: self.nameCitiesArray) { (index, weather) in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitiesArray[index]
            //print(self.citiesArray)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citiesArray.count
    }

    var weather = Weather()
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell

        weather = citiesArray[indexPath.row]
        cell.configure(weather: weather)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        <#code#>
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let cityWeather = citiesArray[indexPath.row]
            let dstVC = segue.destination as! DetailVC
            dstVC.weatherModel = cityWeather
        }
    }
        
}
