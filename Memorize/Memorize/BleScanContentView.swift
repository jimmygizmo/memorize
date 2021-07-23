//
//  BleScanContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/21/21.
//

// This file is related to a supplemental tutorial. See other comments marked for: [Tutorial C]
//
// SwiftUI Tutorial: Build an iBeacon detector with object binding and custom modifiers
// https://www.youtube.com/watch?v=lCNpEaZiKqU

// Many comments are transcribed from the narrator's discussion during the tutorial video.

// Combine framework allows us to tell when data has changed using a 'passthrough' something?!
// NOTE: Tutorial is old. BindableObject has been replaced with ObservableObject. I will attempt
// to adapt/update the tutorial code into something that works.
import Combine

// Detect beacons among other things
import CoreLocation

import SwiftUI


// TODO: Clarify/re-write the below as was only roughly captured from poor video narration:
// BeaconDetector class will be an ObservableObject and a the delegate for a CL Location Manager.
// A requirement for working with delegates on IOS in UIKit is you must inherit from NSObject.
// WIll monitor beacons for us and notify our ContentView when something changes.
// UPDATE: Looks like BindableObject is totally deprecated. Replaced with: ObservableObject
// Details of getting this tutorial to work with ObservableObject are TBD.
class BeaconDetector: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // Below, didChange is referred to as a publisher.
    var didChange = PassthroughSubject<Void, Never>()  // This is the only thing needed to
    // conform to ObservableObject. This comes from Combine.
    // "Sending nothing (Void) and will 'Never' error."
    
    // LocationManager to be kept alive during the entire life of the app.
    var locationManager: CLLocationManager?
    
    
    var lastDistance = CLProximity.unknown
    
    override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        // CONTINUE VIDEO HERE:
        // https://youtu.be/lCNpEaZiKqU?t=431
        //
    }
    
    
    
}  // BeaconDetector


struct BleScanContentView: View {
    var body: some View {
        Text("UNKNOWN")
            .font(Font.system(size: 56, design: .rounded))
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(Color.gray)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}  // BleScanContentView


// Try wrapping the preview code in: #if DEBUG\n...\n#endif
// The effect this has, in the context of how I currently use XCode, is not yet apparent.
//#if DEBUG
struct BleScanContentView_Previews: PreviewProvider {
    static var previews: some View {
        BleScanContentView()
            .previewDevice("iPhone 12 mini")
//            .previewDevice("iPhone 6s Plus")
            .preferredColorScheme(.dark)  // Comment this out for .light, which is the default.
    }
}
//#endif


/**/
