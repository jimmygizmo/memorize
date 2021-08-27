//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/23/21.
//
// This file is the ViewModel of the Memorize! game.

import SwiftUI


// WE COULD put this here:
// let deckSymbols = [ "🍀", "☘️", ... ]
// .. and it could be accessed before self BUT global vars are bad for many reasons. It is
// very similar to being a global and can be accessed before any instances exists and also
// it can be associated with it's namespace, IF we just make the property static.
// We dont call these static though, we call them TYPE VARIABLES, TYPE FUNCTIONS and TYPE CONSTANTS.


// AVAILABLE DECKS: deckWheels, deckFood, deckCritters, deckBeasts, deckPlants
//let startingDeck = deckBeasts  // NOT USING THIS YET
// This is named initialDeck in MemorizeApp.swift to resolve the re-declaration conflict. In a
// real App there would not be two and a conflict, but we have code living side by side in this
// project from multiple tutorials and multiple stages of CS193P, simultaneously.


class EmojiMemoryGame {
    
    /* HOLD: Putting on hold, button-deck switching etc. to follow the lectures.
    var deckName: String
    var cardSymbols: [String]
    var symbolCount: Int
     */
    
    // Putting some emojis here like this in order to follow the lecture, but this will get
    // more complex soon when we make the new MVVM version support button-deck-switching and
    // deck names for logging etc. (Usage of Decks.swift)
    static let deckSymbols = [ "🍀", "☘️", "🌷", "🍄", "🌹", "🌸", "🌻", "🌾", "🍁", "🌵",
    "🌲", "🌳", "🌴", "🪴", "🌺", "🌼", "🍂", "🌿" ]
    
    func createMemoryGame() -> MemoryGame<String> {
            MemoryGame<String>(pairsCount: 4) { pairIndex in
            EmojiMemoryGame.deckSymbols[pairIndex]  // Just deckSymbols[pairIndex] works too.
        }
    }
    
    // Because this is the Emoji version, the type for the MemoryGame generic is String:
    private var model: MemoryGame<String> = createMemoryGame()
    // NOTE: Because this is a class property, we MUST provide a value, here or in an init().
    // We have placeholders for the Int and the func with static value but that will change soon.

    
    // Remember Card is a struct so when we return this, the caller is getting its own copy.
    // Clearly this means it is read only as a result. Arrays are structs too for that matter.
    // This function can in no way change model or model.cards.
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    
    //init() {
        
        /* HOLD: Putting on hold, button-deck switching etc. to follow the lectures.
        //deckName = startingDeck.name
        // MemoryGame will be initializing the cardSymbols array, so it is not yet clear how to
        // resolve the need to initialize this property here, but I am jumping ahead of the lecture
        // a bit and starting early to add in the button-deck-selection feature.
        // Similarly, MemoryGame might also be setting symbolCount, but that is either the full
        // array size or it is randomized. Not clear where that will happen in the new MVVM,
        // but probably the buttons, then the initial init is separate, like in the non MVVM vers.
         */
        
    //}  // init
    
    
}  // EmojiMemoryGame

