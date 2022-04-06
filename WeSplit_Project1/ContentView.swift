//
//  ContentView.swift
//  WeSplit_Project1
//
//  Created by David Chester on 4/6/22.
//

import SwiftUI

struct ContentView: View {
    
    // @State is designed for simple properties that are stored in one view, so that is why we also use private so it is known it is a local value
    @State private var totalDiners = 2
    @State private var checkAmount = 0.0
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        // calculate total per person here
        let peopleCount = Double(totalDiners + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (checkAmount / 100) * tipSelection
        let grandTotal = checkAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form {
                // forms can only have 10 items in them (like our text blocks) but you can split things into either Groups {} or Sections{} to break them up. Sections will split the table view as seen in the preview.
                Section{
                    //below we use the $ symbol to create a relationship between the variable we declared and the user input. So when a user enters their checkAmount into the textfield, it is saved to our checkAmount variable
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Number of Diners", selection: $totalDiners) {
                        ForEach(2..<100) {
                            Text("Dining with \($0) people")
                        }
                    }
                } header: {
                    Text("Input bill and amount")
                }
                Section{
                    // notice we use the variable in selection and the array in the ForEach loop
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Amount")
                }
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total Amount")
                }
            }
            .navigationTitle("WeSplit Dining")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
           
        }
    }
}
