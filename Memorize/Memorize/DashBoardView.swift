//
//  DashBoardView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/19/21.
//

// This file is related to a supplemental tutorial. See other comments marked for: [Tutorial B]
// https://www.youtube.com/watch?v=xfOehTZXnYk

import SwiftUI


struct DashBoardView: View {
    var body: some View {
        
        let colorDarkGreyBlackish = Color(red: 57/255, green: 57/255, blue: 57/255)
        
        ZStack {
            Color(red: 245/255, green: 245/255, blue: 249/255)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(alignment: .leading) {
                HStack {  // DASHBOARD
                    Text("Dashboard")
                        .foregroundColor(colorDarkGreyBlackish)
                        .fontWeight(.bold)
                        .font(.system(size: 23))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }  // HStack - Dashboard
                
                ScrollView {
                    HStack {  // OVERVIEW
                        Text("Overview")
                            .foregroundColor(colorDarkGreyBlackish)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.leading, 10)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)

                    }  // HStack - Overview
                    .padding(20)
                    
                    
                    HStack(alignment: .center) {  // TIME ENTRY [STOPWATCH - WORKED HOURS]
                        Image(systemName: "stopwatch.fill")  // STOPWATCH
                            .resizable()
                            .foregroundColor(colorDarkGreyBlackish)
                            .padding(16)
                            .frame(width: 68, height: 68, alignment: .center)
                        
                        VStack {  // WORKED HOURS
                            Text("Worked Hours")
                                .foregroundColor(colorDarkGreyBlackish)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                            
                            Text("140")
                                .foregroundColor(colorDarkGreyBlackish)
                                .font(.system(size: 12))
                                .multilineTextAlignment(.trailing)
                                .padding(.top, 2)
                                .padding(.leading, 1)
                        }  // VStack - Worked Hours
                        Spacer()
                        
                    }  // HStack - Time Entry [STOPWATCH - WORKED HOURS]
                    
                    
                }  // ScrollView
            }  // VStack - MAIN
        }  // ZStack
    }
}  // DashBoardView


struct DashBoardView_Previews: PreviewProvider {
    static var previews: some View {
        DashBoardView()
            .previewDevice("iPhone 12 mini")
//            .previewDevice("iPhone 6s Plus")
            .preferredColorScheme(.dark)  // Comment this out for .light, which is the default.
    }
}


/* System 'time' image used by the DevScorch tutorial no longer exists.
 
 Issue encountered in trying to use Image("time") under my current XCode 12.5.1
 (Current SF Symbols version is Beta 3.0 build 56.)
 The system image called 'time' no longer exists and the closest replacement is called
 'stopwatch' but it is quite different from the tutorial image and a lot of adjustment
 will be needed. First issue is that it is nearly impossible to see because the foreground
 color nearly matches the background and next issue is the lack of padding and borders etc.
 Error when original 'time' image was not found was:
 
 No symbol named 'time' found in system symbol set
 
 Other symbols that could work:
 stopwatch.fill, clock, clock.fill, deskclock, deskclock.fill
 
 These modifiers help the new symbols match the style of the tutorial:
 .foregroundColor(colorDarkGreyBlackish)
 .padding(16)
 
 * The old 'time' symbol was an inverse design by default it seems so it looked fine. Had
 rounded edges and a dark BG, or the BG is the foreground color etc. This is shown in the video.
 
 */


/**/
