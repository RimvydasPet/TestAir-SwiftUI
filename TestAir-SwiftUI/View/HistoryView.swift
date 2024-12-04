//
//  HistoryView.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-16.
//

import SwiftData
import SwiftUI

struct HistoryView: View {
    @Query(sort: \WeatherDataModel.dt, order: .reverse) var weatherDataModel: [WeatherDataModel]
    @Environment(\.modelContext) private var context
    @State private var contentSize: CGSize = .zero
    @State private var disable = true
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Image("light_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                if !weatherDataModel.isEmpty {
                    Button(action: clearAllWeatherData) {
                        Text("Clear History")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: 120)
                            .background(Color.brown)
                            .cornerRadius(10)
                    }
                    .padding(.leading, 200)
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(weatherDataModel.prefix(5)) { weather in
                            ZStack(alignment: .bottomLeading) {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.5))
                                    .frame(width: 300, height: 200)
                                
                                AsyncImage(url: URL(string: weather.icon))
                                    .frame(width: 40, height: 40)
                                    .padding(.bottom, 145)
                                    .padding(.leading, 15)
                                
                                Text(weather.describing)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .padding(.bottom, 160)
                                    .padding(.leading, 80)
                                    .frame(maxWidth: .infinity, alignment: .topLeading)
                                
                                Text(weather.formattedDate ?? "20.0")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .padding([.bottom, .trailing], 15)
                                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                                
                                Text(weather.cityName)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .padding([.bottom, .leading], 15)
                                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                                
                                Text("\(weather.temperatureString)°C")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            }
                            .frame(width: 300, height: 200)
                            
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .contentMargins(.vertical, 20, for: .scrollContent)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Database Cleared"),
                message: Text("All weather data has been successfully deleted."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func clearAllWeatherData() {
        for record in weatherDataModel {
            context.delete(record)
        }
        do {
            try context.save()
            showAlert = true
        } catch {
            print("Failed to clear weather data: \(error)")
        }
    }
}


////MARK: - Preview
//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleData = [
//            WeatherDataModel(cityName: "New York", temperature: 72.0, icon: "https://openweathermap.org/img/wn/01n@2x.png", description: "Cloudy", dt: 1728933148),
//            WeatherDataModel(cityName: "Los Angeles", temperature: 80.5, icon: "https://openweathermap.org/img/wn/04n@2x.png", description: "Sunny", dt: 1693573200),
//            WeatherDataModel(cityName: "Chicago", temperature: 65.0, icon: "https://openweathermap.org/img/wn/10d@2x.png", description: "Rainy", dt: 1693573200),
//            WeatherDataModel(cityName: "Miami", temperature: 85.2, icon: "https://openweathermap.org/img/wn/02d@2x.png", description: "Partly Cloudy", dt: 1693573200),
//            WeatherDataModel(cityName: "Seattle", temperature: 60.0, icon: "https://openweathermap.org/img/wn/09d@2x.png", description: "Drizzle", dt: 1693573200),
//            WeatherDataModel(cityName: "San Francisco", temperature: 68.4, icon: "https://openweathermap.org/img/wn/50d@2x.png", description: "Foggy", dt: 1693573200),
//            WeatherDataModel(cityName: "Denver", temperature: 75.0, icon: "https://openweathermap.org/img/wn/01d@2x.png", description: "Clear", dt: 1693573200),
//            WeatherDataModel(cityName: "Houston", temperature: 88.0, icon: "https://openweathermap.org/img/wn/03d@2x.png", description: "Overcast", dt: 1693573200),
//            WeatherDataModel(cityName: "Boston", temperature: 67.0, icon: "https://openweathermap.org/img/wn/10n@2x.png", description: "Showers", dt: 1693573200),
//            WeatherDataModel(cityName: "Phoenix", temperature: 100.5, icon: "https://openweathermap.org/img/wn/01d@2x.png", description: "Hot & Sunny", dt: 1693573200)
//                ]
//                
//                HistoryView(sampleData: sampleData)
//    }
//}
