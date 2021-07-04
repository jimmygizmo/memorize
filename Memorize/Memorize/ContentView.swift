//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding(.horizontal)
        
    }  // var body: some View
}


struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
                .foregroundColor(.red)
            
            Text("X")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color.blue)
                .padding()
        }  // ZStack
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue:
                "iPhone 12 mini (com.apple.CoreSimulator.SimDeviceType.iPhone-12-mini)")
//                "iPhone 6s Plus (com.apple.CoreSimulator.SimDeviceType.iPhone-6s-Plus)")
            )
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
//            .preferredColorScheme(.light)
    }
}


/**/
