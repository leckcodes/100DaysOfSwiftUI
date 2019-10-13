//
//  ContentView.swift
//  Day19Challenge
//
//  Created by Gregory Leck on 2019-10-12.
//  Copyright © 2019 Gregory Leck. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let temperatureFromTypes = ["Celsius", "Fahrenheit", "Kelvin"]
    @State private var temperatureFromType = 0
    let temperatureToTypes = ["Celsius", "Fahrenheit", "Kelvin"]
    @State private var temperatureToType = 0
    
    @State private var amount = "0"
    
    var amountToConvert: Double {
        return Double(amount) ?? 0
    }
    
    var result: Double {
        
        if temperatureFromType == 0 && temperatureToType == 0 {
            return amountToConvert
        } else if temperatureFromType == 0 && temperatureToType == 1  {
            return amountToConvert * 9 / 5 + 32
        } else if temperatureFromType == 0 && temperatureToType == 2 {
            return amountToConvert + 273.15
            
        } else if temperatureFromType == 1 && temperatureToType == 0 {
            return (amountToConvert - 32) * 5 / 9
        } else if temperatureFromType == 1 && temperatureToType == 1 {
            return amountToConvert
        } else if temperatureFromType == 1 && temperatureToType == 2 {
            return (amountToConvert - 32) * 5 / 9 + 273.15
        
        } else if temperatureFromType == 2 && temperatureToType == 0 {
            return amountToConvert - 273.15
        } else if temperatureFromType == 2 && temperatureToType == 1 {
            return (amountToConvert - 273.15) * 9 / 5 + 32
        } else if temperatureFromType == 2 && temperatureToType == 2 {
            return amountToConvert
        } else {
            return 0
        }
    }
        
        var body: some View {
            NavigationView {
                Form {
                    Section(header: Text("Convert from:")) {
                        Picker("Type of Temp", selection: $temperatureFromType) {
                            ForEach(0 ..< temperatureFromTypes.count) {
                                Text(self.temperatureFromTypes[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("Convert to:")) {
                        Picker("Type of Temp", selection: $temperatureToType) {
                            ForEach(0 ..< temperatureToTypes.count) {
                                Text(self.temperatureToTypes[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    Section(header: Text("Amount to convert:")) {
                        TextField("Amount to convert", text: $amount)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section(header: Text("Result:")) {
                        Text("\(result, specifier: "%.2f")")
                    }
                }
                .navigationBarTitle("Day 19 Challenge")
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
}
