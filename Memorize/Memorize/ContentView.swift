//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


struct ContentView: View {
    var deckIcons = [ "🚗", "🚜", "✈️", "⛵️", "🛸", "🏍" ]
    
    var body: some View {
        HStack {
            // Using id: \.self is a temporary hack be cause String is not an identifiable so it
            // really cannot be used in a ForEach like this. This won't work for the real app.
            ForEach(deckIcons, id: \.self) { cardIcon in
                CardView(iconCharacter: cardIcon, isFaceUp: true)
            }
// Longer version (with content: and the parens enclosing the lambda function):
//            ForEach(deckIcons, id: \.self, content: { cardIcon in
//                CardView(iconCharacter: cardIcon, isFaceUp: true)
//            })
        }
        .padding(.horizontal)
    }
}


struct CardView: View {
    var iconCharacter: String
    @State var isFaceUp: Bool
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {  // FRONT, face up
                cardShape.fill().foregroundColor(.green)
                
                cardShape.stroke(lineWidth: 3).foregroundColor(.purple)
                
                Text(iconCharacter).font(.largeTitle)
                    .shadow(color: .black, radius: 28)
                    .shadow(color: .black, radius: 12)
            } else {  // BACK, face down
                cardShape.fill().foregroundColor(.gray)
                
                cardShape.stroke(lineWidth: 3).foregroundColor(.purple)
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
