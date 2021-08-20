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
    let cards: [String]
}


let deckWheels = Deck(id: "wheels",
                      name: "Wheels",
                      icon: "🚙",
                      cards: [ "🚗", "🚜", "✈️", "⛵️", "🛸", "🛻", "🚂", "🚃", "🚲", "🚁",
                               "🛴", "🚤", "🚙", "🚕", "🏎", "🚎", "🚀", "🛺", "🛼", "🚚",
                               "🛹", "🚌", "🛵", "🚒", "🛥", "🚛" ]
)


let deckFood = Deck(id: "food",
                    name: "Food",
                    icon: "🍕",
                    cards: [ "🍑", "🫐", "🍌", "🍕", "🫑", "🥓", "🧁", "🌮", "🍗", "🍓",
                             "🍦", "🍩", "🥪", "🍪", "☕️", "🍚", "🍭", "🍔", "🥕", "🍍",
                             "🫒", "🍒", "🍰", "🌭", "🍉", "🥖", "🥝", "🥑" ]
)


let deckCritters = Deck(id: "critters",
                        name: "Critters",
                        icon: "🦋",
                        cards: [ "🐇", "🦞", "🦦", "🪰", "🦉", "🐟", "🪲", "🐀", "🦋", "🐥",
                                 "🐿", "🐊", "🐢", "🐸", "🦂", "🦀", "🦜", "🦫", "🦎" ]
)


let deckBeasts = Deck(id: "beasts",
                      name: "Beasts",
                      icon: "🐘",
                      cards: [ "🐏", "🦩", "🐳", "🐈", "🐗", "🐓", "🐖", "🦢", "🐅", "🐘",
                               "🦝", "🦧", "🦃", "🦥", "🦙", "🦍", "🐪", "🦘", "🦈", "🦌",
                               "🐊" ]
)


let deckPlants = Deck(id: "plants",
                      name: "Plants",
                      icon: "🍀",
                      cards: [ "🍀", "☘️", "🌷", "🍄", "🌹", "🌸", "🌻", "🌾", "🍁", "🌵",
                               "🌲", "🌳", "🌴", "🪴", "🌺", "🌼", "🍂", "🌿" ]
)

