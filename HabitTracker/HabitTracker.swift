//
//  HabitTracker.swift
//  HabitTracker
//
//  Created by Dante Cesa on 1/26/22.
//

import Foundation

class HabitTracker: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet {
            if let encodedItems = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encodedItems, forKey: "habits")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "habits") {
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItems) {
                habits = decodedItems
                return
            }
        }
        habits = []
    }
}
