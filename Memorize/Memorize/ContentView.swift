//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


// TODO: Reading Assignment 1:
// https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/reading_1.pdf

// TODO: Programming Assignment 1:
// https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_1.pdf


struct ContentView: View {
    let deckIcons = [ "🍑", "🫐", "🍌", "🍕", "🫑", "🥓", "🧁", "🌮", "🍗", "🍓", "🍦", "🍩",
                      "🥪", "🍪", "☕️", "🍫", "🍚", "🍭", "🥦", "🍔", "🥕", "🍍", "🫒", "🍎",
                      "🌽", "🍒", "🍰", "🌭", "🍉", "🥖", "🥝", "🥑" ]  // Count: 32
    // Above we just use a literal copy of the array, until we get the theme mechanism working.
    
    let travelIcons = [ "🚗", "🚜", "✈️", "⛵️", "🛸", "🏍", "🛻", "🚂", "🚃", "🚲", "🚁", "🚐",
                      "🚓", "🛴", "🚤", "🚙", "🛶", "🚕", "🏎", "🚎", "🚀", "🛺", "🛼", "🚚",
                      "🛹", "🚌", "🛵", "🚒", "🛥", "🚑", "🚛", "🛷" ]  // Count: 32
/*    let foodIcons = [ "🍑", "🫐", "🍌", "🍕", "🫑", "🥓", "🧁", "🌮", "🍗", "🍓", "🍦", "🍩",
                      "🥪", "🍪", "☕️", "🍫", "🍚", "🍭", "🥦", "🍔", "🥕", "🍍", "🫒", "🌽",
                      "🌽", "🍒", "🍰", "🌭", "🍉", "🥖", "🥝", "🥑" ]  // Count: 32
 */
    let animalIcons = [ "🐇", "🦞", "🦦", "🐏", "🪰", "🦩", "🦉", "🐟", "🪲", "🐳", "🐈", "🐀",
                      "🦋", "🐥", "🐗", "🐓", "🐿", "🐖", "🦢", "🐊", "🐅", "🐢", "🐸", "🐘",
                      "🦝", "🦧", "🦃", "🦂", "🦀", "🦜", "🦥", "🦙" ]  // Count: 32
/*  let deckIcons = travelIcons  // Doesn't work here but the idea was to set a default theme.
    If I try to simply copy this array here like this, I get the following ERROR:
    Cannot use instance member 'travelIcons' within property initializer; property initializers run before 'self' is available
 */
    
    @State var iconCount = 32
    
    var body: some View {
        VStack {
            
            ScrollView {  // CARDS
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 65))
                ]) {
                    // For card aspect ratio, I use the inverse of the Golden Ratio: 1.618
                    //
                    // Using id: \.self is a temporary hack in place until we have game logic.
                    ForEach(deckIcons[ 0 ..< iconCount ], id: \.self) { cardIcon in
                        CardView(iconCharacter: cardIcon, isFaceUp: true)
                            .aspectRatio(0.618, contentMode: .fit)
                    }
                }  // LazyVGrid
                .padding(.horizontal)
                .foregroundColor(.purple)
                
            }  // ScrollView - CARDS
                
                Spacer()
            
            HStack {  // Button - Spacer - Button
                removeButton
                Spacer()
                addButton
            }  // HStack Button - Spacer - Button
            // NOTE: The tutorial has the .padding on the HStack.
            // I prefer to keep this padding on the individual buttons for now.
//            .padding(.horizontal)
                
        }  // VStack ContentView
    }
    
    var removeButton: some View {
        Button {
            if iconCount > 1 {
                iconCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
        .font(.largeTitle)
        .padding()
    }  // var removeButton
    
    var addButton: some View {
        Button {
            if iconCount < deckIcons.count {
                iconCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
        .font(.largeTitle)
        .padding()
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
                
                cardShape.strokeBorder(lineWidth: 3)
                
                Text(iconCharacter).font(.largeTitle)
                    .shadow(color: .black, radius: 28)
                    .shadow(color: .black, radius: 12)
                
            } else {  //  |BACK|, face down
                
                cardShape.fill().foregroundColor(.gray)
                
                cardShape.strokeBorder(lineWidth: 3)
                
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
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)  // Comment this out for .light, which is the default.
    }
}


/**/
