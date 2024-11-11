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
    
    @Published var weather: WeatherDataModel?
    @Published var weatherResponse: ResponseModel?
    @Published var errorMessage: String?
    
    typealias WeatherCompletion = (WeatherDataModel?, Error?) -> Void
    
    func fetchWeather(cityName: String, completion: @escaping (WeatherDataModel?, WeatherAppError?) -> Void) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        guard let url = URL(string: urlString) else {
            completion(nil, .customError(message: "Invalid URL"))
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil, .networkError)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 404 {
                    completion(nil, .wrongCityName)
                    return
                }
            }
            guard let data = data else {
                completion(nil, .unknownError)
                return
            }
            switch self.parseJSON(data) {
            case .success(let weatherData):
                if let iconUrl = URL(string: weatherData.icon) {
                    self.downloadImage(from: iconUrl) { image in
                        let updatedWeatherData = weatherData
                        completion(updatedWeatherData, nil)
                    }
                } else {
                    completion(weatherData, nil)
                }
            case .failure(let parseError):
                completion(nil, parseError)
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
    
    // MARK: Private
    private func parseJSON(_ weatherData: Data) -> Result<WeatherDataModel, WeatherAppError> {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ResponseModel.self, from: weatherData)
            let temp = decodedData.main.temp
            let name = decodedData.name
            let date = decodedData.dt
            let condition = decodedData.weather[0].description
            let imageData = decodedData.weather[0].icon
            let iconUrl = "\(iconURL)\(imageData)@2x.png"
            let weather = WeatherDataModel(cityName: name, temperature: temp, icon: iconUrl, description: condition, dt: date)
            return .success(weather)
        } catch {
            return .failure(.parsingError)
        }
    }
}
