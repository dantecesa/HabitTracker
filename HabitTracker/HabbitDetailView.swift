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
                    HStack {
                        HStack(spacing:0) {
                            Text("\(withHabit.count)")
                            Text("/\(withHabit.goal)")
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("\((Double(withHabit.count) / Double(withHabit.goal)).formatted(.percent))")
                            .foregroundColor(withHabit.count > withHabit.goal ? .green : .secondary)
                    }
                } header: {
                    Text("Goal")
                }
                
                Section {
                    TextField("Description", text: $withHabit.description)
                } header: {
                    Text("Description")
                }
                
                Section {
                    Button(action: {
                        withAnimation {
                            withHabit.dateTime.insert(Date.now, at: 0)
                        }
                    }, label: {
                        Text("🥊  this task")
                            .font(.title2)
                    })
                } header: {
                    Text("Log a rep")
                }
                 
                Section {
                    ForEach(withHabit.dateTime, id:\.self) { rep in
                        HStack {
                            let formattedDate = rep.formatted(date: .abbreviated, time: .omitted)
                            let formattedTime = rep.formatted(date: .omitted, time: .shortened)
                            
                            VStack(alignment: .leading) {
                                Text("\(formattedDate)")
                                Text("\(formattedTime)")
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Text("1")
                        }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Previous reps")
                }
            }
        }
        .navigationTitle(withHabit.name)
        .onDisappear {
            tracker.habits[withIndex] = Habit(name: withHabit.name, description: withHabit.description, goal: withHabit.goal, dateTime: withHabit.dateTime)
        }
    }
    
    func removeItems(atOffsets: IndexSet) {
        withHabit.dateTime.remove(atOffsets: atOffsets)
    }
}

struct HabbitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabbitDetailView(tracker: HabitTracker(), withIndex: 0, withHabit: Habit(name: "Test Habit", description: "A sample description", goal: 2, dateTime: [Date.now]))
    }
}
