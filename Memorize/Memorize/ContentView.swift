//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


struct ContentView: View {
    var viewModel: EmojiMemoryGame  // A more typical name for this var might be 'game'.

// DISABLED AT START OF TRANSITION TO NEW MVVM
//    // These variables are made @State so that the child DeckButtonView()s can change these.
//    // Just as importantly, changing a @State var here triggers the updating of the View.
//    @State var cardSymbols: [String]
//    @State var symbolCount: Int
    
    var body: some View {
        VStack {
            
            Text("Memorize!")
                .offset(y: 8)  // Most/all devices look better with title nudged down slightly.
                .font(Font.custom("AmericanTypewriter-Bold", size: 24.0))
                .foregroundColor(Color.purple)
                // TODO: Eliminate fixed font sizes in app code:  /notes/font-sizes.txt
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 65))
                ]) { 
                    ForEach(cardSymbols[ 0..<symbolCount ], id: \.self) { cardIcon in
                        CardView(iconCharacter: cardIcon, isFaceUp: true)
                            .aspectRatio(0.618, contentMode: .fit)  // The Golden Ratio
                    }
                }
                .padding(.horizontal)
                .foregroundColor(.purple)
                
            }
                
            Spacer()
            
            HStack(alignment: .bottom) {
                DeckButtonView(deck: deckWheels,
                               cardSymbols: $cardSymbols,
                               symbolCount: $symbolCount)
                Spacer()
                DeckButtonView(deck: deckFood,
                               cardSymbols: $cardSymbols,
                               symbolCount: $symbolCount)
                Spacer()
                DeckButtonView(deck: deckCritters,
                               cardSymbols: $cardSymbols,
                               symbolCount: $symbolCount)
                Spacer()
                DeckButtonView(deck: deckPlants,
                               cardSymbols: $cardSymbols,
                               symbolCount: $symbolCount)
            }
        }  // VStack
    }
}  // ContentView


struct DeckButtonView: View {
    let deck: Deck
    // @Binding enables writing to ContentView.cardSymbols and ContentView.symbolCount
    // Additionally, we had to put a $ in front of those vars where this view builder is called.
    @Binding var cardSymbols: [String]
    @Binding var symbolCount: Int
    
    var body: some View {
        VStack {
            Button {
                cardSymbols = deck.cardSymbols.shuffled()
                // TODO determine if a=b.shuffled() affects b?
                // In our case it does not matter so much, but VERY important to
                // understand, because Swift ALSO has Array.shuffle().
                // CS193 professor mentions that using Array.shuffled() is preferred.
                // TODO: Research and fully understand this topic as it will be
                // simple to master but very important in many real world scenarios.
                // Great interview topic too.
                symbolCount = randomizeSymbolCount ?
                    Int.random(in: 4..<deck.cardSymbols.count) :
                    deck.cardSymbols.count
                print("Deck set to \(deck.name) and shuffled.")
                print("  Using \(symbolCount) of \(deck.cardSymbols.count) cards available.")
            } label: {
                Text(deck.icon)
                    .font(.largeTitle)
            }
            .font(.largeTitle)
            
            Text(deck.name)
                .font(Font.custom("AmericanTypewriter-Bold", size: 16.0))
                .foregroundColor(Color.purple)
        }
        .padding(.horizontal, 10)
    }
}  // DeckButtonView


struct CardView: View {
    
// DISABLED AT START OF TRANSITION TO NEW MVVM
//    var iconCharacter: String
//    @State var isFaceUp: Bool
    
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {  //  ------------------------ |FRONT|, face up
                cardShape.fill().foregroundColor(.green)
                cardShape.strokeBorder(lineWidth: 3)
                    
                // MVVM TRANSITION
                //Text(iconCharacter).font(.largeTitle)
                Text("🍉").font(.largeTitle)
                    .shadow(color: .black, radius: 28)
                    .shadow(color: .black, radius: 12)
                
            } else {  //  ----------------------------- |BACK|, face down
                cardShape.fill().foregroundColor(.blue)
                cardShape.strokeBorder(lineWidth: 3)
                
            }
            
        }  // ZStack
// DISABLED AT START OF TRANSITION TO NEW MVVM
//        .onTapGesture {
//            isFaceUp = !isFaceUp
//        }
    }
}  // CardView


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // startCardSymbols and startSymbolCount are set in MemorizeApp.swift
        //ContentView(cardSymbols: startCardSymbols, symbolCount: startSymbolCount)
        // Above here was pre-MVVM with the button-deck switching.
        //
        // MVVM addition:
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .previewDevice("iPhone 12 mini")
//            .previewDevice("iPhone 6s Plus")
            .preferredColorScheme(.dark)  // Comment this out for .light, which is the default.
    }
}

