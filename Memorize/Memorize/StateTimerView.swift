//
//  StateTimerView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/31/21.
//

// UPDATE: WILL BE USING AN ADDITIONAL CODE FILE FOR @State, Timer tutorial.
// This tutorial at this timing mark will be continued on the topic of two-way binding
// and SwiftUI read/write properties using $sign syntax:
// https://youtu.be/stSB04C4iS4?t=353
// If the tut or some interest of mine brings me back to the timers or conditional view modifiers,
// then I will continue in this file, otherwise this @State may conclude in the next code file
// I will start working on now:
// TwoWayStateView.swift

// - - - - - - - - - - - -

// I found this tutorial to be interesting and relevant. I especially noticed how he used
// A very small amount of code to set up an async timer to update a view and I've thought
// of some things I will need functionality like this for. Found this tutorial during my
// research of @Published, ObservableObject and ObservedObject. NOTE: This tut is older and
// refers to @ObjectBinding etc. but the latest Swift uses 'Observable' not 'Binding' etc.

// SwiftUI Tutorial: What's the difference between @State, @ObjectBinding, and @EnvironmentObject?
// https://www.youtube.com/watch?v=stSB04C4iS4

// The author's channel has a lot of good tutorials: Paul Hudson
// https://www.youtube.com/channel/UCmJi5RdDLgzvkl3Ly0DRMlQ

// ALSO - BONUS!! See more of this conditional modifier tutorial, it has some cool stuff
// but I might only use the first part in this code. I am using this tut for
// making a custom view modifier, but it goes a bit
// further than I am including in this code here, because I want to move on for now from the
// quick @State tutorial. Will turn back to this one later:
// https://www.avanderlee.com/swiftui/conditional-view-modifier/
// TODO: Come back to this for how to use @autoclosure and extensions to make this even more
// powerful!! The end result is a very concise systax which can solve the problem of needing
// many and possibly a variety of many custom CONDITIONAL view modifiers (with groups of view
// modifiers) all in a NEAT DESCRIPTIVE CONCISE SYNTAX.
// This is so good I will capture it in a separate file. It would be good to find additional
// tutorials on this. It reminds me of CSS classes.
// ANOTHER WAY TO RESTATE THE VALUE of what the above tutorial covers: Swift makes it easy to
// have conditional VIEWS and groups of VIEWS .. but not view modifiers. So without this solution,
// you might have to have a LOT of duplicated View code, just to capture changes to modifiers only.
// A valuable tool for sure, at least until SwiftUI introduces a similar feature.


// -------------------------------------------------------------------------------------------------
// Regarding @State, async timer tutorial work:
// INTERESTING OBSERVED BEHAVIOR - RACE CONDITIONS, NO LOCKING/THREAD-SAFETY IN THIS EXAMPLE.
// I did more than the tutorial and I have the timer incrementing the text value but also I have
// the boolean button which also causes a reload. Well, I clicked the button a bunch of times
// while the counter was going of course and what I saw was a little bit chaotic. The counter
// started incrementing MUCH faster. I could tell there were many independent async timers now
// ALL incrementing the count in a slightly random onslaught (randomized no doubt by each timer
// being started by a random touch from my rapidly tapping finder.) BUT there was another effect
// noted. While the values were rapidly and slightly randomly increasing at the rate of about
// 10 per second (implying about 10 simultaneous timers) OCCASIONALLY, maybe about 1 out of 10
// increments or about once per second, I would see the value go DOWN to the previous value
// (down by one, never two or more that I had observed) .. meaning there was some race condition
// with the storing/retreival of the actual count value, meaning not total thread-safety, meaning
// not an effective locking mechanism is in place on the @State variable.
// These are important things to note. We have an extremely simple implementation here with
// nothing mentioned about thread/timer simultaneity or locking, so I am sure a more thorough
// discussion of the topic (maybe even later in this tutorial) we will have a solution.
// Found an article on some relevant topics:
// https://www.hackingwithswift.com/quick-start/concurrency/understanding-threads-and-queues
//
// TODO: To understand what I am seeing better, I wanted to instrument my code a little. I wanted
// to see how many threads my app is using in realtime and I also wanted to see how many
// active timers there are. I looked for some property or method on DispatchQueue but found
// nothing. Found no good info on number of threads.
//
// FURTHER OBSERVATION:
// Again, I clicked many times and got the counter to start incrementing rapidly. It got up to
// around 1200 to 1500 while I Was not watching, but then I noticed that at some point it had
// slowed back down to one-per-second. This implies that the original timer is the only one
// still running, or perhaps this timer was replaced with one from the toggle button clicks
// (totally possibly but I would lean towards there being a single original timer.) .. but
// anyhow, what it looks like to me is ALL the extra timers that were started from clicks
// have gone away for an as yet unknown reason (but certainly ran for many iterations each)
// and only one remains. As I touched on before, there appeared to be some limit of about 10
// of these simultaneously.


import SwiftUI


struct StateTimerView: View {
    // var isActivated = false  // If this was simply a var, since this is a struct, we would
    //   get this error: Cannot use mutating member on immutable value: 'self' is immutable
    // This error is triggered by self.isActivated.toggle().  So we use @State:
    @State var isActivated = false
    
    @State var reloadCount = 0
    
    var body: some View {
        
        // Asynchronous Timer
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.reloadCount += 1
        }
        
        // Explicit 'return' was required here after I added the above DispatchQueue block.
        // Apparently, things nearby where you might want an implicit return to happen can
        // confuse the compiler. The error I was getting without the return (after adding
        // the above timer block) was this:  Type '()' cannot conform to 'View'
        
        return VStack {
        
            Text("Reload count: \(reloadCount)")
                .padding()
                    .border(Color.white)
        
            Button(action: {
                self.isActivated.toggle()
            }) {
                // We have deviated from the @State tutorial here and thrown in the custom
                // conditional view modifier 'if':
                // COMMENT: Admittedly, this is not a great example of why or how to use this.
                Text("TOGGLE BUTTON")
                    .padding()
                    .if(isActivated) { view in  // This custom 'if' is defined just below here.
                        view.overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.white, lineWidth: 4)
                        )
                    }  // Custom 'if' conditional view modifier
                    
            }  // Button
        
        }  // VStack
        
    }  // var body View
}  // StateTimerView


// TODO: Quick idea: I want the text button background to change based on the boolean
// toggle state.
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
