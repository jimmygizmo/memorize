//
//  BleBrowseManager.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/3/21.
//

// This file contains code that handles core bluetooth functionality and data for use by:
// BleBrowseView.swift  <-- See this file for more comments on this app.
// This is for the tutorial:  [Tutorial D - Part 2]
// https://www.novelbits.io/intro-ble-mobile-development-ios-part-2/


// Some testing is being done using an HM-10 Bluetooth module.
// NAME: DSD TECH
// UUID: CE420004-A991-7876-5AA8-F315A0BC8D67


import Foundation
import CoreBluetooth


// For logging, mostly:
// extension CBManagerState.stringValue - Actually defined for another tut in: BleConnectView.swift
// extension CBPeripheralState.stringValue - same.
// We use both in this file.


struct Peripheral: Identifiable {
    let id: Int
    let name: String
    let nameAdvertised: String
    let rssi: Int
    //let uuid: UUID
}


class BleManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    // I'm thinking of adopting a naming convention, such that when I have a @Published
    // var to use in a View, I will prefix the name with 'view'. It seems helpful to
    // distinguish such vars, because they will have a unique set of concerns, one of which
    // likely being the need to force-unwrap etc. and define default values because it seems
    // optionals cannot be used in Views.
    // I'm calling these vars, but properties is more accurate.
    // There are many reasons to identify groups of properties with such naming conventions,
    // to help remember and validate that all those properties are being handled appropriately.
    
    // SURPRISING! The current tutorial does not use PassthroughSubject. Why?
    // Also note this tutorial does not import Combine! But we seem to be using ObservableObject
    // with no problem. Except one issue which is why I was looking to call didChange() ..
    // The BLE state shows in the View fine upon first startup, but when it is switched off
    // etc. I don't see a change.
    //
    //var didChange = PassthroughSubject<Void, Never>()
    
    var centralMgr: CBCentralManager!
    
    @Published var viewBleState = false
    
    @Published var viewDiscoveredPeripherals = [Peripheral]()
    
    
    override init() {
        super.init()
        
        // Initialize our CBCentralManager instance variable we created above, assigning
        // self as delegate, so those callbacks are called right here within in this instance.
        // Initialization (instantiation) has to happen in executing code, which is why it
        // must be here in this init. We define it in the class definition above, but this
        // is the first good place in running code to initialize/instantiate.
        centralMgr = CBCentralManager(delegate: self, queue: nil)
        
        
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("* CBCentralManager called centralManagerDidUpdateState")
        if central.state == CBManagerState.poweredOn {
            print("* BLE powered on. CBCentralManager.state: \(central.state.stringValue)")
            viewBleState = true
        } else {
            print("* ERROR: Some problem with BLE! CBCentralManager.state: ",
                  "\(central.state.stringValue)")
            print("This issue may resolve itself. Check to see that Bluetooth is turned on.")
            viewBleState = true
        }  // else NOT poweredON
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        // TODO: See what else is available in advertisement data
        
        // Name returned with the peripheral object which could be from the GAP database
        // and could be cached by IOS and might be less reliable for matching.
        // TODO: Rewrite and improve. We need clear info on this here where name originates.
        // OBSERVATION: This is usually nil for all devices I test with. Only the DSD TECH HM-10
        // module has this populated.
        var peripheralName: String!
        
        // Name advertised by the peripheral during the scan. TODO: Rewrite and improve.
        // OBSERVATION: This is sometimes nil. Usually: Mac hostname, Jimmy's AirPods etc.
        var peripheralNameAdvertised: String!
        
        // ADDITIONAL OBSERVATION: The HM-10 triggered didDiscover twice, the first time
        // peripheral.name was nil, the secon time, it was "DSD TECH", BOTH times, the
        // advertised name was "DSD TECH"
        
        // CONCLUSION: Should generally always use the advertised name. Keep eye open for use
        // cases where the peripheral.name (potentially the GAP database/cached,
        // possibly-user-assigned name) might need special treatment. Otherwise I'll just log it.
        
        // TEST-BASED-CORRECTION: I re-named my AirPODS and the name changed for advertised name
        // NOT for peripheral.name. This was not expected and contrary to my notes. POSSIBLY,
        // The name I edited was actually done ON the AirPODs in the device state itself and thus
        // changes the advertised name. This could mean that what I edited was NOT the GAP database
        // (or the creation of such an entry) but rather was editing of the advertised data.
        // That has to be the case or many of my sources are wrong. SO .. after exploring IOS
        // settings, I could not see how to assign a nickname or anything like that .. meaning
        // so far I see no way to make entries into or to edit the GAP db.
        
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            peripheralName = name
        } else {
            peripheralName = "Unknown"
        }
        
        if let name = peripheral.name{
            peripheralNameAdvertised = name
        } else {
            peripheralNameAdvertised = "Unknown"
        }
        
        let newPeripheral = Peripheral(id: viewDiscoveredPeripherals.count,
                                       name: peripheralName,
                                       nameAdvertised: peripheralNameAdvertised,
                                       rssi: RSSI.intValue)
        print(newPeripheral)
        viewDiscoveredPeripherals.append(newPeripheral)
        
    }
    
    
    func startScanning() {
        print("start scanning")
        centralMgr.scanForPeripherals(withServices: nil, options: nil)
    }
    
    
    func stopScanning() {
        print("stop scanning")
        centralMgr.stopScan()
    }
    
    
    // TODO: This tutorial sort of ends abruptly after the scanning. I'll pick up again later
    // on a BLE app, so we are probably done here for now.
    // Resuming work specifically on Stanford CS193P and the Memorize game.
    
    
}  // BleManager

