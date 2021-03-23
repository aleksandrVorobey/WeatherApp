//
//  GetCitiesWeather.swift
//  WeatherApp
//
//  Created by Александр Воробей on 22.03.2021.
//

import Foundation
import CoreLocation

let networkWeatherManager = NetworkWeatherManager()
let listTVC = ListTVC()

func getCityWeather(citiesArray: [String], completionHandler: @escaping(Int, Weather) -> Void) {
    for (index, item) in citiesArray.enumerated() {
        getCoordinateFrom(city: item) { (coordinate, error) in
            guard let coordinate = coordinate, error == nil else { return }

            networkWeatherManager.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
                completionHandler(index, weather)
            }
        }
    }
}


func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
    //определение местополодения по названию города
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        completion(placemark?.first?.location?.coordinate, error)
    }
}
