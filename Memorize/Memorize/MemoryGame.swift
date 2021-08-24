//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/23/21.
//

import Foundation

// CONTINUE:
// https://youtu.be/--qKOhdgJAs?list=PLpGHT1n4-mAsxuRxVPv7kj4-dQYoC3VVu&t=3776


struct MemoryGame<CardSymbol> {
    // private(set) - means ViewModels (users of this model) may only read this.
    private(set) var cards: Array<Card>
    
    
    func choose(_ card: Card) {
        
    }
    
    init(numberOfPairOfCards: Int) {
        cards = Array<Card>()
        // add the pairs
        
    }
    
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var cardSymbol: CardSymbol
    }
    
    
}

