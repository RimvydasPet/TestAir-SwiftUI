//
//  ContentView.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-16.
//

import SwiftUI
import SwiftData

enum WeatherAppError: LocalizedError {
    case networkError
    case parsingError
    case unknownError
    case wrongCityName
    case emptyCityName
    case cityDublicated
    case customError(message: String)
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network error occurred. Please check your internet connection."
        case .parsingError:
            return "Failed to parse the weather data."
        case .unknownError:
            return "An unknown error occurred."
        case .wrongCityName:
            return "Please enter a valid city name."
        case .emptyCityName:
            return "Please enter city name."
        case .cityDublicated:
            return "City already exist. Please enter another city name."
        case .customError(let message):
            return message
        }
    }
}

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var weatherModel: WeatherDataModel?
    @StateObject var weatherManager = WeatherManager()
    @State private var errorMessage: String? = nil
    @State private var isEditing: Bool = false
    @State private var isNavigating: Bool = false
    @State private var showAlert = false
    @State private var recordLimit = 7
    @Environment(\.modelContext) private var context
    
    var body: some View {
        NavigationStack {
        ZStack {
            Image("light_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
           
                VStack {
                    Spacer()
                    VStack {
                        Image("Logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 75)
                        HStack {
                            TextField("Enter city name", text: $inputText, onEditingChanged: { editing in
                                self.isEditing = editing
                            })
                            .toolbar {
                                ToolbarItem(placement: .keyboard) {
                                    Button("Done") {
                                        hideKeyboard()
                                    }
                                }
                            }
                            .foregroundColor(inputText.isEmpty ? .black : .black)
                            .preferredColorScheme(.light)
                            .padding()
                        .frame(maxWidth: 300, maxHeight: 50)
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            .onSubmit {
                                fetchCityWeather()
                            }
                            Button(action: {
                                fetchCityWeather()
                            }) {
                                Text("Go")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: 60, maxHeight: 50)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                        .navigationDestination(isPresented: $isNavigating)
                        {
                            CurrentWeather(viewModel: weatherModel ??  WeatherDataModel(cityName: "New York", temperature: 72.0, icon: "https://openweathermap.org/img/wn/01n@2x.png", description: "Cloudy", dt: 1728933148))
                        }
                    }
                    .frame(maxHeight: 800)
                    NavigationLink(destination: HistoryView()) {
                        Text("History")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 150)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 120)
                    .padding(.bottom, 30)
                }
                .navigationBarHidden(true)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text(errorMessage ?? "An unknown error occurred."),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func fetchCityWeather() {
        guard !inputText.isEmpty else {
            errorMessage = WeatherAppError.emptyCityName.errorDescription
            showAlert = true
            isNavigating = false
            return
        }
        
        if cityExists(inputText) {
            errorMessage = WeatherAppError.cityDublicated.errorDescription
            showAlert = true
            isNavigating = false
            return
        }
        
        weatherManager.fetchWeather(cityName: inputText) { (weather, error) in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.errorDescription
                    self.showAlert = true
                    self.isNavigating = false
                } else if let weather = weather {
                    self.weatherModel = weather
                    context.insert(weather)
                    self.isNavigating = true
                    self.errorMessage = nil
                    self.showAlert = false
                    inputText = ""
                    deleteOldRecordsIfNeeded()
                }
            }
        }
    }
    
    func cityExists(_ cityName: String) -> Bool {
        let fetchDescriptor = FetchDescriptor<WeatherDataModel>(
            predicate: #Predicate { $0.cityName == cityName }
        )
        do {
            let matchingCities = try context.fetch(fetchDescriptor)
            return !matchingCities.isEmpty
        } catch {
            print("Failed to check for duplicate city: \(error)")
            return false
        }
    }
    
    
    func deleteOldRecordsIfNeeded() {
        let fetchDescriptor = FetchDescriptor<WeatherDataModel>(
            sortBy: [SortDescriptor(\WeatherDataModel.dt, order: .forward)]
        )
        do {
            let records = try context.fetch(fetchDescriptor)
            if records.count > recordLimit {
                let excessCount = records.count - recordLimit
                let recordsToDelete = records.prefix(excessCount)
                for record in recordsToDelete {
                    context.delete(record)
                }
                try context.save()
            }
        } catch {
            print("Failed to delete old records: \(error)")
        }
    }
}

////MARK: - Preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
