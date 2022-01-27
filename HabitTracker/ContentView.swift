//
//  ContentView.swift
//  HabitTracker
//
//  Created by Dante Cesa on 1/26/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var tracker = HabitTracker()
    @State private var addSheetShown: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<tracker.habits.count, id:\.self) { index in
                    NavigationLink(destination: {
                        HabbitDetailView(tracker: tracker, withIndex: index, withHabit: tracker.habits[index])
                    }, label: {
                        VStack(alignment: .leading) {
                            Text(tracker.habits[index].name)
                                .font(.title2)
                            Spacer()
                            Text("\(tracker.habits[index].count) times")
                                .foregroundColor(.secondary)
                        }
                    })
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("HabitTracker")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        addSheetShown = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $addSheetShown) {
                AddHabitSheet(tracker: tracker)
            }
        }
    }
    
    func removeItems(atOffsets: IndexSet) {
        tracker.habits.remove(atOffsets: atOffsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
