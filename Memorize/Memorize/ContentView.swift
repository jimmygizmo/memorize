//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


// AVAILABLE DECKS: deckWheels, deckFood, deckCritters, deckBeasts, deckPlants
var initialDeck = deckBeasts


struct ContentView: View {
    // These variables are made @State so that the child DeckButtonView()s can change these.
    // Just as importantly, changing an @State here triggers the updating of the View.
    @State var deckIcons = initialDeck.cards.shuffled()
    @State var iconCount = initialDeck.cards.count
    
    init() {
        print("First deck initialized to \(initialDeck.name) and shuffled. Cards: \(iconCount)")
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
                    ForEach(deckIcons[ 0 ..< iconCount ], id: \.self) { cardIcon in
                        CardView(iconCharacter: cardIcon, isFaceUp: true)
                            .aspectRatio(0.618, contentMode: .fit)
                    }
                }
                .padding(.horizontal)
                .foregroundColor(.purple)
                
            }
                
            Spacer()
            
            HStack(alignment: .bottom) {
                DeckButtonView(deck: deckWheels, deckIcons: $deckIcons, iconCount: $iconCount)
                Spacer()
                DeckButtonView(deck: deckFood, deckIcons: $deckIcons, iconCount: $iconCount)
                Spacer()
                DeckButtonView(deck: deckCritters, deckIcons: $deckIcons, iconCount: $iconCount)
                Spacer()
                DeckButtonView(deck: deckPlants, deckIcons: $deckIcons, iconCount: $iconCount)
            }
        }  // VStack
    }
    
    // This original approach works fine. (First two decks: Wheels and Food)
    var themeTravelButton: some View {
        VStack {
            let deck = deckWheels
            Button {
                deckIcons = deck.cards.shuffled()
                iconCount = deck.cards.count
                print("Deck set to \(deck.name) and shuffled. Cards: \(iconCount)")
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
    
    // This original approach works fine. (First two decks: Wheels and Food)
    var themeFoodButton: some View {
        VStack {
            let deck = deckFood
            Button {
                deckIcons = deck.cards.shuffled()
                iconCount = deck.cards.count
                print("Deck set to \(deck.name) and shuffled. Cards: \(iconCount)")
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
    
    // Returned this button to the working strategy. Using globals from here did not work.
    // (This was a control test, done while trying to get DeckButton() to work with golbals.)
    var themeAnimalButton: some View {
        VStack {
            let deck = deckCritters
            Button {
                deckIcons = deck.cards.shuffled()
                iconCount = deck.cards.count
                print("Deck set to \(deck.name) and shuffled. Cards: \(iconCount)")
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
    
    // This button currently not used so the new dynamic DeckButton() can be tested.
    var themePlantsButton: some View {
        VStack {
            let deck = deckPlants
            Button {
                deckIcons = deck.cards.shuffled()
                iconCount = deck.cards.count
                print("Deck set to \(deck.name) and shuffled. Cards: \(iconCount)")
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
}  // ContentView


struct DeckButtonView: View {
    var deck: Deck
    // @Binging enables writing to ContentView.deckIcons and ContentView.iconCount
    // Additionally, we had to put a $ in front of those vars where this view builder is called.
    @Binding var deckIcons: [String]
    @Binding var iconCount: Int
    
    var body: some View {
        VStack {
            Button {
                deckIcons = deck.cards.shuffled()
                iconCount = deck.cards.count
                print("Deck set to \(deck.name) and shuffled. Cards: \(iconCount)")
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
