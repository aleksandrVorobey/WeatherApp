//
//  NetworkWeatherManager.swift
//  WeatherApp
//
//  Created by Александр Воробей on 19.03.2021.
//

import Foundation

struct NetworkWeatherManager {
    //completionHandler: @escaping(Weather) -> Void
    func fetchWeather(completionHandler: @escaping(Weather) -> Void) {
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
            //print(String(data: data, encoding: .utf8)!)
            if let weather = parseJSON(whisData: data) {
                print(weather)
                completionHandler(weather)
            }
        } .resume()
    }
    
    func parseJSON(whisData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else { return nil }
            return weather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
