//
//  AddHabitSheet.swift
//  HabitTracker
//
//  Created by Dante Cesa on 1/26/22.
//

import SwiftUI

struct AddHabitSheet: View {
    @ObservedObject var tracker: HabitTracker
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    @State var description: String = ""
    @State var goal: Int = 1
    let habbitTimes: [Int] = [1, 2, 5, 10, 12, 30, 365]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                TextField("Enter a new habit…", text: $name)
                    .labelsHidden()
                } header: {
                    Text("Habit Name")
                }
                
                Section {
                TextField("Enter a description…", text: $description)
                    .labelsHidden()
                } header: {
                    Text("Description")
                }
                
                Section {
                    Picker("What's your goal?", selection: $goal) {
                        ForEach(0..<habbitTimes.count) { index in
                            Text("\(habbitTimes[index])")
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("How many times do you want to do this habit?")
                }
            }
            .navigationTitle("Add Habit…")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newHabit = Habit(name: name, description: description, goal: habbitTimes[goal], dateTime: [Date.now])
                        
                        tracker.habits.append(newHabit)
                        dismiss()
                    }.disabled(name.count < 1)
                }
            }
        }
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitSheet(tracker: HabitTracker())
    }
}
