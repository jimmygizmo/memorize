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
    
    //@State var otherVar: String = "other var"  // @State not actually needed to eliminate errors.
    var otherVar: String = "other var"

    var body: some View {
        TextField(otherVar, text: $userName)
        //TextField(otherVar, text: $userName)
        // The following error from tut code may be a result of changes to Swift since then.
        // TextField(userName)  // This as is using a simple @State var above here:
        // Gives the following error: Missing argument for parameter 'text' in call
        // Then with this: TextField(text: userName)   I get a different error:
        // Cannot convert value 'userName' of type 'String' to expected type
        //     'Binding<String>', use wrapper instead
        // I -hacked- this error away in a manner that I do not understand the workings of, but
        // what I did was simply try to satisfy the arguments. It does appear that Swift is
        // different from the tutorial. Anyhow, what I did was create a new dummy @State string
        // and I figured out that the call to TextField() needed an unnamed initial arg.
        // So I gave it the simplest thing I thought would work and the same thing used for the
        // text argument it also complained it needed. Now, I do not know for a fact that this
        // second var needed to be @State .. at this point I just hacked things to work.
        // The tut topics are changing so I may not answer the details on this right away.
        // But errors are gone and I have TextField() in place which is where the tut video is at.
        // I just needed to do a few extra things to get rid of some errors, probably from Swift
        // being newer or from his XCode in the video not showing errors in time before he cut
        // the video scene after changing Text() to TextField() .. my gut tells me Swift changed.
        // UPDATE: @State was not needed on the otherVar, simply to get rid of the last error.
        // NOTE: I'm pretty sure this is not how you use variables in TextFields(), let me make
        // it clear I simply hacked-away an error by matching arg requirementes, nothing more.
        
    }  // var body View
    
}  // TwoWayStateView


struct TwoWayStateView_Previews: PreviewProvider {
    static var previews: some View {
        TwoWayStateView()
    }
}


/**/
