//
//  NetworkingController.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-18.
//

import Foundation
import SwiftUI

class WeatherManager: ObservableObject {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=90101379686294c192bf23f64e88f73c&units=metric"
    let iconURL = "https://openweathermap.org/img/wn/"
    
    @Published var weather: WeatherModel?
    @Published var weatherResponse: ResponseModel?
    @Published var errorMessage: String?
    
    typealias WeatherCompletion = (WeatherModel?, Error?) -> Void
    
    func fetchWeather(cityName: String, completion: @escaping (WeatherCompletion)) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let error = error else {
                    if let safeData = data {
                        if let weatherData = self.parseJSON(safeData) {
                            completion(weatherData, nil)
                        }
                    }
                    return
                }
                completion(nil, error)
            }
            task.resume()
        }
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
    
    // MARK: Private
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ResponseModel.self, from: weatherData)
            let temp = decodedData.main.temp
            let name = decodedData.name
            let date = decodedData.dt
            let condition = decodedData.weather[0].description
            let imageData = decodedData.weather[0].icon
            let iconUrl = "\(iconURL)\(imageData)@2x.png"
            let weather = WeatherModel(cityName: name, temperature: temp, icon: iconUrl, description: condition, dt: date)
            return weather
        } catch {
            print("Parsing failed")
            return nil
        }
    }
}
