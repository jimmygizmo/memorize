//
//  StateTimerView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/31/21.
//

// I found this tutorial to be interesting and relevant. I especially noticed how he used
// A very small amount of code to set up an async timer to update a view and I've thought
// of some things I will need functionality like this for. Found this tutorial during my
// research of @Published, ObservableObject and ObservedObject. NOTE: This tut is older and
// refers to @ObjectBinding etc. but the latest Swift uses 'Observable' not 'Binding' etc.

// SwiftUI Tutorial: What's the difference between @State, @ObjectBinding, and @EnvironmentObject?
// https://www.youtube.com/watch?v=stSB04C4iS4

// The author's channel has a lot of good tutorials: Paul Hudson
// https://www.youtube.com/channel/UCmJi5RdDLgzvkl3Ly0DRMlQ

// ALSO - BONUS!! See more of this tut, it has some cool stuff but I might only use the first
// part in this code. I am using this tut for making a custom view modifier, but it goes a bit
// further than I am including in this code here, because I want to move on for now from the
// quick @State tutorial. Will turn back to this one later:
// https://www.avanderlee.com/swiftui/conditional-view-modifier/


import SwiftUI


struct StateTimerView: View {
    // var isActivated = false  // If this was simply a var, since this is a struct, we would
    //   get this error: Cannot use mutating member on immutable value: 'self' is immutable
    // This error is triggered by self.isActivated.toggle().  So we use @State:
    @State var isActivated = false
    //
    
    var body: some View {
        Button(action: {
            self.isActivated.toggle()
        }) {
            Text("TOGGLE BUTTON")
                .padding()
                // We have deviated from the @State tut here and thrown in the custom conditional
                // view modifier 'if':
                .if(isActivated) { view in
                    view.background(Color.green)
                }
        }
    }
}  // StateTimerView


// TODO: Quick idea is that I want the text button background to change based on the boolean
// toggle state.
// Is this similar to what was done for CS193P/Memorize game for changing the cards etc?
// https://www.avanderlee.com/swiftui/conditional-view-modifier/
// CREATE A CONDITIONAL VIEW MODIFIER EXTENSION

// Extension of View - View Modifier ON/OFF - Adds a new 'if' method.
extension View {
    // Applies the given (transform) if the given (condition) evaluates to true.
    // - condition: An expression that evaluates to a Bool
    // - transform: The transform (view modifier) to apply to the source View.
    // Returns: The original View OR the modified View.
    // ---- This extension gives us a new 'if' method to use on any View.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool,
                                          transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)  // Implied return
        } else {
            self  // Implied return
        }
        
    } // @ViewBuilder
}  // Extension of View - View Modifier ON/OFF


struct StateTimerView_Previews: PreviewProvider {
    static var previews: some View {
        StateTimerView()
            .previewDevice("iPhone 12 mini")
//            .previewDevice("iPhone 6s Plus")
            .preferredColorScheme(.dark)  // Comment this out for .light, which is the default.
    }
}


/**/
