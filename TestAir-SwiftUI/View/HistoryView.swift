//
//  HistoryView.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-16.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    var body: some View {
        VStack {

            Text("History Screen")
                .font(.largeTitle)
                .navigationTitle("History")
                .padding(.top, 50)
            
            Spacer()
            
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(width: 300, height: 200)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)

                Text("Sep 1, 2024")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding([.top, .leading], 15)

                Text("New York")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding([.top, .trailing], 15)
                    .frame(maxWidth: .infinity, alignment: .topTrailing)

                Text("72°F")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(width: 300, height: 200)
    
        Spacer()
    }
    .background(Image("light_background")
        .resizable()
        .scaledToFill())
    .ignoresSafeArea()
    }
}

//MARK: - Preview
struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
