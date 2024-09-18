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
                
                VStack {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 75)
                    
                    HStack {
                        TextField("Enter text", text: $inputText)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        NavigationLink(destination: CurrentWeather()) {
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

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
