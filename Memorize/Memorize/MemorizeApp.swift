//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI
import Combine


// Example of environment data used to hold a user record at the highest app level, then
// passing that user into a Content View. Illustrating @EnvironmentObject for the @State tutorial.
// This goes along with the file TwoWayStateView.swift
// Below when we launch the view, we also have to pass this data at the same time:
// TwoWayStateView().environmentObject(userData)
class User: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    @Published var userName = "Jimmy" { didSet { didChange.send() } }
    @Published var userPass = "opensesame" { didSet { didChange.send() } }
    @Published var userEmail = "jimmy.gizmo@internet.com" { didSet { didChange.send() } }
    
}


@main
struct MemorizeApp: App {
    
    var userData = User()  // See User() above. For the @State tut in file TwoWayStateView.swift.
    
    var body: some Scene {
        
        WindowGroup {
            /* Most of the work in this repository is from following the Stanford CS193P course
             and the application/game being built, called 'Memorize' is using the common
             UI entrypoint in the file called ContentView.swift and invoked here via:
             ContentView(). At times, I will explore other code from other tutorials or
             experimentation, of course inspired by my main focus on the Memorize app.
             
             When I want to try out a different UI, for now the easiest way to switch is
             doing so here at the very top entry point. Comment/uncomment below to
             enter the app with the various UIs, with the main one being 'ContentView()'
             */
            
            // Memorize App - part of the coursework for Stanford CS193P.
            //ContentView()  // The main entry-point for the Memorize app, focus of this repo.
            
            //DashContentView()  // An experimental view with a TabBar and more. [Tutorial B]
            
            //BleBeaconContentView()  // An experimental view with a TabBar and more. [Tutorial C]
            
            //BleConnectView()  // Basic Bluetooth Low Energy (BLE) communications. [Tutorial D]
            
            // TODO: Create this after doing the quick tutorial on @State below.
            //BleBrowseView()  // Basic BLE Browse/Connect/Services - Part Two of: [Tutorial D]
            
            //StateTimerView() // Very quick tutorial on @State, timer, more.
            
            // Part of the @State tutorial, for the below View() to work, also uses the User
            // class defined in this top-level App file.
            // We supply the data to the environment and launch the view in the same statement:
            TwoWayStateView().environmentObject(userData)
            
        }  // WindowGroup
    }  // var body Scene
}  // App


/*
 [Tutorial B] - Source for code in DashContentView and related files/code:
 https://www.youtube.com/watch?v=xfOehTZXnYk
 Channel: DevScorch. Title: SwiftUI Tutorial. Building a UI with ScrollView, Shapes and TabBar
 
 Files:
 DashContentView.swift, DashBoardView.swift
 */

// For the many other tutorials worked on:
// See individual code files for full details on all the tutorials and coresework covered.


/**/
