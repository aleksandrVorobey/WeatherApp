//
//  AddCity.swift
//  WeatherApp
//
//  Created by Александр Воробей on 25.03.2021.
//

import UIKit

extension UIViewController {
    func alertPlusCity(name: String, placeholder: String, completionHandler: @escaping(String) -> Void) {
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { (action) in
            let tfText = alertController.textFields?.first
            guard let text = tfText?.text else { return }
            completionHandler(text)
        }
        alertController.addTextField { (tf) in
            tf.placeholder = placeholder
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { (_) in }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
