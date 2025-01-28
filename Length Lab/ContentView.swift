//
//  ContentView.swift
//  Length Lab
//
//  Created by Ino Yang Popper on 1/20/25.
//

import SwiftUI

struct ContentView: View {
    @State private var unitAmount = 0.0
    @State private var selectedInputUnit: Dimension = UnitLength.feet
    @State private var selectedOutputUnit: Dimension = UnitLength.inches
    @State private var selectedUnits = 0
    
    @FocusState private var amountIsFocused: Bool
    
    let conversions = ["Distance", "Mass", "Temperature", "Time"]
    
    let unitTypes = [
        [UnitLength.feet, UnitLength.kilometers, UnitLength.meters, UnitLength.miles, UnitLength.yards],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    
    let formatter: MeasurementFormatter
    
    var result: String {
        let inputMeasurement = Measurement(value: unitAmount, unit: selectedInputUnit)
        let outputMeasurement = inputMeasurement.converted(to: selectedOutputUnit)
        return  formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Amount to convert") {
                    TextField("Enter amount", value: $unitAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Picker("Coversion", selection: $selectedUnits) {
                    ForEach(0..<conversions.count, id: \.self) {
                        Text(conversions[$0])
                    }
                }
                
                Picker("Convert from", selection: $selectedInputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                
                Picker("Convert to", selection: $selectedOutputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                    Text(formatter.string(from: $0).capitalized)
                }
            }
            
            Section("result") {
                Text(result)
            }
        }
        .navigationTitle("Length Converter")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if amountIsFocused {
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
    }
}
init() {
    formatter = MeasurementFormatter()
    formatter.unitOptions = .providedUnit
    formatter.unitStyle = .long
}
}

#Preview {
    ContentView()
}
