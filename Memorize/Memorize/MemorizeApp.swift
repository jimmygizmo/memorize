//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI


@main
struct MemorizeApp: App {
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
            
            //ContentView()  // The main entry-point for the Memorize app, focus of this repo.
            
            //DashContentView()  // An experimental view with a TabBar and more. [Tutorial B]
            
            BleScanContentView()  // An experimental view with a TabBar and more. [Tutorial C]
            
        }
    }
}


/*
 [Tutorial B] - Source for code in DashContentView and related files/code:
 https://www.youtube.com/watch?v=xfOehTZXnYk
 Channel: DevScorch. Title: SwiftUI Tutorial. Building a UI with ScrollView, Shapes and TabBar
 
 Files:
 DashContentView.swift, DashBoardView.swift
 */


/**/
