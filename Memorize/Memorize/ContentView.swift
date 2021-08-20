//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


struct ContentView: View {
    @State var deckIcons = deckBeasts.cards.shuffled()
    @State var iconCount = deckBeasts.cards.count
    
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
                themeTravelButton
                Spacer()
                themeFoodButton
                Spacer()
                themeAnimalButton
                Spacer()
                themePlantsButton
            }
        }  // VStack
    }
    
    
    var themeTravelButton: some View {
        VStack {
            let deck = deckWheels
            let symbol = "car"
            Button {
                deckIcons = deck.cards.shuffled()
                iconCount = deck.cards.count
                print("Deck set to \(deck.name) and shuffled. Cards: \(iconCount)")
            } label: {
                Image(systemName: symbol)
            }
            .font(.largeTitle)
            
            Text(deck.name)
                .font(Font.custom("AmericanTypewriter-Bold", size: 16.0))
                .foregroundColor(Color.purple)
        }
        .padding(.horizontal, 10)
    }
    
    var themeFoodButton: some View {
        VStack {
            let deck = deckFood
            let symbol = "house"
            Button {
                deckIcons = deck.cards.shuffled()
                iconCount = deck.cards.count
                print("Deck set to \(deck.name) and shuffled. Cards: \(iconCount)")
            } label: {
                Image(systemName: symbol)
            }
            .font(.largeTitle)
            
            Text(deck.name)
                .font(Font.custom("AmericanTypewriter-Bold", size: 16.0))
                .foregroundColor(Color.purple)
        }
        .padding(.horizontal, 10)
    }
    
    var themeAnimalButton: some View {
        VStack {
            let deck = deckCritters
            let symbol = "person"
            Button {
                deckIcons = deck.cards.shuffled()
                iconCount = deck.cards.count
                print("Deck set to \(deck.name) and shuffled. Cards: \(iconCount)")
            } label: {
                Image(systemName: symbol)
            }
            .font(.largeTitle)
            
            Text(deck.name)
                .font(Font.custom("AmericanTypewriter-Bold", size: 16.0))
                .foregroundColor(Color.purple)
        }
        .padding(.horizontal, 10)
    }
    
    var themePlantsButton: some View {
        VStack {
            let deck = deckPlants
            let symbol = "leaf"
            Button {
                deckIcons = deck.cards.shuffled()
                iconCount = deck.cards.count
                print("Deck set to \(deck.name) and shuffled. Cards: \(iconCount)")
            } label: {
                Image(systemName: symbol)
            }
            .font(.largeTitle)
            
            Text(deck.name)
                .font(Font.custom("AmericanTypewriter-Bold", size: 16.0))
                .foregroundColor(Color.purple)
        }
        .padding(.horizontal, 10)
    }
}  // ContentView


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
