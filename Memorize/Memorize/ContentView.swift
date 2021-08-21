//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


// AVAILABLE DECKS: deckWheels, deckFood, deckCritters, deckBeasts, deckPlants
var initialDeck = deckBeasts
var randomizeSymbolCount = true


struct ContentView: View {
    // These variables are made @State so that the child DeckButtonView()s can change these.
    // Just as importantly, changing a @State var here triggers the updating of the View.
    @State var cardSymbols: [String]
    @State var symbolCount: Int
    
    init() {
        cardSymbols = initialDeck.cardSymbols.shuffled()
        symbolCount = randomizeSymbolCount ? Int.random(in: 4..<initialDeck.cardSymbols.count) :
            initialDeck.cardSymbols.count
        
        print("First deck initialized to \(initialDeck.name) and shuffled.")
        print("  Using \(symbolCount) of \(initialDeck.cardSymbols.count) cards available.")
    }
    
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
                    ForEach(cardSymbols[ 0 ..< symbolCount ], id: \.self) { cardIcon in
                        CardView(iconCharacter: cardIcon, isFaceUp: true)
                            .aspectRatio(0.618, contentMode: .fit)
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
    var deck: Deck
    // @Binding enables writing to ContentView.deckIcons and ContentView.iconCount
    // Additionally, we had to put a $ in front of those vars where this view builder is called.
    @Binding var cardSymbols: [String]
    @Binding var symbolCount: Int
    
    var body: some View {
        VStack {
            Button {
                cardSymbols = deck.cardSymbols.shuffled()
                symbolCount = randomizeSymbolCount ?
                    Int.random(in: 4..<initialDeck.cardSymbols.count) :
                    initialDeck.cardSymbols.count
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
    var iconCharacter: String
    @State var isFaceUp: Bool
    
    var body: some View {
        ZStack {
            let cardShape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {  //  ------------------------ |FRONT|, face up
                cardShape.fill().foregroundColor(.green)
                cardShape.strokeBorder(lineWidth: 3)
                
                Text(iconCharacter).font(.largeTitle)
                    .shadow(color: .black, radius: 28)
                    .shadow(color: .black, radius: 12)
                
            } else {  //  ----------------------------- |BACK|, face down
                cardShape.fill().foregroundColor(.blue)
                cardShape.strokeBorder(lineWidth: 3)
                
            }
            
        }  // ZStack
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
            .preferredColorScheme(.dark)  // Comment this out for .light, which is the default.
    }
}

