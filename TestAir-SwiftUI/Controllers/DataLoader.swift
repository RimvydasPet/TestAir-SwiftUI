//
//  DataLoader.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-10-14.
//

import Foundation


class DataLoader: ObservableObject {
    
    @Published var weatherData: [WeatherDataModel] = []
    
    func loadWeatherData() {
        let sampleWeatherData = [
            WeatherDataModel(cityName: "New York", temperature: 72.0, icon: "https://openweathermap.org/img/wn/01n@2x.png", description: "Cloudy", dt: 1728933148),
            WeatherDataModel(cityName: "Los Angeles", temperature: 80.5, icon: "https://openweathermap.org/img/wn/04n@2x.png", description: "Sunny", dt: 1693573200),
            WeatherDataModel(cityName: "Chicago", temperature: 65.0, icon: "https://openweathermap.org/img/wn/10d@2x.png", description: "Rainy", dt: 1693573200),
            WeatherDataModel(cityName: "Miami", temperature: 85.2, icon: "https://openweathermap.org/img/wn/02d@2x.png", description: "Partly Cloudy", dt: 1693573200),
            WeatherDataModel(cityName: "Seattle", temperature: 60.0, icon: "https://openweathermap.org/img/wn/09d@2x.png", description: "Drizzle", dt: 1693573200),
            WeatherDataModel(cityName: "San Francisco", temperature: 68.4, icon: "https://openweathermap.org/img/wn/50d@2x.png", description: "Foggy", dt: 1693573200),
            WeatherDataModel(cityName: "Denver", temperature: 75.0, icon: "https://openweathermap.org/img/wn/01d@2x.png", description: "Clear", dt: 1693573200),
            WeatherDataModel(cityName: "Houston", temperature: 88.0, icon: "https://openweathermap.org/img/wn/03d@2x.png", description: "Overcast", dt: 1693573200),
            WeatherDataModel(cityName: "Boston", temperature: 67.0, icon: "https://openweathermap.org/img/wn/10n@2x.png", description: "Showers", dt: 1693573200),
            WeatherDataModel(cityName: "Phoenix", temperature: 100.5, icon: "https://openweathermap.org/img/wn/01d@2x.png", description: "Hot & Sunny", dt: 1693573200)
        ]
        
        DispatchQueue.main.async {
            self.weatherData = sampleWeatherData
        }
    }
}
