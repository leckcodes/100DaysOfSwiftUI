//
//  ContentView.swift
//  BetterRest-Challenge
//
//  Created by Gregory Leck on 2019-10-22.
//  Copyright © 2019 Gregory Leck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    
    @State private var coffeeAmount = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    @State private var chosenCoffeeAmount = 0
    
    var suggestedBedtime: String {
        
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try
                model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount[chosenCoffeeAmount]))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
            
        } catch {
            
            return "Sorry, there was a problem calculating your bedtime"
            
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    
                    DatePicker("Please enter a time",
                               selection: $wakeUp,displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep:")) {
                    
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake:")) {
                    
                    Picker(selection: $chosenCoffeeAmount, label: Text("# of Cups")) {
                        ForEach(0..<coffeeAmount.count) {
                            Text("\(self.coffeeAmount[$0])")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                }
                
                Section(header: Text("Suggested bedtime:")) {
                    Text("\(suggestedBedtime)")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
