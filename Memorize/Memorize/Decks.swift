//
//  Decks.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/19/21.
//

import Foundation


struct Deck {
    let id: String
    let name: String
    let icon: String
    let cardSymbols: [String]
}

// * Decks must have at least 4 symbols in their cardSymbols array.
// Symbols are initially just Emoji String characters, but we will use generics to support the
// option to use images as card symbols. There will still need to be a minimum of 4 in each deck.


let deckWheels = Deck(id: "wheels",
                      name: "Wheels",
                      icon: "🚙",
                      cardSymbols: [ "🚗", "🚜", "✈️", "⛵️", "🛸", "🛻", "🚂", "🚃", "🚲", "🚁",
                                     "🛴", "🚤", "🚙", "🚕", "🏎", "🚎", "🚀", "🛺", "🛼", "🚚",
                                     "🛹", "🚌", "🛵", "🚒", "🛥", "🚛" ]
                      // Wheels count: 26
)


let deckFood = Deck(id: "food",
                    name: "Food",
                    icon: "🍕",
                    cardSymbols: [ "🍑", "🫐", "🍌", "🍕", "🫑", "🥓", "🧁", "🌮", "🍗", "🍓",
                                   "🍦", "🍩", "🥪", "🍪", "☕️", "🍚", "🍭", "🍔", "🥕", "🍍",
                                   "🫒", "🍒", "🍰", "🌭", "🍉", "🥖", "🥝", "🥑" ]
                    // Food count: 28
)


let deckCritters = Deck(id: "critters",
                        name: "Critters",
                        icon: "🦋",
                        cardSymbols: [ "🐇", "🦞", "🦦", "🪰", "🦉", "🐟", "🪲", "🐀", "🦋", "🐥",
                                       "🐿", "🐊", "🐢", "🐸", "🦂", "🦀", "🦜", "🦫", "🦎" ]
                        // Critters count: 19
)


let deckBeasts = Deck(id: "beasts",
                      name: "Beasts",
                      icon: "🐘",
                      cardSymbols: [ "🐏", "🦩", "🐳", "🐈", "🐗", "🐓", "🐖", "🦢", "🐅", "🐘",
                                     "🦝", "🦧", "🦃", "🦥", "🦙", "🦍", "🐪", "🦘", "🦈", "🦌",
                                     "🐊" ]
                      // Beasts count: 21
)


let deckPlants = Deck(id: "plants",
                      name: "Plants",
                      icon: "🍀",
                      cardSymbols: [ "🍀", "☘️", "🌷", "🍄", "🌹", "🌸", "🌻", "🌾", "🍁", "🌵",
                                     "🌲", "🌳", "🌴", "🪴", "🌺", "🌼", "🍂", "🌿" ]
                      // Plants count: 18
)

