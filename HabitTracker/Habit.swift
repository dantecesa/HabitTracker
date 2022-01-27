//
//  Habit.swift
//  HabitTracker
//
//  Created by Dante Cesa on 1/26/22.
//

import Foundation

struct Habit: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var goal: Int
    var dateTime: [Date]
    
    var count: Int {
        dateTime.count
    }
}
