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
        super.init()  // NSObject initializer
        
        // locationManager is declared above and first assigned here, using the Type's
        // constructor (or is it better to call it 'initializer' in Swift? Probably, it seems.)
        // This creates an instance.
        locationManager = CLLocationManager()
        
        // We assign ourselves to be its delegate so we are told when something happens
        locationManager?.delegate = self
        
        // User will be asked for permission to use the location. TODO: Clarify when.
        // (He says, when app is being run.) Clarify if it saves the permission etc.
        // I know Info.plist can be involved with such permissions. Clarify.
        locationManager?.requestWhenInUseAuthorization()
    }  // init
    
    
    // Make decision of allow/disallow use of Location
    func locationManager(_ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // Can this device scan for beacons?
            if CLLocationManager.isMonitoringAvailable(
                for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // good to go!
                    // TODO ??? Probably: startScanning(???)
                    
                }  // isRangingAvailable
                
            }  // isMonitoringAvailable
            
        }  // authorizedWhenInUse
    }  // func locationManager
    
    // Said in tutorial to be an Apple test uuid:
    // 5A4BCFCE-174E-4BAC-A814-092E77F6B7E5
    // Probably cannot make BLE hardware operate without an approved UUID.
    // This might require getting app approved in MFi program before it can go into the store.
    // This is a primary reason that Apple's very substantial MFi program exists.
    func startScanning () {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        
        // CLBeaconIdentityConstraint was introduced in IOS 13 for detecting Beacons
        //
        // major: CLBeaconMajorValue -- Example: brand/company, store location
        //
        // minor: <#T##CLBeaconMinorValue#> -- Example: floor within store
        //
        // uuid, major and minor must match in whatever app or device you are using to
        // transmit beacons with.
        let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: 123, minor: 456)
        
        // Wrap the constraint in a BeaconRegion
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint,
            identifier: "MyBeacon")
        
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: constraint)
    } // startScanning
    
    // When we find a beacon
    func update(distance: CLProximity) {
        lastDistance = distance  // the property we defined
        didChange.send(())  // immediately call our publisher to inform any Views observing us
    }
    
    
    
    // CONTINUE VIDEO HERE:
    // https://youtu.be/lCNpEaZiKqU?t=759
    //
    

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
