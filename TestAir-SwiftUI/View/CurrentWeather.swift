//
//  CurrentWeather.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-16.
//

import SwiftUI

struct CurrentWeather: View {
    var viewModel: WeatherDataModel
    @StateObject var weatherManager = WeatherManager()
    
    var body: some View {
        ZStack {
            Image("dark_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Spacer()
                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.7))
                        .frame(width: 300, height: 200)
                    
                    AsyncImage(url: URL(string: viewModel.icon))
                        .frame(width: 40, height: 40)
                        .padding(.bottom, 145)
                        .padding(.leading, 15)
                    
                    Text("\(viewModel.describing)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding(.bottom, 160)
                        .padding(.leading, 80)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    Text((viewModel.formattedDate ?? "Loading date"))
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .padding([.bottom, .trailing], 15)
                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                    
                    Text("\(viewModel.cityName)")
                        .foregroundColor(.black)
                        .padding([.bottom, .leading], 15)
                        .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    
                    Text("\(viewModel.temperatureString)°C")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .frame(width: 300, height: 200)
                Spacer()
            }
        }
//        .background(Image("dark_background")
//            .resizable()
//            .scaledToFill())
//            .ignoresSafeArea()
    }
}

//MARK: - Preview
struct CurrentWeather_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeather(viewModel: WeatherDataModel(cityName: "Houston", temperature: 88.0, icon: "https://openweathermap.org/img/wn/03d@2x.png", description: "Overcast", dt: 1693573200))
    }
}
