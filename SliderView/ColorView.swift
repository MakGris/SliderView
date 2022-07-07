//
//  ColorView.swift
//  SliderView
//
//  Created by Maksim Grischenko on 06.07.2022.
//

import SwiftUI

struct ColorView: View {
    
    @Binding var redColor: Double
    @Binding var greenColor: Double
    @Binding var blueColor: Double
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .frame(width: 280, height: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(lineWidth: 4)
                    .foregroundColor(.white)
            )
            .padding()
            .foregroundColor(
                Color(red: redColor / 255,
                      green: greenColor / 255,
                      blue: blueColor / 255)
            )
            
    }
}

struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView(
            redColor: .constant(0),
            greenColor: .constant(0),
            blueColor: .constant(0))
    }
}
