//
//  BleConnectView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/25/21.
//
// This file is related to a supplemental tutorial, distinct from the CS193P course.
// Referred to in this project as: 'Tutorial D' or 'tut D'.
//
// Introduction to BLE Mobile Development [iOS]
// PART 1: https://www.novelbits.io/intro-ble-mobile-development-ios/
// PAR2 2: https://www.novelbits.io/intro-ble-mobile-development-ios-part-2/

import Combine
import CoreBluetooth
import SwiftUI
import AVFoundation

// TODO: Look for memory leaks or a way to explain any increase of memory usage of running app.
// We need to explain what was observed in tutorial C. Is the slow growth from printing/logging?
// TODO: This is a good opportunity to trace and profile the app, look at variables/objects etc.
// UPDATE: Profiled the app and there is no sign of a memory leak. Mermory usage is small and
// growth is slow. Have not yet confirmed that log output is causing slow App memory growth.


// Some testing is being done using an HM-10 Bluetooth module.
// NAME: DSD TECH
// UUID: CE420004-A991-7876-5AA8-F315A0BC8D67


// For logging.
extension CBManagerState {
    var stringValue: String {
        switch self {
        case .poweredOff:  // 4   <-- Int RawValue
            return "poweredOff"
        case .poweredOn:  // 5
            return "poweredOn"
        case .resetting:  // 1
            return "resetting"
        case .unauthorized:  // 3
            return "unauthorized"
        case .unknown:  // 0
            return "unknown"
        case .unsupported:  // 2
            return "unsupported"
        default:
            return "[WARNING: Unconfigured CBManagerState value. Cannot convert to string.]"
        }
    }
}  // extension CBManagerState


// For logging.
extension CBPeripheralState {
    var stringValue: String {
        switch self {
        case .connected:  // 2   <-- Int RawValue
            return "connected"
        case .connecting:  // 1
            return "connecting"
        case .disconnected:  // 0
            return "disconnected"
        case .disconnecting:  // 3
            return "disconnecting"
        default:
            return "[WARNING: Unconfigured CBPeripheralState value. Cannot convert to string.]"
        }
    }
}  // extension CBPeripheralState


