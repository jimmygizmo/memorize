//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


// This is a hack and an attempt to use a global variable to allow the dynamically-generated
// deck buttons to set variables back in the ContentView, which is a separate struct.
// Obviously the wrong way to do this, but ok as a quick intermediate step to allow the refactoring
// of the deck buttons to be completed. A lot of this will change anyhow as we are about to
// start implementing the MVVM game logic.
var globalDeckIcons = deckBeasts.cards.shuffled()
var globalIconCount = deckBeasts.cards.count
// DOES NOT WORK. CODE DOES NOT ERROR AND REFACTORING CAN COMPLETE BUT THE BUTTONS MADE WITH
// THE NEW DYNAMIC VIEW DO NOT CHANGE THE UI AND THE CARDS. NOTHING CHANGES. THIS MEANS THE
// ContentView IS NOT SEEING THE DATA CHANGE TO THESE GLOBAL VARIABLES.


struct ContentView: View {
    @State var deckIcons = globalDeckIcons
    @State var iconCount = globalIconCount
    
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
                DeckButtonView(deckId: "plants")
            }
        }  // VStack
    }
    
    
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
    
    var themeAnimalButton: some View {
        VStack {
            let deck = deckCritters
            Button {
                globalDeckIcons = deck.cards.shuffled()
                globalIconCount = deck.cards.count
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



// THIS IS NOT YET WORKING. TRIED A HACKING USING GLOBAL VARIABLES TO GET CHANGES MADE IN THESE
// DYNAMICALLY GENERATED BUTTONS/VIEWS TO TRIGGER AN UPDATE WITH THE NEW DATA IN THE MAIN VIEW
// OF CARDS BUT IT IS NOT UPDATING ANY CHANGE WHEN CLICKED. I KNEW THE GLOBAL VARS WERE A VERY
// HACKISH AND BAD IDEA. Pondering on the correct solution ...
struct DeckButtonView: View {
    var deckId: String
    
    var body: some View {
        VStack {
            let deck = deckPlants
            Button {
                globalDeckIcons = deck.cards.shuffled()
                globalIconCount = deck.cards.count
                print("Deck set to \(deck.name) and shuffled. Cards: \(globalIconCount)")
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
