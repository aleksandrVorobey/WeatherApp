//
//  ListTVC.swift
//  WeatherApp
//
//  Created by Александр Воробей on 18.03.2021.
//

import UIKit
import CoreLocation

class ListTVC: UITableViewController {
    var weather = Weather()
    
    var emptyCity = Weather()
    
    var citiesArray = [Weather]()
    var filterCityArray = [Weather]()
    
    var nameCitiesArray = ["Москва", "Петербург", /*"Пенза", "Уфа", "Новосибирск", "Челябинск", "Омск", "Екатеринбург", "Томск", "Сочи"*/]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: nameCitiesArray.count)
        }
        addCities()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @IBAction func pressPlusButton(_ sender: Any) {
        alertPlusCity(name: "Город", placeholder: "Название города") { (city) in
            self.nameCitiesArray.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
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
        if isFiltering {
            return filterCityArray.count
        }
        return citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell

        if isFiltering {
            weather = filterCityArray[indexPath.row]
        } else {
            weather = citiesArray[indexPath.row]
        }
        cell.configure(weather: weather)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "удалить") { (_, _, completionHandler) in
            let editingRow = self.nameCitiesArray[indexPath.row]
            if let index = self.nameCitiesArray.firstIndex(of: editingRow) {
                
                if self.isFiltering {
                    self.filterCityArray.remove(at: index)
                } else {
                    self.citiesArray.remove(at: index)
                }
                tableView.reloadData()
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            if isFiltering {
                let filter = filterCityArray[indexPath.row]
                let dstVC = segue.destination as! DetailVC
                dstVC.weatherModel = filter
            } else {
                let cityWeather = citiesArray[indexPath.row]
                let dstVC = segue.destination as! DetailVC
                dstVC.weatherModel = cityWeather
            }
        }
    }
        
}

extension ListTVC: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentSearchText(_ searchText: String) {
        filterCityArray = citiesArray.filter({ (weather)  in
            weather.name.contains(searchText)
        })
        tableView.reloadData()
    }
    
}
