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
    
    
    // XCode provided this FIX stub so that we conform to the CBCentralManagerDelegate protocol.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("sup!")
    }  // centralManagerDidUpdateState
    
    
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
