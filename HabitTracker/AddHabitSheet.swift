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
    
    let defaultHabits: [String] = ["🏋🏻‍♂️ Get Fit", "🧑🏻‍💻 Learn to Code", "🎻 Learn an Instrument", "🤓 Learn a Language", "🧘🏻 Practice Mindfulness", "📚 Read More", "🤷🏻‍♂️ Other…"]
    @State var selectedHabitIndex: Int? = nil
    @State var customHabitName: String = ""
    
    @State var description: String = ""
    
    @State var repetitionCount: Int? = nil
    let habbitTimes: [Int] = [1, 2, 5, 10, 12, 30, 365]
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Enter a new habit…", selection: $selectedHabitIndex) {
                        ForEach(0..<defaultHabits.count) { index in
                            Text(defaultHabits[index]).tag(index as Int?)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.inline)
                    
                } header: {
                    Text("I'd like to…")
                }
                
                if selectedHabitIndex == 6 {
                    Section {
                        TextField("Enter a habit…", text: $customHabitName)
                            .labelsHidden()
                    } header: {
                    Text("Custom Habit")
                    }
                }
                
                Section {
                TextField("Enter a description…", text: $description)
                    .labelsHidden()
                } header: {
                    Text("Description")
                }
                
                Section {
                    Picker("What's your goal?", selection: $repetitionCount) {
                        ForEach(0..<habbitTimes.count) { index in
                            Text("\(habbitTimes[index])").tag(index as Int?)
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
                        let newHabit: Habit
                        
                        if selectedHabitIndex != 6 {
                            newHabit = Habit(name: defaultHabits[selectedHabitIndex!], description: description, goal: habbitTimes[repetitionCount!], dateTime: [Date.now])
                        } else {
                            newHabit = Habit(name: customHabitName, description: description, goal: habbitTimes[repetitionCount!], dateTime: [Date.now])
                        }
                        
                        tracker.habits.append(newHabit)
                        dismiss()
                    }.disabled(selectedHabitIndex == nil || repetitionCount == nil)
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
