//
//  SliderView.swift
//  SliderView
//
//  Created by Maksim Grischenko on 05.07.2022.
//

import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    @Binding var textFieldValue: Int
    
    @FocusState var textFieldFocus: Bool
    
    @State private var alertPresented = false
    
    let color: Color
    
    
    var body: some View {
        HStack() {
            Text("\(lround(value))")
                .onAppear() {
                    textFieldValue = lround(value)
                }
                .foregroundColor(.white)
                .frame(width: 35, height: 20, alignment: .leading)
            
            Slider(value: $value, in: 0...255, step: 1)
                .onChange(of: value, perform: { newValue in
                    textFieldValue = lround(newValue)
                })
                .tint(color)
            
            TextField("\(lround(value))", value: $textFieldValue,format: .number)
                .bordered()
                .onSubmit {
                    checkValue()
                }
                .focused($textFieldFocus)
                
                .alert("Wrong Format", isPresented: $alertPresented, actions: {}) {
                    Text("You must enter value from 0 to 255")
                }
                
        }
        .padding()
    }
    private func checkValue() {
        if textFieldValue < 0 || textFieldValue > 255 {
            alertPresented.toggle()
        } else {
            value = Double(textFieldValue)
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    
    static var previews: some View {
       
        SliderView(value: .constant(0), textFieldValue: .constant(0), color: .red)
    }
}

struct BorderedViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .keyboardType(.numberPad)
            .multilineTextAlignment(.trailing)
            .frame(width: 35, height: 20)
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .background(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
            )
            .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 1, y: 2)
        
    }
}

extension TextField {
    func bordered() -> some View {
        ModifiedContent(
            content: self,
            modifier: BorderedViewModifier()
        )
    }
}