class BleEngine: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    // This var didChange is the minimum requirement to conform to ObservableObject (from Combine.)
    // This is used to update a View and is referred to as a publisher.
    // TODO: Clarify the following comments as they were taken from brief tutorial audio.
    // First argument is what to send: Void. And the second argument means to Never error.
    var didChange = PassthroughSubject<Void, Never>()
    
    // CBCentralManager mostly deals with the availability and powered off/on state of Bluetooth.
    var centralManager: CBCentralManager!
    // The exclamation mark at the end means this is an unwrapped optional variable.
    // * Interestingly, for beacons we just worked with CLLocationManager and this was NOT
    // declared as an optional. I wonder why? They seem to do similar things like issue
    // all the callbacks and handle the base level functionality. Maybe beacons are
    // the special case and being an optional is more typical of a class that
    // controls a hardware subsystem.
    
    var chosenPeripheral: CBPeripheral!
    
    // TODO: This sound JBL Confirm as a discovery sound is not horrible but we can do better.
    let soundChosenPeripheralDiscovered: SystemSoundID = 1111
    // 1111 JBL Confirm (sounds like a blip appearing)
    
    // TODO: This sound is pretty good for connecting but maybe it too can be a little better.
    let soundChosenPeripheralConnected: SystemSoundID = 1109
    // 1109 Shake (hands, like connecting)
    
    // For the Beacon app, the @Published decorator was a critical piece that was
    // needed to cause the View to update. Prior to adding this, I could see that
    // the DATA was updating, but not the view. Swift has changed since the time of the
    // Beacon tutorial and there are three pieces that work together,
    // different from the time of the tut. These are: @Published, ObservableObject and
    // @ObservedObject.
    // We call this classUsefulInt because it is the Class Property that holds usefulInt.
    // TODO: A bettter name and explanation is needed.
    @Published var classUsefulInt = 0
    
    // Using an optional here might have implications on the View side. I don't need to use one
    // here, but since the RSSI is set by a callback after a separate call, an optional seems
    // appropriate BUT, really this is the first var we want to put the data into and an optional
    // might not be the right thing here. For all I know, Views (or maybe it is Combine/publishing)
    // might have issues with optionals.
    //
    // TODO: THIS IS A VERY CRITICAL AREA TO UNDERSTAND COMPLETELY.
    //
    // TODO: Test this as an optional in a View. Now is the time to start building the UI anyhow.
    // If an optional works, then the question is how does the View handle nil? If an optional will
    // not work, then the question is what value should we set: empty string? error or warning?
    // Maybe even a special value that the View can interpret and handle in a custom way and not
    // simply just render/display text etc.
    //@Published var classChosenDeviceRSSI: NSNumber?
    //@Published var classChosenDeviceRSSI: String  // FIX ATTEMPT. Unwrap in the callback.
    
    // Small issue .. After changing things to use NumberFormatter() and forced unwrapping in
    // the callback to get this to be a simple string (possibly empty string) .. then when I
    // am not assigning any value here (as disabled above), I am getting this error:
    // ERROR: Property 'self.classChosenDeviceRSSI' not initialized at super.init call
    
    @Published var classChosenDeviceRSSI: String = ""  // OF FIX FIX ATTEMPT. Assign something.
    // FIX WORKED! We are now seeing the RSSI value in the UI.
    // CONCLUSION: OPTIONALS HAVE EXTRA CHALLENGES WHEN USING @Publish TO A View().
    // CURRENT SOLUTION: Make everything simple a String etc. using forced unwrapping
    // if necessary, so edge-case values (lack of value upon unwrap attempt etc) will need
    // closer consideration. BUT, since a lot of stuff happens because of callbacks .. we
    // will more often than not have a value available, related to a callback we just got,
    // in particular, the value may frequently be provided by the callack, and if it occurs,
    // will always be present. There are a lot of important issues here, so no doubt a
    // solid strategy for these issues will evolve for me soon than later.
    
    /*
     -- UNDERSTANDING HOW Combine WORKS HERE:
     -- GETTING DATA FROM CORE APP FUNCTIONALITY TO THE VIEWS:
     There are no doubt many ways to do this, but our current strategy uses Combine's:
     ObservableObject protocol and the @Published and @ObservedObject decorators.
     TODO: 'Decorator' is a term borrowed from Python. Determine the correct terminology.
     
     The core which is publishing data uses the @Published decorator on variables that are
     'sending' data updates out. The subscribing Views or their containing class/struct use
     the @ObservedObject decorator when they declare the object they are subscribing to and
     receiving from. TODO: Clarify how I say 'class/struct' where they declare...
     
     Snippets from the docs:
     - - - -
     ObservableObject
     A type of object with a publisher that emits before the object has changed.
     By default an ObservableObject synthesizes an objectWillChange publisher that emits the
       changed value before any of its @Published properties changes.
     - - - -
     
     TODO: Concept needs clarification: emits changed value BEFORE property changes. What is the
       essence of this concept?
     */
    
    
    override init() {
        super.init()  // NSObject initializer
        
        // Assign self as the delegate. Thus, callbacks will happen on THIS class instance.
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        // Beacon tutorial C was a little different and we were dealing with an optional.
        // TODO: Would be nice to know why we treat locationManager as optionl but not here.
        // The technique of assigning self is a little different but the point is the fact that
        // locationManager is an optional, but centralManager is forced unwrapped.
        // TODO: Still need general clarification on why the difference and even more importantly,
        // precisely what we are doing differently in the declarations and why? Consulting
        // A third source of info like the docs will help a lot to clarify the difference between
        // these two tutorials on this one small but important detail.
        // Example from Beacon tut app of the equivalent setting of the delegate:
        //locationManager?.delegate = self
   
    }  // init
    
    // -------- centralManagerDidUpdateState    <- centralManager
    // This function is required to conform to the CBCentralManagerDelegate protocol.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            print("* BLE powered on. CBCentralManager.state: \(central.state.stringValue)")
            print("* BLE scan starting.")
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            // CONSIDER: This callback happens asynchronously and can happen at any time.
            // That has a lot of implications, but on simple level, it means starting to
            // scan here does make sense. There is an implication that we need to handle many
            // state transitions of this type and in some cases do cleanup .. inform user, etc.
            // IOS does some of the informing of users to solve basic issues like turning BT on,
            // but what else would a rich, professional App need to do in this area?
        } else {
            print("* ERROR: Some problem with BLE! CBCentralManager.state: ",
                  "\(central.state.stringValue)")
            print("This issue may resolve itself. Check to see that Bluetooth is turned on.")
            //
            // TODO: then what? Plenty of things to consider about checking/recovery in this app.
            //
            
        }  // else NOT poweredON
        
    }  // -------- centralManagerDidUpdateState    <- centralManager
    
    
    // -------- didDiscover    <- centralManager
    // This can get a lot of rapid updates. We need to manage state for every UUID and then
    // expire it out after some cool-down period, but continue updating the state with the
    // latest data from each UUID as long as we are scanning. How long should we scan for?
    // Maybe we only need to scan briefly to get connected and possibly again to reconnect.
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        
        AudioServicesPlaySystemSound(soundChosenPeripheralDiscovered)
        logDiscoveredPeripheral(peripheral)
        
        // Will connect to the known UUID of my HM-10 module
        // DSD TECH HM-10 UUID: CE420004-A991-7876-5AA8-F315A0BC8D67
        if peripheral.identifier.uuidString == "CE420004-A991-7876-5AA8-F315A0BC8D67" {
            print("================================================================")
            print("* DSD TECH HM-10 module identified during scan. Stopping scan.")
            self.centralManager.stopScan()
            print("* CBPeripheral.state: \(peripheral.state.stringValue)")
            
            self.chosenPeripheral = peripheral  // assign this peripheral to a property
            // CONFIRM: We assign it to this property so we can perform read/write actions
            // from this property (now a reference to the peripheral.)
            self.chosenPeripheral.delegate = self  // Object to which callbacks are sent.
            
            // TODO: Explore available connection options. Word 'chosen' in vars and log: weird?
            print("* CONNECTING to chosen peripheral.")
            self.centralManager.connect(peripheral, options: nil)
            print("* CBPeripheral.state: \(peripheral.state.stringValue)")
            //
            // IMPORTANT DISCOVERY. If you check the connection inside here, you won't see it.
            // In fact .. no connection will happen until this block exits.
            // I had tried checking for 'connected' status in here many times, with 1 second
            // delays in-between. It never showed connect UNTIL the didConnect callback
            // happened, and that NEVER happened until THIS block exited. So the thing to do
            // is to just issue the connect and then exit here.
            // TODO: Need to understand the internals of why the connect does not take immediate
            // effect and why exiting this block appears necessary before the connect can
            // actually happen. Can the centralManager only do one thing at a time?
            // That seems like the best explanation. It is a single instance, when is a single
            // reference which must be only running on a single thread in the sense that
            // one method (any of these CB callbacks) must complete before another method
            // (CB callback) can be called. This is my best guess.
            
        }  // if chosen peripheral was just discovered
    }  // -------- didDiscover    <- centralManager
    
    
    func logDiscoveredPeripheral(_ peripheral: CBPeripheral) {
        // In here, CBPeripheral.name is an optional, and we want to use empty string or
        // something similar to show that name was nil etc. We could combine forced unwrapping
        // with the ternary operator like this:
        // x = a != nil ? a! : ""
        // Even better, we could use the Nil Coalescing Operator, which is intended for this:
        // x = a ?? ""
        print("----------------------------------------------------------------")
        
        print("NAME: \(peripheral.name ?? "") ")
        
        print("UUID: \(peripheral.identifier)")
        
        // bools ANCS and CSWWR will print as strings "true" or "false"
        print("STATE: \(peripheral.state.stringValue)    ",
              "ANCS: \(peripheral.ancsAuthorized)    ",
              "CSWWR: \(peripheral.canSendWriteWithoutResponse)"
        )
        
        // TODO: FIX this. First we need to explicitly discover services and then get a callback
        // etc.
        if let services: [CBService] = peripheral.services {
            print("* SERVICES COUNT: \(services.count)")
        }  // services?
    }  // logDiscoveredPeripheral
    
    
    // -------- didConnect    <- centralManager
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        AudioServicesPlaySystemSound(soundChosenPeripheralConnected)
        
        print("* CONNECTED. didConnect was called by CBCentralManager.")
        print("* CBPeripheral.state: \(peripheral.state.stringValue)")
        
        // Reading the RSSI can only be done when connected.
        // We call it here, which triggers it, but we need to get the callback and then
        // access the CBPeripheral object's rssi property after or more accurately, within
        // that callback. Likely, what we want to do then is put it into a published class
        // property of this BleEngine class so we can update in into the UI in real time.
        // With our current strategy, this goes for all of our variables/data. I am sure
        // there are multiple alternative techniques, but this is a simple method that is
        // working well for the current use cases.
        peripheral.readRSSI()
        
        // TODO: Change 'chosen' to 'selected' etc., but will do it all at once.
        // The best terminology to use will depend on the purpose and behavior of the final app.
        print("* DISCOVERING services on chosen peripheral.")
        peripheral.discoverServices(nil)
        
        //
        // * * * *
        // TODO: What else might we do here, post-connecting?
        // This might be the point to kick off our main functionality, such as a main loop
        // for monitoring and/or controlling the device we just connected to etc.
        //
        //  -->  Possible kick-off point for app main loop, etc.  <--
        //
        // * * * *
        //
        
    }  // -------- didConnect    <- centralManager
    
    
    // -------- didReadRSSI    <- centralManager
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print("* didReadRSSI was called by CBCentralManager")
        print("* RSSI of the connected device: \(RSSI)")
        // Looks like print() can handle an NSNumber or optional NSNumber? but I have
        // had to poke aroung to figure out how to simple confert it to String().
        // Simple things like String(RSSI) do not work.
        // Now trying the NumberFormatter class (which might be what print() uses.)
        let formatter = NumberFormatter()
        // Aha! Looks like this is going to work, but in fact the result from formatter is
        // and optional, so we have to unwrap it and as planned I will use ?? with "" to
        // handle the nil case.
        // Set the value of the published class variable:
        classChosenDeviceRSSI = formatter.string(from: RSSI) ?? ""
        
        // TODO: This is currently declared as an optional and we are interested to see how a View
        // which is consuming an @Published variable deals with an optional. Questions remain
        // about how to treat the variable and values at this point in the code, depending on
        // how views handle published optionals etc.
        // HERE, is where we could modify the value, set a special value, turn nil into an
        // empty string (not that we would need to) etc .. or whatever we need to do to accommodate
        // handing this over to the View.
        // Most likely, I suspect that Views will handle an optional more elegantly than it might
        // sound like I am predicting, but Views and UI-invalidating and repainting might have
        // special requirements.
        //
        // UPDATE on @Published for optionals:
        // I tried to use it in the view and got this error:
        // Initializer 'init(_:)' requires that 'Published<NSNumber?>.Publisher'
        //    conform to 'StringProtocol'
        // OK. For now I will just try it as a string and use nil-coalescing into the
        // at an early step get rid of the optional and just make it a string.
        // This would just be a quick fix, prior to being able to explain the situation in
        // better detail. So to clarify, when I am getting error, the var is defined thus:
        // @Published var classChosenDeviceRSSI: NSNumber?
        // and access is attempted in the View thus:
        // Text(bleEngine.$classChosenDeviceRSSI)
        //
        // UPDATE ON THE UPDATE - MADE IT JUST A STRING AT AN EARLY STEP.
        // ** See details on final fix above in comments and near the class property declarations.
        // Bottom line is this. I have seen this topic now mentioned elsewhere:
        // SWIFTUI DOES NOT LET YOU BIND OPTIONALS TO TEXT FIELDS. My feeling is that there
        // is a more general way to express this and there might be more to it, such that you
        // are limited to how you can use @Published optionals in Views. Maybe there are
        // issues with not only SwiftUI and Views but also with @Published and Combine etc.
        // This will remain an open topic for some time. This link is relevant:
