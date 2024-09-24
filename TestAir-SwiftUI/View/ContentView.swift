//
//  ContentView.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-16.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @StateObject var weatherManager = WeatherManager()
    @State private var weatherData: WeatherModel?

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
                        TextField("Enter city name", text: $inputText)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        Button(action: {
                            weatherManager.fetchWeather(cityName: inputText)
                        }) {
                            
                            NavigationLink(destination: CurrentWeather(weather: weatherManager.weather ?? WeatherModel(cityName: "Kaunas", temperature: 2.0, icon: "sunny", description: "not badnius", dt: 3.0))) {
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
