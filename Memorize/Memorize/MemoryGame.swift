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
    // TODO: Post this on:
    // https://stackoverflow.com/questions/32338137/padding-a-swift-string-for-printing
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
// MORE THOUGHTS: Because some languages move right to left and Swift's String is
// language-agnostic, we should not use semantics of left/right but instead leading/trailing.
// We should make this extension be leadPadding, leadingPad or leadingPadded etc.
// The default of padding() is in fact a trailing padding (in the language-agnostic sense.)
// As far as supporting startingAt, this is a bit more complex than one might realize.
// startingAt actually refers to the index of the PADDING STRING to start padding at.
// See Apple's reference:
// https://developer.apple.com/documentation/foundation/nsstring/1416395-padding
// Because you can pad with multi-character strings, and our extension currently simply
// pads in-between the two reversed() calls, really this does not work, because we would
// need to reverse the padding string as well. But there is more. We need to interpret the
// startingAt correctly for the "frontPadding" extension we are designing here.
// Writing an extension like this correctly so it works in the spirit, conventions and expectations
// of the rest of Swift is an interesting exercist. TODO: Complete this.
// * frontPadding() is the best name idea IMO. lead/leading just sounds bad next to 'padding'.
// With respect to existing conventions in Swift, perhaps it should be: leadingPadding()


struct MemoryGame<CardSymbol> {
    // private(set) - means ViewModels (users of this model) may only read this.
    private(set) var cards: Array<Card>
    
    // NOTE: ALL ARGUMENTS TO FUNCTIONS ARE -LETS-, SO THIS card INSIDE FUNC IS -IMMUTABLE-.
    // And even furthermore immutable because this a struct and structs are copied. Even if you
    // could change it, you would be changing the copied struct, not the original. To make a point,
    // the lecture is at first trying to change the card argument from inside, but there are
    // multiple problems that need to be solved to actually change the cards .. or rather to
    // affect the correct card data and trigger the UI update, which is the more accurate way of
    // describing what needs to happen.
    func choose(_ card: Card) {
        // The padding of 2 spaces will work for up to 100 cards.
        // Swift only offers this right-padding. You have to roll-your-own for left-padding.
        // My idea: 1. Reverse. 2. Left-pad with built-in. 3. Reverse again and voila!
        // No one seems to have thought of this on Stackexchange lol.
        // Not super efficient but neiter are most of the suggestions on stack exchange and
        // for sure nothing so fresh and so clean.
        // TODO: Make a StackOverflow account and post this suggestion on this thread:
        // https://stackoverflow.com/questions/32338137/padding-a-swift-string-for-printing
        // UPDATE: I have made an extension for this and we can use either:
        //let rightPaddedId = String(card.id).padding(toLength: 2, withPad: " ", startingAt: 0)
        let leftPaddedId = String(card.id).leftPadding(toLength: 2, withPad: " ")
        print("choose(card) - id: \(leftPaddedId) cardSymbol: \(card.cardSymbol)")
        
        // LECTURE POINT BEING ILLUSTRATED. IF WE ATTEMPT THE FOLLOWING HERE:
        //card.isFaceUp.toggle()
        // WE WILL GET THIS ERROR:
        // Cannot use mutating member on immutable value: 'card' is a 'let' constant
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

