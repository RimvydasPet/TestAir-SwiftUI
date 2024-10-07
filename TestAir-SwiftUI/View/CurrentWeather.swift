//
//  CurrentWeather.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-16.
//
import SDWebImageSwiftUI
import SwiftUI

struct CurrentWeather: View {
    var viewModel: WeatherModel
    @StateObject var weatherManager = WeatherManager()
    
    var body: some View {
        VStack {
            
            Text("Current Weather")
                .font(.largeTitle)
                .padding(.top, 50)
            
            Spacer()
            
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 300, height: 200)
                    .shadow(color: Color.black.opacity(0.8), radius: 10, x: 0, y: 5)
                
                WebImage(url: URL(string: "\(viewModel.icon)" ))
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .padding(.top, 25)
                    .padding(.leading, 25)
                    .padding(.bottom, 150)
                
                Text("\(viewModel.description)")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.bottom, 160)
                    .padding(.leading, 80)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text((viewModel.formattedDate ?? "20.0"))
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding([.bottom, .trailing], 15)
                    .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                
                Text("\(viewModel.cityName)")
                    .font(.subheadline)
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
            .background( Image("dark_background")
                .resizable()
                .scaledToFill())
            .ignoresSafeArea()
        }
    }
////MARK: - Preview
//struct CurrentWeather_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentWeather(viewModel: WeatherModel(cityName: "Kaunas", temperature: 0.0, icon: "https://openweathermap.org/img/wn/10n@2x.png"
//, description: "sunny", dt: 0.0))
//    }
//}
