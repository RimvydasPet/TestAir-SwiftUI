//
//  ResponseModel.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-18.
//

import Foundation

struct ResponseModel: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
struct Date: Codable {
    let dt: Int
}
