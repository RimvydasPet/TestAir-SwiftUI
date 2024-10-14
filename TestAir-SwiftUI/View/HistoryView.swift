import SwiftUI

struct HistoryView: View {
    @StateObject private var dataLoader = DataLoader()

    var body: some View {
        VStack {
            Text("History")
                .font(.largeTitle)
                .padding(.top, 50)

            Spacer()
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(dataLoader.weatherData) { weather in
                        ZStack(alignment: .bottomLeading) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.8))
                                .frame(width: 300, height: 200)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                            
                            AsyncImage(url: URL(string: weather.icon))
                                .frame(width: 40, height: 40)
                                .padding(.bottom, 145)
                                .padding(.leading, 15)
                            
                            Text("\(weather.description)")
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .padding(.bottom, 160)
                                .padding(.leading, 80)
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                            
                            Text((weather.formattedDate ?? "20.0"))
                                .font(.subheadline)
                                .foregroundColor(.black)
                                .padding([.bottom, .trailing], 15)
                                .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                            
                            Text("\(weather.cityName)")
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
                .padding()
            }

            Spacer()
        }
        .background(
            Image("light_background")
                .resizable()
                .scaledToFill()
        )
        .ignoresSafeArea()
        .onAppear {
            dataLoader.loadWeatherData() // Load weather data when the view appears
        }
    }
}
