//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/23/21.
//
// This file is the ViewModel of the Memorize! game.

// Important lecture point: INTENTS LIVE IN THE ViewModel.
// https://youtu.be/oWZOFSYS5GE?list=PLpGHT1n4-mAsxuRxVPv7kj4-dQYoC3VVu&t=1166

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
    
    static func createMemoryGame() -> MemoryGame<String> {
            MemoryGame<String>(pairsCount: 7) { pairIndex in
            EmojiMemoryGame.deckSymbols[pairIndex]
            // CORRECTION COMING - My tests have put the following comments taken from the lecture
            // into question. I need to test more on the following but the behavior I see is
            // different from what I documented from the lecture. It may have changed or there
            // may be some other nuance I need to address:
            //
            // BECAUSE this is a static func and I am trying to access a static member,
            // Swift will fill in the 'EmojiMemoryGame' for me and allow me to just put this here:
            // deckSymbols[pairIndex]
            // However, in normal INSTANCE functions, I will have to fully qualify that I am
            // accessing the STATIC TYPE PROPERTY and specify fully as:
            // EmojiMemoryGame.deckSymbols[pairIndex]
            //
            // TODO" IS THIS REALLY TRUE? From the lecture. Testing the non-fully-qualified
            // form below here produces no error but maybe this is just for private? I would
            // not think access control is related to this but??
            // NO ERROR:
            // private var model: MemoryGame<String> = createMemoryGame()
            // //private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        }
    }
    
    // IT IS NOT UNCOMMON FOR THE ViewModel TO CREATE/INSTANTIATE THE Model AS IS DONE HERE:
    //
    // Because this is the Emoji version, the type for the MemoryGame generic is String:
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    //private var model: MemoryGame<String> = createMemoryGame() // THIS WORKS TOO!
    // NOTE: Because this is a class property, we MUST provide a value, here or in an init().
    // We have placeholders for the Int and the func with static values but that will change soon.
    //
    // ALSO, specifying the 'EmojiMemoryGame.__' appears to be optional here, but I'm not perfectly
    // clear as to why, since it sort of looks like an instance variable calling a type/static
    // function and I thought in those cases, full qualification was enforced.
    //
    // SO .. This is currently the only var we have AND we are initializing it with a call to
    // our own custom function for this purpose; createMemoryGame().
    // This function CREATES THE MODEL. IT TAKES NO ARGUMENTS. IT RETURNS A MemoryGame struct,
    // which has been customized through generics for 'emoji' decks/cards (String) for the
    // cardSymbol data payload. (Our generic CardSymbol can be considered a generic data payload.)
    
    // A GOOD WAY TO REMEMBER AN IMPORTANT FEATURE OF SWIFT:
    // Structs get a free init() that initializes all vars. Classes get a free init that does
    // nothing more than create an instance, so you will have to provide values to those vars
    // EITHER in the definition/accessors OR by making a custom init().
    // TODO: Consider the nuances. Other ways to initialize class members/properties/vars?
    
    // Remember Card is a struct so when we return this, the caller is getting its own copy.
    // Clearly this means it is read only as a result. Arrays are structs too for that matter.
    // This function can in no way change model or model.cards.
    // This is a variable defined as its type AND initialized to BE A FUNCTION. I see no way that
    // such variables can take any arguments, but other than that I see no limitations.
    // TODO: It would be good to clarify a bit more about these and even what best to call them.
    var cards: Array<MemoryGame<String>.Card> {
        //return model.cards  // The return is implied so:
        model.cards
    }
    
    
    //init() {
    
    
    // At this point in lecture, he has made first instantiation of this class and is simply
    // using the built-in "free" init this class provides. Remember, all class members must
    // be initialized one way or another.
    // https://youtu.be/oWZOFSYS5GE?list=PLpGHT1n4-mAsxuRxVPv7kj4-dQYoC3VVu&t=238
    
        
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
    
    // MARK: - Intent(s)
    
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    
}  // EmojiMemoryGame

