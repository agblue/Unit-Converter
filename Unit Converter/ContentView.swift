//
//  ContentView.swift
//  Unit Converter
//
//  Created by Danny Tsang on 8/12/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var unitSelection = 0 {
        didSet {
            inputSelection = 0
            outputSelection = 0
        }
    }
    @State private var inputSelection = 0
    @State private var outputSelection = 0
    @State private var inputText = ""

    var outputString: String {
        
        switch unitSelection {
        case 0: // Length
            let inputAmount = Double(inputText) ?? 0
            let convertedInput = inputAmount * Double(lengthConversion[inputSelection])
            let convertedOutput = convertedInput / Double(lengthConversion[outputSelection])
            return "\(convertedOutput)"
            
        case 1: // Temperature
            let inputAmount = Double(inputText) ?? 0
            if inputSelection ==  0 {
                switch outputSelection {
                case 0:
                    return String(inputAmount)
                case 1:
                    return String((inputAmount * 9 / 5) + 32.0)
                case 2:
                    return String(inputAmount - temperatureConversion[2])
                default:
                    return ""
                }
            } else if inputSelection == 1 {
                switch outputSelection {
                case 0:
                    return String((inputAmount - 32) * 9 / 5)
                case 1:
                    return String(inputAmount)
                case 2:
                    return String(((inputAmount - 32) * 9 / 5) - temperatureConversion[2])
                default:
                    return ""
                }
            } else if inputSelection == 2 {
                switch outputSelection {
                case 0:
                    return String(inputAmount + temperatureConversion[2])
                case 1:
                    return String((inputAmount * 5 / 9) + 32.0)
                case 2:
                    return String(inputAmount)
                default:
                    return ""
                }
            } else {
                return ""
            }
        case 2: // Time
            let inputAmount = Double(inputText) ?? 0
            let convertedInput = inputAmount * Double(timeConversion[inputSelection])
            let convertedOutput = convertedInput / Double(timeConversion[outputSelection])
            return "\(convertedOutput)"
        case 3: // Volume
            let inputAmount = Double(inputText) ?? 0
            let convertedInput = inputAmount * Double(volumeConversion[inputSelection])
            let convertedOutput = convertedInput / Double(volumeConversion[outputSelection])
            return "\(convertedOutput)"
        case 4: // Storage
            let inputAmount = Double(inputText) ?? 0
            let convertedInput = inputAmount * Double(storageConversion[inputSelection])
            let convertedOutput = convertedInput / Double(storageConversion[outputSelection])
            return "\(convertedOutput)"
        default:
            let inputAmount = Double(inputText) ?? 0
            let convertedInput = inputAmount / Double(unitConversion[inputSelection])
            let convertedOutput = convertedInput * Double(unitConversion[outputSelection])
            return "\(convertedOutput)"
        }
    }
    
    let unitTypes = ["Length", "Temp", "Time", "Volume", "Storage", "Speed"]
    
    let lengthUnits = ["meters", "kilometers", "feet", "yards", "miles", "", ""]
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin", "", "", "", ""]
    let timeUnits = ["seconds", "minutes", "hours", "days", "weeks", "months", "years"]
    let volumeUnits = ["milliliters", "liters", "US cups", "US pints", "US quarts", "US gallons", ""]
    let storageUnits = ["bits", "bytes", "kilobytes", "megabytes", "gigabytes", "terabytes", ""]
    let speedUnits = ["miles per hour", "foot per second", "meter per second", "kilometer per hour", "knots", "", ""]

    var unitMeasurements: [String] {
        switch unitSelection {
        case 0:
            return lengthUnits
        case 1:
            return temperatureUnits
        case 2:
            return timeUnits
        case 3:
            return volumeUnits
        case 4:
            return storageUnits
        case 5:
            return speedUnits
        default:
            return [String]()
        }
    }
    
    let lengthConversion = [3.28084, 3280.84, 1, 3, 5280]
    let temperatureConversion = [0, 0.555555556, -273.15]
    let timeConversion = [1.0, 60.0, 3600.0, 86400.0, 604800.0, 2628028.8 ,31536000.0]
    let volumeConversion = [1, 1000, 240, 473.176, 946.353, 3785.41]
    let storageConversion = [1.0, 8.0, 8000.0, 8000000.0, 80000000000.0, 8000000000000.0, 8000000000000000.0]
    let speedConversion = [2.23694, 3.28084, 1.0, 3.6, 1.94384]

    var unitConversion: [Double] {
        switch unitSelection {
        case 0:
            return lengthConversion
        case 1:
            return temperatureConversion
        case 2:
            return timeConversion
        case 3:
            return volumeConversion
        case 4:
            return storageConversion
        case 5:
            return speedConversion
        default:
            return [Double]()
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header:Text("Select Unit Type")) {
                    Picker("Unit Type", selection: $unitSelection) {
                        ForEach(0 ..< unitTypes.count) {
                            Text("\(self.unitTypes[$0])")
                        }
                    }
                }
                
                Section(header:Text("Convert Between")) {
                    Picker("Input Unit", selection:$inputSelection) {
                        ForEach(0 ..< unitMeasurements.count) {
                            Text("\(self.unitMeasurements[$0])")
                        }
//                        ForEach(unitMeasurements, id:\.self) {
//                            Text("\($0)")
//                        }
                        
                    }
                    Picker("Output Unit", selection:$outputSelection) {
                        ForEach(0 ..< unitMeasurements.count) {
                            Text("\(self.unitMeasurements[$0])")
                        }
                    }
                    HStack {
                        Spacer()
                        Button("Swap") {
                            let tempSelection = inputSelection
                            inputSelection = outputSelection
                            outputSelection = tempSelection
                        }
                        Spacer()
                    }
                    
                }
                
                Section(header: Text("Converted Amounts")) {
                    HStack {
                        TextField("Input Amount", text: $inputText)
                            .keyboardType(.decimalPad)
                        Spacer()
                        Text("\(unitMeasurements[inputSelection])")
                    }
                    HStack {
                        Text("\(outputString)")
                        Spacer()
                        Text("\(unitMeasurements[outputSelection])")
                    }
                }
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
