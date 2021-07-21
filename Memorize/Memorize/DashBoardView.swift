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
        let colorDarkNavyBlue = Color(red: 19/255, green: 18/255, blue: 88/255)
        let colorAlmostWhite = Color(red: 245/255, green: 245/255, blue: 249/255)
        
        ZStack {
            colorAlmostWhite.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
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
                    
                    
                    /*--------------------------------*/
                    HStack(alignment: .center) {  // TIME ENTRY [STOPWATCH - WORKED HOURS]
                        Image(systemName: "stopwatch")  // STOPWATCH
                            .resizable()
                            .padding(18)
                            .background(colorDarkNavyBlue)
                            .frame(width: 66, height: 66, alignment: .center)
                            .cornerRadius(14)
                        
                        VStack {  // WORKED HOURS
                            Text("Worked Hours")
                                .foregroundColor(colorDarkGreyBlackish)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                            
                            Text("140")
                                .foregroundColor(colorDarkGreyBlackish)
                                .font(.system(size: 12))
                                .padding(.top, 2)
                                .padding(.leading, 1)
                        }  // VStack - Worked Hours
                        .padding(.horizontal, 10)
                        
                        Spacer()
                        
                    }  // HStack - Time Entry [STOPWATCH - WORKED HOURS]
                    .padding(.all, 15.0)
                    .background(RoundedRectangle(cornerRadius: 22)
                                    .foregroundColor(.white)
                                    .frame(width: nil, height: 94, alignment: .center)
                    )
                    /*--------------------------------*/
                    
                    
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
 'stopwatch'. The result has some other differences and some modifiers not in the tutorial might
 be needed. The literal error was:
 
 No symbol named 'time' found in system symbol set
 
 Other symbols that could work:
 stopwatch.fill, clock, clock.fill, deskclock, deskclock.fill
 
 */


/**/
