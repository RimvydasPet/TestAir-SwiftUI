//
//  TestAir_SwiftUIApp.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-16.
//

import SwiftUI
import SwiftData

@main
struct TestAir_SwiftUIApp: App {
    // Create the ModelContainer for WeatherDataModel
    let container: ModelContainer
    
    init() {
        // Initialize the container and handle potential errors
        do {
            container = try ModelContainer(for: WeatherDataModel.self)
        } catch {
            fatalError("Failed to initialize the ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // Pass the model container's context to the environment
                .environment(\.modelContext, container.mainContext)
        }
    }
}
