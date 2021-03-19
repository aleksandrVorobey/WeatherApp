//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Александр Воробей on 19.03.2021.
//

import Foundation

struct NetworkWeatherManager {
    func fetchWeather() {
        let urlString = "https://api.weather.yandex.ru/v2/informers?lat=53.837981&lon=27.613161"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url, timeoutInterval: .infinity)
        request.addValue(apiKey, forHTTPHeaderField: forHTTPHeaderField)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            print(String(data: data, encoding: .utf8)!)
        } .resume()
    }
}
