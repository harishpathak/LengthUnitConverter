//
//  ContentView.swift
//  UnitConverter
//
//  Created by Harish on 20/12/22.
//

import SwiftUI

enum LengthUnit: String, CaseIterable {
    case meter
    case feet
    case km
    case miles
    case yard
    
    func toFeet() -> Double {
        switch self {
        case .meter:
            return 3.28084
        case .feet:
            return 1
        case .km:
            return 3280.84
        case .miles:
            return 5280.00016896
        case .yard:
            return 3
        }
    }
    
    func fromFeet() -> Double {
        switch self {
        case .meter:
            return 0.3048
        case .feet:
            return 1
        case .km:
            return 0.0003048
        case .miles:
            return 0.000189394
        case .yard:
            return 0.33333
        }
    }
}

struct ContentView: View {
    
    private let lengthUnits = LengthUnit.allCases
    
    @State private var selectedFromUnit: LengthUnit = .feet
    @State private var selectedToUnit: LengthUnit = .meter
    @State private var numberOfUnits: Double = 1.0
    
    @FocusState private var unitFocused: Bool
    
    private var output: Double {
        let toFeet = selectedFromUnit.toFeet() * numberOfUnits
        let toOutput = toFeet * selectedToUnit.fromFeet()
        return toOutput
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter value", value: $numberOfUnits, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($unitFocused)
                } header: {
                    Text("Units")
                }
                
                Section {
                    Picker("Pick a unit", selection: $selectedFromUnit) {
                        ForEach(lengthUnits, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("FROM")
                }
                
                Section {
                    Picker("Pick a unit", selection: $selectedToUnit) {
                        ForEach(lengthUnits, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("TO")
                }
                
                Section {
                    Text(output.formatted())
                } header: {
                    Text("RESULT")
                }
                
            }
            .navigationTitle("Length Unit Converter")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        unitFocused = false
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
