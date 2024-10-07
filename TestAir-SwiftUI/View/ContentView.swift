//
//  ContentView.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-16.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var weatherModel: WeatherModel?
    @StateObject var weatherManager = WeatherManager()
    @State private var errorMessage: String? = nil

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 75)
                    
                    HStack {
                        Button(action: {
                            weatherManager.fetchWeather(cityName: inputText) { (weather, error) in
                                if let error = error {
                                    self.errorMessage = error.localizedDescription
                                } else if let weather = weather {
                                    self.weatherModel = weather
                                }
                            }
                        }) {
                            TextField("Enter city name", text: $inputText)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            NavigationLink(destination: CurrentWeather(viewModel: weatherModel ?? WeatherModel(cityName: "Kaunas", temperature: 0.0, icon: "cloud", description: "sunny", dt: 0.0))) {
                                Text("Go")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: 60, maxHeight: 50)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                }
                .frame(maxHeight: .infinity)
                
                NavigationLink(destination: HistoryView()) {
                    Text("History")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 120)
                .padding(.bottom, 30)
            }
            .navigationBarHidden(true)
            .background(
                Image("light_background")
                    .resizable()
                    .scaledToFill()
            )
            .ignoresSafeArea()
        }
    }
}



////MARK: - Preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
