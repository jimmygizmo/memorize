//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


let travelIcons = [ "🚗", "🚜", "✈️", "⛵️", "🛸", "🛻", "🚂", "🚃", "🚲", "🚁", "🛴", "🚤",
                  "🚙", "🚕", "🏎", "🚎", "🚀", "🛺", "🛼", "🚚", "🛹", "🚌", "🛵", "🚒",
                  "🛥", "🚛" ]  // count: 26

let foodIcons = [ "🍑", "🫐", "🍌", "🍕", "🫑", "🥓", "🧁", "🌮", "🍗", "🍓", "🍦", "🍩",
                  "🥪", "🍪", "☕️", "🍚", "🍭", "🍔", "🥕", "🍍", "🫒", "🍒", "🍰", "🌭",
                  "🍉", "🥖", "🥝", "🥑" ]  // count: 28

let animalIcons = [ "🐇", "🦞", "🦦", "🐏", "🪰", "🦩", "🦉", "🐟", "🪲", "🐳", "🐈", "🐀",
                  "🦋", "🐥", "🐗", "🐓", "🐿", "🐖", "🦢", "🐊", "🐅", "🐢", "🐸", "🐘",
                  "🦝", "🦧", "🦃", "🦂", "🦀", "🦜", "🦥", "🦙" ]  // count: 32


struct ContentView: View {
    @State var deckIcons = travelIcons.shuffled()
    @State var iconCount = travelIcons.count
    
    var body: some View {
        VStack {
            
            Text("Memorize!")  // TODO: Try to make all font sizes absolute. Best practice?
                .offset(y: 8)  // Most/all devices look better with title nudged down slightly.
                .font(Font.custom("AmericanTypewriter-Bold", size: 24.0))
                .foregroundColor(Color.purple)
            
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
            }
        }  // VStack
    }
    
    
    var themeTravelButton: some View {
        VStack {
            Button {
                deckIcons = travelIcons.shuffled()
                iconCount = travelIcons.count
                print("Deck set to Travel and shuffled. Cards: \(iconCount)")
            } label: {
                Image(systemName: "car")
            }
            .font(.largeTitle)
            
            Text("Travel")
                .font(Font.custom("AmericanTypewriter-Bold", size: 16.0))
                .foregroundColor(Color.purple)
        }
        .padding(.horizontal, 20)
    }
    
    var themeFoodButton: some View {
        VStack {
            Button {
                deckIcons = foodIcons.shuffled()
                iconCount = foodIcons.count
                print("Deck set to Food and shuffled. Cards: \(iconCount)")
            } label: {
                Image(systemName: "house")
            }
            .font(.largeTitle)
            
            Text("Food")
                .font(Font.custom("AmericanTypewriter-Bold", size: 16.0))
                .foregroundColor(Color.purple)
        }
        .padding(.horizontal, 20)
    }
    
    var themeAnimalButton: some View {
        VStack {
            Button {
                deckIcons = animalIcons.shuffled()
                iconCount = animalIcons.count
                print("Deck set to Animals and shuffled. Cards: \(iconCount)")
            } label: {
                Image(systemName: "person")
            }
            .font(.largeTitle)
            Text("Animals")
                .font(Font.custom("AmericanTypewriter-Bold", size: 16.0))
                .foregroundColor(Color.purple)
        }
        .padding(.horizontal, 20)
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
                cardShape.fill().foregroundColor(.gray)
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
