//
//  TwoWayStateView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/1/21.
//

// Continuation of work for the @State tutorial:
// https://youtu.be/stSB04C4iS4?t=353

// Covering two-way bindings. The tutorial will mention 'binding', but is an older tutorial.
// Some things in Swift now use the term 'observable' for some of these things.
// He discusses doller-some-property = $someProperty. ($ indicates two-way)
//


import SwiftUI


struct TwoWayStateView: View {
    @State var userName = "Taylor"
    

    var body: some View {
        TextField("label", text: $userName)
            .padding()
            .border(Color.white)
        // NOTE: The tutorial is older and it is hard to tell, but might be showing that only
        // one arg is required for TextField in this older Swift. I'm not sure at all. Anyhow,
        // currently it requires two args minimum (unless I am mistaken) the unnamed first arg
        // is a label and the other required arg is text: String
        
    }  // var body View
    
}  // TwoWayStateView


struct TwoWayStateView_Previews: PreviewProvider {
    static var previews: some View {
        TwoWayStateView()
    }
}


/**/
