//
//  BleScanContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/21/21.
//

// This file is related to a supplemental tutorial.
// Related items in project will be named/noted/flagged somehow as: Tutorial C
//
// SwiftUI Tutorial: Build an iBeacon detector with object binding and custom modifiers
// https://www.youtube.com/watch?v=lCNpEaZiKqU

// Many comments are transcribed from the narrator's discussion during the tutorial video.
// In some places the audio was hard to hear clearly, so the could be a few comments that
// don't make perfect sense yet, but I know where those are and will revisit them.
// I tend to progressively condense, remove and formalize comments throughout a project.

// Combine framework allows us to tell when data has changed using a 'passthrough' something?!
// NOTE: Tutorial is old. BindableObject has been replaced with ObservableObject. I will attempt
// to adapt/update the tutorial code into something that works.
import Combine

// Detect beacons among other things
import CoreLocation

import SwiftUI


// TODO: Look for a memory leak. I see memory usage slowly increasing, but have no explanation.


// This is just so our logging can show a human readable proximity. There don't appear to be a
// built-in string option, just rawValue integers, which effectively is what is matching here:
extension CLProximity {
    var stringValue: String {
        switch self {
        case .unknown:
            return "unknown"
        case .immediate:
            return "immediate"
        case .near:
            return "near"
        case .far:
            return "far"
        default:
            return "[Warning: Unconfigured CLProximity value. Cannot convert to string.]"
            // This error has not occurred in basic testing so it looks like these are all
            // the cases we need to cover (along with the case: no beacons at all returned.)
        }
    }
}


// TODO: Clarify/re-write the below as it was transcribed from hard-to-hear tutorial audio:
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
    
    // The @Published decorator was the final piece needed to cause the View to update.
    // I could see that the data was updating, but not the view. Swift has changed since the
    // time of the tutorial and there are three pieces that work together in the new way,
    // different from the time of the tut. These are: @Published, ObservableObject and
    // @ObservedObject. See docs for how these all work together. All are part of Combine,
    // I am pretty sure.
    @Published var lastDistance = CLProximity.unknown
    
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
            print("beacon scanning is authorized")
            // Can this device scan for beacons?
            if CLLocationManager.isMonitoringAvailable(
                for: CLBeaconRegion.self) {
                print("beacon scanning is available")
                if CLLocationManager.isRangingAvailable() {
                    print("beacon ranging is available")
                    startScanning()
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
        // minor: CLBeaconMinorValue -- Example: floor within store
        //
        // uuid, major and minor must match in whatever app or device you are using to
        // transmit beacons with.
        let constraint = CLBeaconIdentityConstraint(uuid: uuid, major: 123, minor: 456)
        
        // Wrap the constraint in a BeaconRegion
        let beaconRegion = CLBeaconRegion(beaconIdentityConstraint: constraint,
            identifier: "MyBeacon")
        
        print("scanning for beacons starting now")
        locationManager?.startMonitoring(for: beaconRegion)
        print("ranging of beacons starting now")
        locationManager?.startRangingBeacons(satisfying: constraint)
    } // startScanning
    
    
    // CALLBACK: didRange
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        // Just pull out the first beacon that got matched. TODO: Potential problems?
        if let beacon = beacons.first {
            print("beacon ranged: ", beacon.proximity.stringValue)
            update(distance: beacon.proximity)
        } else {
            print("No appropriate beacons could be detected.")
            // TODO: We might not want to call update here, more even better .. we need to be
            // able to indicate an additional state, which we can obviously see we have from
            // the behavior and that is: no beacon detected.
            // FACT IS, we only get into this else block when I completely turn off the beacon
            // or move very far away. Otherwise, what we get is unknown, far, near and immediate,
            // but that 'unknown' comes from the TRUE block above .. so it is actually logically
            // incorrect to call update(.unknown) here.
            // TODO: This is an area of improvement over the tutorial, or maybe the behavior has
            // changed since the time of the tut, but regardless, a little experimentation and
            // thinking through of the logic and how to communicate with the user is
            // warranted here.
            // LOOKING at the conditional: if let beacon = beacons.first
            // Most obviously, this will return false when no beacons have been detected at all.
            // A log message like this seems most appropriate, since some criteria has of course
            // been applied, such that we might not be detecting ALL possible beacons, just
            // certain ones, perhaps matching our UUID, Major, Minor or some part or some or
            // all of those.
            // Message to use for now: "No appropriate beacons could be detected."
            update(distance: .unknown)
        }
    }  // CALLBACK - didRange
    
    
    // When we find a beacon
    // Record the measured distance and then tell the views to repaint based off new data.
    func update(distance: CLProximity) {
        print("BEACON update: ", distance.stringValue)
        lastDistance = distance  // the property we defined
        didChange.send(())  // immediately call our publisher to inform any Views observing us
    }  // update

}  // BeaconDetector


