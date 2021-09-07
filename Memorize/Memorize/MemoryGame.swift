//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/23/21.
//
// This file is the Model of the Memorize! game. The ViewModel is currently EmojiMemoryGame.
//
// In the future we might also have an ImageMemoryGame to support image format card symbols.
// This architecture is to illustrate and leverage Swift Generics. CardSymbol is a Generic.
// CardSymbol is provided/defined by the ViewModel EmojiMemoryGame and is the String (Emoji) type.

import Foundation


struct MemoryGame<CardSymbol> {
    // private(set) - means ViewModels (users of this model) may only read this.
    private(set) var cards: Array<Card>
    
    
    func choose(_ card: Card) {
        
    }
    
    init(pairsCount: Int, createCardSymbol: (Int) -> CardSymbol) {
        cards = Array<Card>()
        for pairIndex in 0..<pairsCount {
            let symbol = createCardSymbol(pairIndex)
            cards.append(Card(cardSymbol: symbol))
            cards.append(Card(cardSymbol: symbol))
        }
        
    }
    
    
    struct Card {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var cardSymbol: CardSymbol
    }
    
    
    
    
    
}

