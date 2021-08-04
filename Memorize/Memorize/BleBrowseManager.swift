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
        var peripheralName: String!
        
        
        // TODO: Update these comments and clairfy when/why to choose the different strategies
        // for getting peripheral data in this context.
        // Look deeper into how name is obtained here. TODO: Code not actually tested yet!!
        // This is not how I got name in BleConnectView.swift. Maybe I'm jumping ahead of myself.
        // And Name is frequently blank. I prefer using UUID but I guess it depends on the device
        // and use case. Anyhow, first time I have used:
        // advertisementData[CBAdvertisementDataLocalNameKey]
        // In BleConnectView, what I did was use the callback data's peripheral.name:
        // didDiscover peripheral: CBPeripheral ... and then peripheral.name
        // But of course there are usually MANY ways to do things in modern frameworks.
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            peripheralName = name
        } else {
            peripheralName = "Unknown"
        }
        
        let newPeripheral = Peripheral(id: viewDiscoveredPeripherals.count,
                                       name: peripheralName,
                                       rssi: RSSI.intValue)
        print(newPeripheral)
        viewDiscoveredPeripherals.append(newPeripheral)
        
    }
    
    
    
    
    
    
    
    
    
    
    
}  // BleManager

