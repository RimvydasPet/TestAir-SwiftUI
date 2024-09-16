//
//  ContentView.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-16.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var inputText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 75)
                
                HStack {
                    TextField("Enter text", text: $inputText)
                        .padding()  // Add padding inside the TextField
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .background(Color.white)  // Background color for the TextField
                        .cornerRadius(10)  // Corner radius for the background
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)  // Overlay with rounded corners
                                .stroke(Color.gray, lineWidth: 1)  // Border color and width
                        )
                        .padding(.horizontal, 50)  // Padding around the TextField
                    
                    NavigationLink(destination: CurrentWeather()) {
                        Text("Go")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: 60)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                
                .padding(.horizontal, 30)
                .padding(.bottom, 20 )
                
                NavigationLink(destination: HistoryView()) {
                    Text("History")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
            )
            .ignoresSafeArea()
        }
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
