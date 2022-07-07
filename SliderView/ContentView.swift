//
//  ContentView.swift
//  SliderView
//
//  Created by Maksim Grischenko on 05.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueValue = Double.random(in: 0...255)
    
    @State private var redTextFieldValue = 0
    @State private var greenTextFieldValue = 0
    @State private var blueTextFieldValue = 0
    
    @State private var alertPresented = false
    
    @FocusState private var redTextFieldFocus: Bool
    @FocusState private var greenTextFieldFocus: Bool
    @FocusState private var blueTextFieldFocus: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.cyan
                .ignoresSafeArea()
            VStack {
                ColorView(
                    redColor: $redValue,
                    greenColor: $greenValue,
                    blueColor: $blueValue
                )
                SliderView(
                    value: $redValue,
                    textFieldValue: $redTextFieldValue,
                    textFieldFocus: _redTextFieldFocus,
                    color: .red
                )
                SliderView(
                    value: $greenValue,
                    textFieldValue: $greenTextFieldValue,
                    textFieldFocus: _greenTextFieldFocus,
                    color: .green
                )
                SliderView(
                    value: $blueValue,
                    textFieldValue: $blueTextFieldValue,
                    textFieldFocus: _blueTextFieldFocus,
                    color: .blue)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done", action: doneButtonPressed)
                        .alert("Wrong Format", isPresented: $alertPresented, actions: {}) {
                            Text("You must enter value from 0 to 255")
                        }
                }
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
        
    }
    private func doneButtonPressed() {
        if redTextFieldFocus {
            if redTextFieldValue < 0 || redTextFieldValue > 255 {
                alertPresented.toggle()
            } else {
                redValue = Double(redTextFieldValue)
                redTextFieldFocus.toggle()
            }
        } else if greenTextFieldFocus {
            if greenTextFieldValue < 0 || greenTextFieldValue > 255 {
                alertPresented.toggle()
                greenTextFieldValue = 0
            } else {
                greenValue = Double(greenTextFieldValue)
                greenTextFieldFocus.toggle()
            }
        } else {
            if blueTextFieldValue < 0 || blueTextFieldValue > 255 {
                alertPresented.toggle()
                blueTextFieldValue = 0
            } else {
                blueValue = Double(blueTextFieldValue)
                blueTextFieldFocus.toggle()
            }
            
        }
    }
    private func hideKeyboard() {
        if redTextFieldFocus {
            redTextFieldFocus.toggle()
        } else if greenTextFieldFocus {
            greenTextFieldFocus.toggle()
        } else if blueTextFieldFocus{
            blueTextFieldFocus.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
