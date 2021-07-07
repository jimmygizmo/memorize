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
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
        }
        .padding(.horizontal)
    }
}


struct CardView: View {
    @State var isFaceUp: Bool
    
    var body: some View {
        ZStack {
            let card_shape = RoundedRectangle(cornerRadius: 20)
//            let card_shape = Circle()
            
            if isFaceUp {
                // CARD FRONT
                card_shape.fill().foregroundColor(.green)
                
                card_shape.stroke(lineWidth: 3).foregroundColor(.purple)
                
                Text("🚜").font(.largeTitle)
                    .shadow(color: .black, radius: 26)
                    .shadow(color: .black, radius: 10)
            } else {
                // CARD BACK
                card_shape.fill().foregroundColor(.gray)
                
                card_shape.stroke(lineWidth: 3).foregroundColor(.purple)
            }
            
        }  // ZStack
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 mini")
//            .previewDevice("iPhone 6s Plus")
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
//            .preferredColorScheme(.light)
    }
}


/**/
