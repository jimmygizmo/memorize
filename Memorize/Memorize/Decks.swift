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


// The CS193 code uses the word 'content' where I use 'cardSymbol'. I think it is better to be
// more specific and more unique as this helps with searching, debugging and if you name things
// well, reading comprehension of code and it's intended functionality. Additionally, I may
// choose to manage/store multiple sets of 'symbols' here and I might have:
// cardEmojiSymbols: [String]
// cardImageSymbols: [Image]
// cardImageSymbols would likely have an initializer that imported image files or equivalent.
// TODO: Although we might not implement image support for a while or ever, it is necessary to
// plan ahead and come up with a good design and good names so such extensions are well supported.
// DESIGN DECISION: Have two differently named vars in this struct to support the different
// types .. OR .. use an Array of generics? Let's see what is closer to what CS193P does.
// Currently getting close to code for that in Lecture 3 on MVVM.


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

