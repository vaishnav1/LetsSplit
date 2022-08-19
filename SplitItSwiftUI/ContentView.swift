//
//  ContentView.swift
//  SplitItSwiftUI
//
//  Created by VaishnavChidambar on 17/08/22.
//

import SwiftUI

func getCurrencyFormat() -> FloatingPointFormatStyle<Double>.Currency {
    return .currency(code: Locale.current.currencyCode ?? "INR")
}

struct ContentView: View {
    
    //MARK: - State Variables
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    
    @FocusState private var amountIsFocused: Bool
    
    //MARK: - Variables
    
    let tipPercentages = [0, 5, 10, 15, 20, 25]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let total = checkAmount + tipSelection
        
        return total
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "INR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) People")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        /*  For percentage from 0 to 100 and where on clicking of picker it navigates to a new screen
                                                ForEach(0 ..< 101, id: \.self) {
                                                    Text("\($0)")
                                                }
                        */
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much do you want to tip?")
                        .textCase(nil)
                }
                
                Section {
                    Text(totalPerPerson, format: getCurrencyFormat())
                } header: {
                    Text("Amount per person")
                        .textCase(nil)
                }
                
                Section {
                    Text(grandTotal, format: getCurrencyFormat())
                }
                .navigationTitle("Let's Split")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            amountIsFocused = false
                        }
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