struct BigText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 56, design: .rounded))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }  // func body
}  // BigText - ViewModifier


struct BleScanContentView: View {
    // Swift has changed a little in the two years since the tutorial. This decorator was
    // originally @ObjectBinding, related to BindableObject, both of which are now gone.
    // TODO: Test and confirm my conclusion that the new equivalent decorator is @ObservedObject.
    // Here is the definition of @ObservedObject and it sounds right to me:
    // "A property wrapper type that subscribes to an observable object and invalidates a view
    //  whenever the observable object changes."
    // I know we are publishing to a property and want the UI to re-paint with new data when
    // that property changes so I am pretty sure @ObservedObject is what we want here.
    @ObservedObject var detector = BeaconDetector()
    
    // Tutorial specifies that we must use return in each else block, but I think this applies
    // to older Swift. I get no warning at all WITHOUT returns and so I will leave them off for.
    // now. Eventually I will decide on my own best practices or conform to some team style,
    // but the Stanford IOS course which is the main focus of this project/repo is emphasizing
    // things like minimalism .. hence leaving things out that we KNOW swift easily determines
    // at compile time. The ethic seems to be at using less code and knowing Swift's inference
    // mechanisms well, which makes sense to me and makes more sense in a more formal language.
    // Compare this mindset to that of the Python community, where being explicit is valued and
    // encouraged more (hence code is a bit more wordy at times) .. BUT with Python being so
    // flexible, being explicit can have more value and sometimes be required.
    // I'm tending to like this about Swift. I like the type safety, but I like the idea
    // of leaving a well understood and well designed language type (and other)
    // inference system to do its work and have less code overall.
    // Also, compared to python, Swift syntax can be a LOT more 'busy' in places, with
    // the functional features mixed in, etc. .. it makes sense to find ways to
    // minimize and leave out unnecessary syntax.
    // MORE:
    // The error seen in the tutorial, which I believe we no longer get because of changes to
    // Swift is said to come from not using return before each of the Text() in all of the four
    // else cases below .. is exactly:
    //     "Function declares an opaque return type, but has no return statement ....."
    //     The final part of the error text is not visible in the video, if there is any.
    
    var body: some View {
        if detector.lastDistance == .immediate {
            // There is an implicit 'return' before each Text(). This was required in Swift of
            // a year or two ago, but nowadays it is preferred to remove, common implied syntax.
            Text("RIGHT HERE")
                .modifier(BigText())
                .background(Color.green)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        } else if detector.lastDistance == .near {
            Text("NEARBY")
                .modifier(BigText())
                .background(Color.orange)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        } else if detector.lastDistance == .far {
            Text("FAR")
                .modifier(BigText())
                .background(Color.blue)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        } else {
            Text("UNKNOWN")
                .modifier(BigText())
                .background(Color.gray)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }  // if-else like select-case for detector.lastDistance
    }  // var body View
}  // BleScanContentView


// IMPORTANT CLARIFICATION OF ACTUAL CODE EXECUTION FLOW AND SYSTEM OPTIMIZATIONS
// It looks like IN FACT, no beacon detection or ranging was taking place at all
// until the data was attempted to be accessed .. so some compiler or internal magic
// optimization is taking place or at the very least I need to understand some of the
// CoreLocation internals a bit better.
// OBSERVATION: Our log output never occurred and hence no code was run for beacon detect
// and ranging UNTIL we hooked up @ObservedObject and attempted to update the view.
// How can we sum up what this means? Can we say that "Publishers don't publish until they
// have a subscriber?" Certinaly this is a smart kind of optimization. It is probably
// something like that happening. Power-hungry radio usage certainly needs such optimizations.


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
