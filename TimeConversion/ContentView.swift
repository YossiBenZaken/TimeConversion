//
//  ContentView.swift
//  TimeConversion
//
//  Created by Yosef Ben Zaken on 23/02/2022.
//

import SwiftUI

struct ContentView: View{
    // States
    @State private var fromUnit: String = "seconds"
    @State private var toUnit: String = "seconds"
    @State private var unit: Double = 0.0
    @FocusState private var isFocused: Bool
    // Consts
    let units: [String] = ["seconds","minutes","hours","days"]
    // Variable
    var conversion: Double {
        var u = unit
        if fromUnit != units[0] {
            switch fromUnit {
            case "minutes":
                u *= 60
                break
            case "hours":
                u *= 3_600
                break
            case "days":
                u *= 86_400
                break
            default:
                u = unit
            }
        }
        switch toUnit {
        case "minutes":
            return u / 60
        case "hours":
            return u / 3_600
        case "days":
            return u / 86_400
        default:
            return u
        }
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Units", value: $unit, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("From Unit", selection: $fromUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("From \(fromUnit)")
                }
                Section {
                    Picker("To Unit", selection: $toUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    Text("Convert from \(fromUnit) to \(toUnit) is \(conversion.formatted(.number))")
                } header: {
                    Text("To \(toUnit)")
                }
            }
            .navigationTitle("Time Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
