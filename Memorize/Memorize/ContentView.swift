//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


struct ContentView: View {
    var deckIcons = [ "🚗", "🚜", "✈️", "⛵️", "🛸", "🏍", "🛻", "🚂", "🚃", "🚲", "🚁", "🚐",
                      "🚓", "🛴", "🚤", "🚙", "🛶", "🚕", "🏎", "🚎", "🚀", "🛺", "🛼", "🚚",
                      "🛹", "🚌", "🛵", "🚒", "🛥", "🚑", "🚛", "🛷" ]  // Count: 32
    @State var iconCount = 6
    
    var body: some View {
        VStack {
            
            HStack {  // ROW OF CARDS
                // Using id: \.self is a temporary hack. TODO: This will be fixed as game logic evolves.
                ForEach(deckIcons[ 0 ..< iconCount ], id: \.self) { cardIcon in
                    CardView(iconCharacter: cardIcon, isFaceUp: true)
                }
            }  // HStack ROW OF CARDS
            .padding(.horizontal)
            
            HStack {  // Button - Spacer - Button
                removeButton
                Spacer()
                addButton
            }  // HStack Button - Spacer - Button
            // NOTE: The tutorial has the .padding on the HStack, but I prefer it on each button for now.
//            .padding(.horizontal)
            
        }  // VStack ContentView
    }
    
    var removeButton: some View {
            Button(action: {
                iconCount -= 1
            }, label: {
                VStack {
                    Text("Remove")
                    Text("Card")
                }
            })
            .padding(.horizontal)
    }  // var removeButton
    
    var addButton: some View {
        Button(action: {
            iconCount += 1
        }, label: {
            VStack {
                Text("Add")
                Text("Card")
            }
        })
        .padding(.horizontal)
    }  // var addButton
    
    
    
    
}  // ContentView


struct CardView: View {
    var iconCharacter: String
    @State var isFaceUp: Bool
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {  //  |FRONT|, face up
                
                cardShape.fill().foregroundColor(.green)
                
                cardShape.stroke(lineWidth: 3).foregroundColor(.purple)
                
                Text(iconCharacter).font(.largeTitle)
                    .shadow(color: .black, radius: 28)
                    .shadow(color: .black, radius: 12)
                
            } else {  //  |BACK|, face down
                
                cardShape.fill().foregroundColor(.gray)
                
                cardShape.stroke(lineWidth: 3).foregroundColor(.purple)
                
            }
            
        }  // ZStack CardView
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
        
    }
}  // CardView


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 mini")
//            .previewDevice("iPhone 6s Plus")
//            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)  // Comment this out for .light, which is the default.
    }
}


/**/
