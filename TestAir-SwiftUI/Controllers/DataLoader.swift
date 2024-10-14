//
//  DataLoader.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-10-14.
//

import Foundation


class DataLoader: ObservableObject {
    @Published var weatherData: [WeatherModel] = []

    func loadWeatherData() {
        // Simulated data; replace this with actual API requests as needed
        let sampleWeatherData = [
            WeatherModel(cityName: "New York", temperature: 72.0, icon: "https://openweathermap.org/img/wn/01n@2x.png", description: "Cloudy", dt: 1728933148),
            WeatherModel(cityName: "Los Angeles", temperature: 80.5, icon: "https://openweathermap.org/img/wn/04n@2x.png", description: "Sunny", dt: 1693573200),
            WeatherModel(cityName: "Chicago", temperature: 65.0, icon: "https://openweathermap.org/img/wn/10d@2x.png", description: "Rainy", dt: 1693573200)
        ]

        DispatchQueue.main.async {
            self.weatherData = sampleWeatherData
        }
    }
}
