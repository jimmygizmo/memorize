//
//  DashBoardView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/19/21.
//

// This file is related to a supplemental tutorial. See other comments marked for: [Tutorial B]
// https://www.youtube.com/watch?v=xfOehTZXnYk

// Unfortunately, it looks like there is no follow-on video from the same channel and might
// never be. This might just be a one-off. I still think this was a great little tutorial to do.
// DevScorch YouTube Channel:
// https://www.youtube.com/c/DevScorch
// * But it looks like he is not focusing on SwiftUI at the moment (July 2021.)

// My plan is to do a few more small tutorials in separate files, but within this project/repo
// most likely focusing on UI as I proceed with the Swift language reading assignements for
// the Stanford CS193P course. This involves a lot of reading so it is good to keep the UI
// gears turning at the same time for breaks from all the language-focused reading.

import SwiftUI


struct DashBoardView: View {
    var body: some View {
        
        // TODO: Refactor these color constants (and more) into a separate file.
        let colorDarkGreyBlackish = Color(red: 57/255, green: 57/255, blue: 57/255)
        let colorDarkNavyBlue = Color(red: 19/255, green: 18/255, blue: 88/255)
        // colorAlmostWhite is a tad darker than the tutorial color and works much better:
        let colorAlmostWhite = Color(red: 237/255, green: 237/255, blue: 240/255)
        // TODO: These two colors could be better. Similar to tut. Need proper color scheme.
        let colorEarthyYellow = Color(red: 255/255, green: 226/255, blue: 12/255)
        let colorBurntOrange = Color(red: 230/255, green: 147/255, blue: 12/255)
        
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
                    HStack(alignment: .center) {  // WORKED HOURS
                        Image(systemName: "stopwatch")
                            .resizable()
                            .padding(18)  // Fix 4 new img. Not in tut.
                            .background(colorDarkNavyBlue)  // Fix 4 new img. Not in tut.
                            // Tut size is 68 but I like 66 better:
                            .frame(width: 66, height: 66, alignment: .center)
                            .cornerRadius(14)  // Fix 4 new img. Not in tut.
                        
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
                        .padding(.horizontal, 10)  // Not in tut but looks better.
                        
                        Spacer()
                        
                    }  // HStack - WORKED HOURS
                    .padding(.all, 15.0)
                    .background(RoundedRectangle(cornerRadius: 22)
                                    .foregroundColor(.white) // Makes item pop from darker bg.
                                    .frame(width: nil, height: 94, alignment: .center)
                    )
                    /*--------------------------------*/
                    
                    
                    /*--------------------------------*/
                    HStack(alignment: .center) {  // BILLABLE HOURS
                        Image(systemName: "dollarsign.square")
                            .resizable()
                            .padding(18)
                            .background(colorEarthyYellow)
                            .foregroundColor(colorDarkGreyBlackish)  // Needed for lighter bg
                            .frame(width: 66, height: 66, alignment: .center)
                            .cornerRadius(14)
                        
                        VStack {  // BILLABLE HOURS
                            Text("Billable Hours")
                                .foregroundColor(colorDarkGreyBlackish)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                            
                            Text("120")
                                .foregroundColor(colorDarkGreyBlackish)
                                .font(.system(size: 12))
                                .padding(.top, 2)
                                .padding(.leading, 1)
                        }  // VStack - Billable Hours
                        .padding(.horizontal, 10)
                        
                        Spacer()
                        
                    }  // HStack - BILLABLE HOURS
                    .padding(.all, 15)
                    .background(RoundedRectangle(cornerRadius: 22)
                                    .foregroundColor(.white)
                                    .frame(width: nil, height: 94, alignment: .center)
                    )
                    /*--------------------------------*/
                    
                    
                    /*--------------------------------*/
                    HStack(alignment: .center) {  // BILLABLE EXPENSES
                        Image(systemName: "list.bullet")
                            .resizable()
                            .padding(18)
                            .background(colorBurntOrange)
                            .foregroundColor(colorDarkGreyBlackish)  // Needed for lighter bg
                            .frame(width: 66, height: 66, alignment: .center)
                            .cornerRadius(14)
                        
                        VStack {  // BILLABLE EXPENSES
                            Text("Billable Expenses")
                                .foregroundColor(colorDarkGreyBlackish)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                            
                            Text("230")
                                .foregroundColor(colorDarkGreyBlackish)
                                .font(.system(size: 12))
                                .padding(.top, 2)
                                .padding(.leading, 1)
                        }  // VStack - Billable Expenses
                        .padding(.horizontal, 10)
                        
                        Spacer()
                        
                    }  // HStack - BILLABLE EXPENSES
                    .padding(.all, 15.0)
                    .background(RoundedRectangle(cornerRadius: 22)
                                    .foregroundColor(.white)
                                    .frame(width: nil, height: 94, alignment: .center)
                    )
                    /*--------------------------------*/
                    
                    /*================================================================*/
                    
                    HStack {  // ACTIVE TIMERS
                        Text("Active Timers")
                            .foregroundColor(colorDarkGreyBlackish)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .padding(.leading, 10)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    }  // HStack - Active Timers
                    .padding(20)
                    
                    
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


/**/
