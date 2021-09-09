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


extension String {
    // A few comments about making this extension. 1. It was necessary to coerce the result
    // of reversed() back into String because it is actually a 'reversed collection', not String.
    // 2. I tried to inline more of this and not create additional vars but I was getting errors
    // until I broke thinks out into the separate vars for the different steps. Anyhow it does
    // make things very clear to understand.
    func leftPadding(toLength len: Int, withPad character: String) -> String {
        let revStr = String(self.reversed())
        let rightPaddedRevStr = revStr.padding(toLength: len, withPad: " ", startingAt: 0)
        return String(rightPaddedRevStr.reversed())
        // Note this is missing the  startingAt:  argument/feature of .padding(). I could
        // probably support that without too much difficulty with a few additions to this
        // extension, but I may never need that.
    }
}


struct MemoryGame<CardSymbol> {
    // private(set) - means ViewModels (users of this model) may only read this.
    private(set) var cards: Array<Card>
    // let paddedStr = str.padding(toLength: 20, withPad: " ", startingAt: 0)
    func choose(_ card: Card) {
        // The padding of 2 spaces will work for up to 100 cards.
        // Swift only offers this right-padding. You have to roll-your-own for left-padding.
        // My idea: 1. Reverse. 2. Left-pad with built-in. 3. Reverse again and voila!
        // No one seems to have thought of this on Stackexchange lol.
        // Not super efficient but neiter are most of the suggestions on stack exchange and
        // for sure nothing so fresh and so clean.
        // TODO: Make a StackOverflow account and post this suggestion on this thread:
        // https://stackoverflow.com/questions/32338137/padding-a-swift-string-for-printing
        // UPDATE: I have made an extension for this and we can now try both:
        //let rightPaddedId = String(card.id).padding(toLength: 4, withPad: " ", startingAt: 0)
        let leftPaddedId = String(card.id).leftPadding(toLength: 4, withPad: " ")
        print("choose(card) - id: \(leftPaddedId) cardSymbol: \(card.cardSymbol)")
    }
    
    init(pairsCount: Int, createCardSymbol: (Int) -> CardSymbol) {
        cards = Array<Card>()
        for pairIndex in 0..<pairsCount {
            let symbol = createCardSymbol(pairIndex)
            cards.append(Card(cardSymbol: symbol, id: pairIndex*2))
            cards.append(Card(cardSymbol: symbol, id: pairIndex*2+1))
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var cardSymbol: CardSymbol
        
        //var id: ObjectIdentifier  // Default stub provides this.
        var id: Int  // But we want Int.
    }
    
    
    
    
    
}

