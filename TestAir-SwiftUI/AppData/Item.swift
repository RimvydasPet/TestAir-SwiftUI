//
//  Item.swift
//  TestAir-SwiftUI
//
//  Created by Rimvydas on 2024-09-16.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
