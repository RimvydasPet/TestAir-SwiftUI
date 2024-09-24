//
//  NetworkingController.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-18.
//

import Foundation
import SwiftUI

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

class WeatherManager: ObservableObject {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=90101379686294c192bf23f64e88f73c&units=metric"
    let iconURL = "https://openweathermap.org/img/wn/"
    
    var delegate: WeatherManagerDelegate?
    @Published var weather: WeatherModel?
    @Published var errorMessage: String?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.didFailWithError(error: error!)
                return
            }
            if let safeData = data {
                if let weather = self.parseJSON(safeData) {
                    self.delegate?.didUpdateWeather(self, weather: weather)
                }
            }
        }
        task.resume()
    }
    
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ResponseModel.self, from: weatherData)
            let temp = decodedData.main.temp
            let name = decodedData.name
            let date = decodedData.dt
            let condition = decodedData.weather.first?.description ?? "No description"
            let iconData = decodedData.weather.first?.icon ?? "01d"
            let iconUrl = "\(iconURL)\(iconData)@2x.png"
            let weather = WeatherModel(cityName: name, temperature: temp, icon: iconUrl, description: condition, dt: date)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}