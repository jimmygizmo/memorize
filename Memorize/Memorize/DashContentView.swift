//
//  DashContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/19/21.
//

// This file is related to a supplemental tutorial. See other comments marked for: [Tutorial B]
// https://www.youtube.com/watch?v=xfOehTZXnYk

import SwiftUI


struct DashContentView: View {
    init() {
        UITabBar.appearance().isTranslucent = false
        // Dark Blue / Navy Blue:
        UITabBar.appearance().barTintColor =
            UIColor(red: 19/255, green: 18/255, blue: 88/255, alpha: 1)
    }
    
    
    var body: some View {

        ZStack {
            
            Color(red: 245/255, green: 245/255, blue: 249/255)
            
            TabView {
                DashBoardView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Dasboard")
                    }
                DashBoardView()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Agenda")
                    }
                DashBoardView()
                    .tabItem {
                        Image(systemName: "dollarsign.square")
                        Text("Invoice")
                    }
                DashBoardView()
                    .tabItem {
                        Image(systemName: "timer")
                        Text("Timers")
                    }
                
                
            }  // TabView
            .accentColor(.yellow)
            
        }  // ZStack
        
    }
}  // DashContentView


struct DashContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashContentView()
            .previewDevice("iPhone 12 mini")
//            .previewDevice("iPhone 6s Plus")
            .preferredColorScheme(.dark)  // Comment this out for .light, which is the default.
    }
}


/**/
