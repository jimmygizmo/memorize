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


// So we can log a string value for these states.
extension CBManagerState {
    var stringValue: String {
        switch self {
        case .poweredOff:
            return "poweredOff"
        case .poweredOn:
            return "poweredOn"
        case .resetting:
            return "resetting"
        case .unauthorized:
            return "unauthorized"
        case .unknown:
            return "unknown"
        case .unsupported:
            return "unsupported"
        default:
            return "[Warning: Unconfigured CBManagerState value. Cannot convert to string.]"
        }
    }
}


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
        
        // Assign self as the delegate. Callbacks will happen on this class instance.
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        // Beacon tutorial C was a little different and we were dealing with an optional.
        // TODO: Would be nice to know why we treat locationManager as optionl but not here.
        //locationManager?.delegate = self
        
        
        
        // CONTINUE HERE
        
        
        
    }  // init
    
    
    
    //**********************************
    
    
    
    
    // This function is required to conform to the CBCentralManagerDelegate protocol.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            print("BLE powered on. CBManagerState: \(central.state.stringValue)")
            // TODO: Should we start scanning here? We do have to validate first, so maybe.
            centralManager.scanForPeripherals(withServices: nil, options: nil)
            // NOTE: This callback happens asynchronously and can happen at any time.
            // That has a lot of implications, but on s simple level, it means starting to
            // scan here does make sense. There is in implication that we need to handle many
            // state transitions of this type and in some cases do cleanup .. inform user, etc.
            // IOS does some of the informing of users to solve basic issues like turning BT on,
            // but what else would a rich, professional App need to do in this area?
        } else {
            print("Some problem with BLE! CBManagerState: \(central.state.stringValue)")
            // TODO: then what?
        }
        
        
        
    }  // centralManagerDidUpdateState
    
    
    // CALLBACK: didDiscover
    // This can get a lot of rapid updates. We need to manage state for every UUID and then
    // expire it out after some cool-down period, but continue updating the state with the
    // latest data from each UUID as long as we are scanning. How long should we scan for?
    // It is really an activity to find our peripheral, until we are connected and using it.
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber) {
        if let pname = peripheral.name {
            print(pname)
        }
    }  // CALLBACK - didDiscover
    

    
    
    
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
