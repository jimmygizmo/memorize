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


// - - - - - - - -
// MISCELLANEOUS NOTES AND THOUGHTS
//
// Swift STRUCTS are IMMUTABLE?
// This is an over-simplification to the point of being mis-information. You have to take
// all tutorials, articles and even references with a grain of salt on their own. There
// are many topics like this one that are VERY frequently confusingly, partially or
// inaccurately explained. In fact, there are many contexts in which Swift structs are
// mutable and it is wrong to say, like the current tutorial does, that structs are immutable.
//
// ** Losing some confidence in this tutorial and this channel/author. Am I in opposite-land?
// After saying emphatically that structs are immutable, when really that's far from accurate,
// NOW he is saying that all instances of a class are the same and change together? That's
// ridiculous. This might be true of class properties/methods but certainly not for instances.
//
// There is one case in this video where the author mistakenly mentions a struct changing
// but I am sure what he meant to say is that the struct would be replaced by a completely
// different (yet similar, of the same type signature) struct. BUT .. that still does not
// explain calling structs immutable in general, when they in fact ARE MUTABLE when both
// the struct AND one or more members properties are declared with var.
// MUCH clarification is badly needed on this topic.
// Unfortunately I am not going to trust this guys info and he seems to make very significant
// mistakes and omissions in his explanations in critical areas. He has a lot of videos too.
// Maybe I'll scrutinize a few more and see if this video is just a rare case of misinformation,
// or if he tends to go too quickly and frequently present some critical info inaccurately.
//


// Below are all points taken from the video, most I feel are valid but some might need
// clarification as this author is not the best explainer or narrator:
//
// Classes are reference types, copied by reference.
// Swift structs only ever have ONE OWNER. Value types, copied by value.
// A @State var belongs only to the current view and is not designed to be passed around, thus:
// Apple recommends marking all @State vars as PRIVATE:
//     @State private var widget etc..
// SwiftUI like most UIs only works on the main thread (responsiveness, priority) and because
// your update announcment will cause a UI-Refresh, it MUST happen on the main thread.



// - - - - - - - -


// Recommended order for imports? This is order-used, but sometimes alphabetic is the standard.
import SwiftUI
import Combine


// The tutorial is old.
// Use ObservableObject now (BindableObject is fully deprecated.)
// Use @ObservedObject now (@ObjectBinding is fully deprecated.)
// @Published is needed in front of appropriate class vars. This is not in this old tutorial.


/*
class User: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    // NOTE: In the beacon app in this repo, didChange.send() is invoked a little differently.
    // See BleBeaconContentView.swift
    // What we do in this app, is to call didChange.send() from an update func in the main
    // BLE class. This means didChange is available throughout the class, and this would be
    // because the class conforms to the ObservableObject protocol.
    // TODO: Figure out what exactly didSet is and how the two inline functions in this
    // syntax work. My guess: didSet is a callback made by a built-in setter accessor and
    // will also need the @Published 'decorator' (or in Swift is wrapper more accurate?)
    // applied to the class .. becuase I think something needs to invoke the special
    // declaration syntax? or is that part of class functionality?
    // He calls these didSets "PROPERTY OBSERVERS". Makes sense.
    @Published var userName = "Jimmy" { didSet { didChange.send() } }
    @Published var userPass = "opensesame" { didSet { didChange.send() } }
    @Published var userEmail = "jimmy.gizmo@internet.com" { didSet { didChange.send() } }
    
}
*/

struct TwoWayStateView: View {
//    @ObservedObject var user = User()
    // The instance of the User will be placed into the ENVIRONMENT in the top-level file:
    // MemorizeApp.swift, see comments in that file as well.
    @EnvironmentObject var user: User

    var body: some View {
        VStack {
            // Email is duplicated on purpose, to show the real-time didChage update happening.
            TextField("Email:", text: $user.userEmail)
                .padding()
                .border(Color.white)
            TextField("Username:", text: $user.userName)
                .padding()
                .border(Color.white)
            TextField("Password:", text: $user.userPass)
                .padding()
                .border(Color.white)
            TextField("Email:", text: $user.userEmail)
                .padding()
                .border(Color.white)
            
        }  // VStack
    }  // var body View
}  // TwoWayStateView


// As last part of @State tut: We can put test data into the preview to make it work, when
// otherwise it would require a full running app.
// NOTE: In the older tut, there is #if DEBUG ... #endif aroung the Preview code. We do what he
// did as if there were not present:
let userData = User()

struct TwoWayStateView_Previews: PreviewProvider {
    
    static var previews: some View {
        TwoWayStateView().environmentObject(userData)
    }
}


// Seeing an error/warning from using TextField. Seems to be triggereg when I have at
// least one empty field (after deleting default values) and then I change focus to
// another field, and only after some change has been made to at least one field.
// That's basically the set of conditions/actions to trigger this error:
// 2021-08-01 23:14:48.359427-0700 Memorize[1891:870609] [Snapshotting] Snapshotting a view
//     (0x103d636a0, _UIReplicantView) that has not been rendered at least once requires
//     afterScreenUpdates:YES.


/*
 STRUCT VERSION - TUT HALF-WAY POINT.
 https://youtu.be/stSB04C4iS4?t=633
 
struct User {
    var userName = "Jimmy"
    var userPass = "opensesame"
    var userEmail = "jimmy.gizmo@internet.com"
}

struct TwoWayStateView: View {
    
    @State var user = User()

    var body: some View {
        VStack {
            TextField("Username:", text: $user.userName)
                .padding()
                .border(Color.white)
            TextField("Password:", text: $user.userPass)
                .padding()
                .border(Color.white)
            TextField("Email:", text: $user.userEmail)
                .padding()
                .border(Color.white)
        }  // VStack
    }  // var body View
}  // TwoWayStateView
 */


/*
 THIS VERSION USES ONLY @ObservedObject ETC. NEXT WILL BE @EnvironmentObject.
 
 class User: ObservableObject {
     var didChange = PassthroughSubject<Void, Never>()
     // NOTE: In the beacon app in this repo, didChange.send() is invoked a little differently.
     // See BleBeaconContentView.swift
     // What we do in this app, is to call didChange.send() from an update func in the main
     // BLE class. This means didChange is available throughout the class, and this would be
     // because the class conforms to the ObservableObject protocol.
     // TODO: Figure out what exactly didSet is and how the two inline functions in this
     // syntax work. My guess: didSet is a callback made by a built-in setter accessor and
     // will also need the @Published 'decorator' (or in Swift is wrapper more accurate?)
     // applied to the class .. becuase I think something needs to invoke the special
     // declaration syntax? or is that part of class functionality?
     @Published var userName = "Jimmy" { didSet { didChange.send() } }
     @Published var userPass = "opensesame" { didSet { didChange.send() } }
     @Published var userEmail = "jimmy.gizmo@internet.com" { didSet { didChange.send() } }
 }

 struct TwoWayStateView: View {
     @ObservedObject var user = User()

     var body: some View {
         VStack {
             // Email is duplicated on purpose, to show the real-time didChage update happening.
             TextField("Email:", text: $user.userEmail)
                 .padding()
                 .border(Color.white)
             TextField("Username:", text: $user.userName)
                 .padding()
                 .border(Color.white)
             TextField("Password:", text: $user.userPass)
                 .padding()
                 .border(Color.white)
             TextField("Email:", text: $user.userEmail)
                 .padding()
                 .border(Color.white)
             
         }  // VStack
     }  // var body View
 }  // TwoWayStateView
 */


/**/