/*
https://www.hackingwithswift.com/books/ios-swiftui/extending-existing-types-to-support-observableobject
 */
        // This is basically the same solution I figured out on my own, but it is nice to see
        // a different perspective, to have my ideas confirmed and I might use the idea of
        // creating some methods called wrappers that do this, because each kind of field
        // of data might need a custom way of creating a string (usually) for the case where
        // the optional is nil and has no value. Often this will just mean:
        // string_going_to_a_view = optional_string ?? ""
        // REMEMBER: There also seems to be a requirement that vars to be published in some
        // cases must have a value assigned (or the compiler must see this at least) and I would
        // guess that the reason is they dont want to allow publishling of nil objects or
        // something like that. Makes sense if this is how it works or close to how the design
        // was intended to work.
        
    }  // -------- didReadRSSI    <- centralManager
    
    
    // -------- didDiscoverServices    <- centralManager
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("* didDiscoverServices was called by CBCentralManager")
    }  // -------- didDiscoverServices    <- centralManager
    
    
    
    
    // Say we want to update some data in the View; imagine an integer called usefulInt ..
    // This update will be called by some callback from the CoreBluetooth interactions.
    // Look at BleBeaconContentView.swift for the parallel elements that need to be adapted.
    // * I just made this an int to keep it simple.
    // * We will likely need a custom update method for every piece of information we want to
    //   update separately in the UI.
    func update(usefulInt: Int) {
        // print("NOTICE update: ", usefulInt)  // Probably a good place to log.
        classUsefulInt = usefulInt  // store it in the property we defined in this class.
        didChange.send(())  // immediately call our publisher to inform any Views observing us
    }  // update
    
    
}  // BleEngine


struct BleConnectView: View {
    
    @ObservedObject var bleEngine = BleEngine()
    
    // Rainbow gradient to use in any View inside this struct
    let gradient = Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple])
    
    var body: some View {
        
        VStack {
            /* Text(bleEngine.$classChosenDeviceRSSI)  <-- Notice the $
             When this var classChosenDeviceRSSI was a NSNumber? in BleEngine and we accessed
             thus, we got this error:
                 Initializer 'init(_:)' requires that 'Published<NSNumber?>.Publisher'
                     conform to 'StringProtocol'
             But now with the var as just a String (and unwrapped early in the callback),
             error is solved. But topic is large and deserves more research.
            */
            Text(bleEngine.classChosenDeviceRSSI)  // Works now because just a String
                .font(.largeTitle)
                .shadow(color: .black, radius: 28)
                .shadow(color: .black, radius: 12)
        }  // .frame, .background + gradient .. is for entire screen:
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            AngularGradient(gradient: gradient, center: .center, angle: .degrees(90))
        )
    } // var body View
}  // BleConnectView


struct BleConnectView_Previews: PreviewProvider {
    static var previews: some View {
        BleConnectView()
    }
}


 /**/
