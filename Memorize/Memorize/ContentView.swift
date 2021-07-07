//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView(isFaceUp: true)
            CardView(isFaceUp: true)
            CardView(isFaceUp: true)
        }
        .padding(.horizontal)
    }
}


struct CardView: View {
    var isFaceUp: Bool
//    var isFaceUp: Bool { return false }  // This is how we would assign/hardcode a value here.
// Since we do not set a vale above, this becomes like a required argument to CardView() since it
// must have a value set by assignment or evaluation here or by passing as an argument.
    
    var body: some View {
//        return ZStack (alignment: .top, content: {    // Longer form. A ) would be after }.
//        Zstack (alignment: .top) {...}    // Another variant. content: implied.
        ZStack {
            let card_shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                // TODO: CONFIRM: It looks like ZStack is painting the components from bottom to top,
                // meaning from the device to the user, while the code itself is the opposite, from
                // top to bottom.
                card_shape.fill().foregroundColor(.gray)
                
                card_shape.stroke(lineWidth: 3)
                
                Text("🚜").font(.largeTitle)
            } else {
                card_shape.fill().foregroundColor(.gray)
            }
        }  // ZStack
        .foregroundColor(.orange)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 mini")
//            .previewDevice("iPhone 6s Plus")
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
//            .preferredColorScheme(.light)
    }
}


/**/
