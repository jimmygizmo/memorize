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
    }
}


struct CardView: View {
    var body: some View {
//        return ZStack (alignment: .top, content: {    // Longer form. A ) would be after }.
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill()
                .foregroundColor(.white)
            
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            
            Text("🚜")
                .font(.largeTitle)
//                .fontWeight(.black)  // Won't need these text mods with emoji/icons.
//                .foregroundColor(.blue)
                .padding()
            // Tutorial takes the padding off the Text itself, but I'll keep it for now.
        }
        .foregroundColor(.purple)
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
