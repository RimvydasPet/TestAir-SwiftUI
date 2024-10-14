//
//  WeatherModel.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-18.
//

import Foundation
import SwiftUI

struct WeatherModel: Codable, Identifiable {
     var id = UUID()
     var cityName: String
     var temperature: Double
     var icon: String
     var description: String
    
    var dt: Double?
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var date: Foundation.Date? {
        guard let dt = dt else { return nil }
        return Foundation.Date(timeIntervalSince1970: TimeInterval(dt))
    }
    
    var formattedDate: String? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE\n  dd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: date)
    }
}

