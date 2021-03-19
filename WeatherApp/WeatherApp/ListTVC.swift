//
//  ListTVC.swift
//  WeatherApp
//
//  Created by Александр Воробей on 18.03.2021.
//

import UIKit

class ListTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchWeather()
        
    }
    
    func fetchWeather() {
        let urlString = "https://api.weather.yandex.ru/v2/informers?lat=53.837981&lon=27.613161"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url, timeoutInterval: .infinity)
        request.addValue("90d6cf85-51c0-4f3e-848f-342c6e9519b4", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        } .resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    

    
    
}
