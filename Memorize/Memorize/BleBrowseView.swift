//
//  BleBrowseView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/2/21.
//

// Work for second part of general Bluetooth BLE tutorial:
// https://www.novelbits.io/intro-ble-mobile-development-ios-part-2/
// NOTE: This tutorial is designed as a lead-in to a paid course and explains that some key
// functionality related to what we do here, will be found in the main course, not here.
// The article mentions leaving out control of Peripheral advertising, so I will just add that
// in myself if needed.


import SwiftUI


struct BleBrowseView: View {
    
    let bluetoothStatus = "ON"
    
    var body: some View {
        
        VStack {  // - WINDOW
            
            Text("BLUETOOTH SCANNER")
                .padding()
            
            VStack {  // - PERIPHERALS
                Text("Peripheral 1")
                    .padding()
                Text("Peripheral 2")
                    .padding()
                Text("Peripheral 3")
                    .padding()
            }  // VStack - PERIPHERALS
            
            Spacer()
            
            VStack {  // - STATUS
                Text("STATUS")
                    .padding()
                Text("Bluetooth is \(bluetoothStatus)")
                    .padding()
            }  // VStack - STATUS
            
            
            HStack {  // - CONTROLS
                VStack {
                    Text("Start Scan")
                        .padding()
                    Text("Stop Scan")
                        .padding()
                }
                VStack {
                    Text("Start Adv")
                        .padding()
                    Text("Stop Adv")
                        .padding()
                }
            }  // HStack - CONTROLS
            
        }  // - WINDOW
        
    }
}  // BleBrowseView


struct BleBrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BleBrowseView()
    }
}

