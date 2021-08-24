//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/23/21.
//
// This file is the ViewModel of the Memorize! game.

import SwiftUI


class EmojiMemoryGame {
    // Becuse this is the Emoji version, the type for the MemoryGame generic is String:
    private var model: MemoryGame<String>
    
    // AN ACCESSOR STRATEGY
    // properties which you want to be private but want to allow reading of, could be made
    // private(set), but you could also make it completely 'private' and then make another
    // variable which is actually a little inline function, like this:
    //     var cards: Array<MemoryGame<String>.Card {
    //         return model.cards
    //     }
    // TODO: Comment here on how we use private(set) over in the model MemoryGame for 'cards'.
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    init() {
        
    }
    
    
}  // EmojiMemoryGame

