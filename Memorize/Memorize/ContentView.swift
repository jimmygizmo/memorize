//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


// POSSIBLE FONTS: AmericanTypewriter-Bold


// TODO: Programming Assignment 1:
// https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_1.pdf


/**********************************************************************************************************/
// TODO: Multiple decks have multiple properties so later we might want to refactor and keep all
// info for each deck together in an organized manner, such as with a struct along these lines.
// This is not really needed if we only have 3 decks/themes but is a good pattern to consider.
struct CardDeck {
    var icons: [String]
    let name: String
    var count: Int {
        icons.count
    }
    
}
// RELATED. Then we might:
//var decks: [CardDeck] = []
//var cardDeck = CardDeck(icons: [ "🍑", "🫐", "🍌", "🍕", "🫑",
//                                 "🥪", "🍪", "☕️", "🍫", "🍚",
//                                 "🌽", "🍒", "🍰", "🌭", "🍉", "🥑" ],
//                        name: "Travel")
/**********************************************************************************************************/


struct ContentView: View {
    
    let travelIcons = [ "🚗", "🚜", "✈️", "⛵️", "🛸", "🏍", "🛻", "🚂", "🚃", "🚲", "🚁", "🚐",
                      "🚓", "🛴", "🚤", "🚙", "🛶", "🚕", "🏎", "🚎", "🚀", "🛺", "🛼", "🚚",
                      "🛹", "🚌", "🛵", "🚒", "🛥", "🚑", "🚛", "🛷" ]  // Count: 32
    
    let foodIcons = [ "🍑", "🫐", "🍌", "🍕", "🫑", "🥓", "🧁", "🌮", "🍗", "🍓", "🍦", "🍩",
                      "🥪", "🍪", "☕️", "🍫", "🍚", "🍭", "🥦", "🍔", "🥕", "🍍", "🫒", "🌽",
                      "🌽", "🍒", "🍰", "🌭", "🍉", "🥖", "🥝", "🥑" ]  // Count: 32
 
    let animalIcons = [ "🐇", "🦞", "🦦", "🐏", "🪰", "🦩", "🦉", "🐟", "🪲", "🐳", "🐈", "🐀",
                      "🦋", "🐥", "🐗", "🐓", "🐿", "🐖", "🦢", "🐊", "🐅", "🐢", "🐸", "🐘",
                      "🦝", "🦧", "🦃", "🦂", "🦀", "🦜", "🦥", "🦙" ]  // Count: 32
/*  let deckIcons = travelIcons  // Doesn't work here but the idea was to set a default theme.
    If I try to simply copy this array here like this, I get the following ERROR:
    Cannot use instance member 'travelIcons' within property initializer;
     property initializers run before 'self' is available
 */
    
    //var deckIcons: [String]  // TODO: FIGURING OUT WHERE/HOW I CAN SET THIS. SEE ERROR ABOVE.
    
    // TEMPORARILY:
    let deckIcons = [ "🐇", "🦞", "🦦", "🐏", "🪰", "🦩", "🦉", "🐟", "🪲", "🐳", "🐈", "🐀",
        "🦋", "🐥", "🐗", "🐓", "🐿", "🐖", "🦢", "🐊", "🐅", "🐢", "🐸", "🐘",
        "🦝", "🦧", "🦃", "🦂", "🦀", "🦜", "🦥", "🦙" ]  // Count: 32
    
    
    @State var iconCount = 32
    
    var body: some View {
        
        VStack {
            
            Text("Memorize!")
                .font(Font.custom("AmericanTypewriter-Bold", size: 24.0))
                .foregroundColor(Color.purple)
            // TODO: Make the font size relative and not absolute. It seems I was required to
            // specify an absolute size!?
            
            // TODO: The padding or spacing under this title, before the ScrollView starts
            // (as shown by blue box/lines in preview when highlighted) is a bit too much and I
            // would like to close that gap by about 30% less. It is not aparent what to adjust.
            // It looks like the ScrollView is operating at it's full height with no padding,
            // so I'm suspecting the Text item to be the issue. Almost looks like it is
            // displaying an extra line with no text as the size matches for that.
            // Line limit set to 1 had no effect and it should not have so that is good.
            // I think it is some padding, spacing or framing associated with the Text view.
            // TODO: Continue to look for a solution but it is OK for now. Minor issue.
            
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
    } // var body View
    
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
        
    }  // var Body View
}  // CardView


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 mini")
//            .previewDevice("iPhone 6s Plus")
            .preferredColorScheme(.dark)  // Comment this out for .light, which is the default.
    }
}


/**/
