//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/23/21.
//
// This file is the ViewModel of the Memorize! game.

import SwiftUI


// TODO: THIS WILL BE REMOVED. It is here to make an illustrative commit while following lecture 3.
func makeCardSymbol(symbolIndex: Int) -> String {
    return "🐠"
}


class EmojiMemoryGame {
    // Becuse this is the Emoji version, the type for the MemoryGame generic is String:
    private var model: MemoryGame<String> = MemoryGame<String>(pairsCount: 4,
                                                               createCardSymbol: makeCardSymbol)
    // NOTE: Because this is a class property, we MUST provide a value, here or in an init().
    
    // AN ACCESSOR STRATEGY
    // properties which you want to be private but want to allow reading of, could be made
    // private(set), but you could also make it completely 'private' and then make another
    // variable which is actually a little inline function, like this:
    //     var cards: Array<MemoryGame<String>.Card {
    //         return model.cards
    //     }
    // TODO: Comment here on how we use private(set) over in the model MemoryGame for 'cards'.
    
    // Remember Card is a struct so when we return this, the caller is getting its own copy.
    // Clearly this means it is read only as a result. Arrays are structs too for that matter.
    // This function can in no way change model or model.cards.
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    
}  // EmojiMemoryGame

