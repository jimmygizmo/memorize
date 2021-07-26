//
//  BleConnectView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/25/21.
//

// This file is related to a supplemental tutorial, distinct from the CS193P course.
// Related items in project will be named/noted/flagged somehow as: Tutorial D

//
// Introduction to BLE Mobile Development [iOS]
// PART 1: https://www.novelbits.io/intro-ble-mobile-development-ios/
// PAR2 2: https://www.novelbits.io/intro-ble-mobile-development-ios-part-2/

import Combine  // For publishing data to subscribe to with views for real-time UI updating.
import CoreBluetooth
import SwiftUI

// TODO: Look for memory leaks or a way to explain any increase of memory usage of running app.
// We need to explain what was observed in tutorial C. Is the slow growth from printing/logging?
// TODO: This is a good opportunity to trace and profile the app, look at variables/objects etc.


class BleEngine: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    // PROBABLY NEEDED FOR UPDATING THE VIEW. NEEDED TO CONFORM TO ObservableObject
    // Below, didChange is referred to as a publisher.
    var didChange = PassthroughSubject<Void, Never>()  // This is the only thing needed to
    // conform to ObservableObject. This comes from Combine.
    // Narrator: Args mean: "Sending nothing (Void) and will 'Never' error."
    
    // Used to check the hardware staus of Bluetooth this IOS device.
    var centralManager: CBCentralManager!
    // The exclamation mark at the end means this is an unwrapped optional variable
    // and if we refer to it later we can check for null-safety. TODO: Clarify meaning and why.
    
    var myPeripheral: CBPeripheral!
    
    
    
    // The @Published decorator was the final piece needed to cause the View to update.
    // I could see that the data was updating, but not the view. Swift has changed since the
    // time of the tutorial and there are three pieces that work together,
    // different from the time of the tut. These are: @Published, ObservableObject and
    // @ObservedObject. See docs for how these all work together.
    @Published var classUsefulInt = 0
    
    //**********************************
    // In the UIKit app of the tutorial, this is what we would be doing:
    // In the viewDidLoad() function, add the following line to initialize
    // the centralManager variable:
    // centralManager = CBCentralManager(delegate: self, queue: nil)
    //
    // So, where do we do this in the SwiftUI version?
    // Using the Beacon tut C for guidance ... Looks like init() is the place.
    
    
    
    override init() {
        super.init()  // NSObject initializer
        
        centralManager = CBCentralManager()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        // We assign ourselves to be its delegate so we are told when something happens
        // ADAPTED FROM BEACON CODE - LOOKS LIKE THIS IS DONE IN THE INIT CALL ARGS. DISABLING.
        //centralManager?.delegate = self
        
        
        // centralManager?.requestWhenInUseAuthorization() // ADAPTING: NO EQUIVALENT
        
    }  // init
    
    
    
    //**********************************
    
    
    
    
    // XCode provided this FIX stub so that we conform to the CBCentralManagerDelegate protocol.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("sup!")
        if central.state == CBManagerState.poweredOn {
            print("BLE powered on")
        } else {
            print("BLE is not powered on, not available or has some other problem.")
        }
//        CBManagerState.poweredOff
//        CBManagerState.poweredOn
//        CBManagerState.resetting
//        CBManagerState.unauthorized
//        CBManagerState.unknown
//        CBManagerState.unsupported
    }  // centralManagerDidUpdateState
    
    // NICE! Everything working so far to just detect BLE is powered on.
    
    
    
    // When we want to update some data in the View. Perhaps an integer called usefulInt.
    // This update will be called by some callback from the CoreBluetooth interactions.
    // Look at BleBeaconContentView.swift for the parallel elements that need to be adapted.
    // * I just made this an int to keep to keep it simple.
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
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BleConnectView_Previews: PreviewProvider {
    static var previews: some View {
        BleConnectView()
    }
}
