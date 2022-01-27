//
//  HabbitDetailView.swift
//  HabitTracker
//
//  Created by Dante Cesa on 1/26/22.
//

import SwiftUI

struct HabbitDetailView: View {
    let tracker: HabitTracker
    let withIndex: Int
    @State var withHabit: Habit
        
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Description", text: $withHabit.description)
                } header: {
                    Text("Description")
                }
                
                Section {
                    HStack {
                        HStack(spacing:0) {
                            Text("\(withHabit.count)")
                            Text("/\(withHabit.goal)")
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("\((withHabit.count / withHabit.goal).formatted(.percent))")
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: {
                        withHabit.dateTime.insert(Date.now, at: 0)
                    }, label: {
                        Text("🥊  this task")
                            .font(.title2)
                    })
                } header: {
                    Text("Goal")
                }
                
                Section {
                    ForEach(withHabit.dateTime, id:\.self) { rep in
                        HStack {
                            Text("\(rep)")
                            Spacer()
                            Text("1")
                        }
                    }
                } header: {
                    Text("Reps")
                }
            }
        }
        .navigationTitle(withHabit.name)
        .onDisappear {
            tracker.habits[withIndex] = Habit(name: withHabit.name, description: withHabit.description, goal: withHabit.goal, dateTime: withHabit.dateTime)
        }
    }
}

struct HabbitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabbitDetailView(tracker: HabitTracker(), withIndex: 0, withHabit: Habit(name: "Test Habit", description: "A sample description", goal: 2, dateTime: [Date.now]))
    }
}
