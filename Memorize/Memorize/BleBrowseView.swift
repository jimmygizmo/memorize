//
//  BleBrowseView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/2/21.
//

// Work for second part of general Bluetooth BLE tutorial: [Tutorial D - Part 2]
// https://www.novelbits.io/intro-ble-mobile-development-ios-part-2/
// NOTE: This tutorial is designed as a lead-in to a paid course and explains that some key
// functionality related to what we do here, will be found in the main course, not here.
// The article mentions leaving out control of Peripheral advertising, so I will just add that
// in myself if needed.

// IDEA: I can see the near future where I want my apps UI to look and work equally well in both
// light and dark modes. I've started researching/studying this. I might include that in this
// file. I'm liking some of the techniques I see in this areticle:
// https://thinkdiff.net/swiftui-dark-mode-the-easiest-way-81e48d055189
// And this looks like a good and thorough article as well:
// https://www.avanderlee.com/swift/dark-mode-support-ios/
// One more:
// https://blog.waldo.io/swiftui-dark-mode/
// TODO: Dark mode links added to notes. Can be removed from here after looking closer at these.
// Looks like not too much is needed unless you use/mix many colors in the UI. For default
// backgrounds, the switching of text and probably also standard control colors would be
// automatic.

// Lists() reference - This will be an often-used and important UI component.
// https://developer.apple.com/documentation/swiftui/list


import SwiftUI


//struct Peripheral: Identifiable {
//    let name: String
//    //let uuid: UUID
//    //let rssi: Double?
//    let id = UUID()  // I made this for test data. Looks like the one from the tutorial
//    // will use an Int for id. Will add comment if I figure out why they chose Int, since
//    // UUID is the ID of a Peripheral by definition since that field is required by
//    // Bluetooth itself anyhow.
//}


struct BleBrowseView: View {
    
    @ObservedObject var bleManager = BleManager()
    
    @State private var selectedPeripheral: UUID?
    
    var body: some View {
        
        VStack (spacing: 10) {  // - WINDOW
            
            Text("Bluetooth Devices")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
            
            List(bleManager.viewDiscoveredPeripherals,
                 selection: $selectedPeripheral){  // - PERIPHERALS
                
                    Text($0.name)
                        .italic()
                    Text($0.nameAdvertised)
                        .italic()
                    Text(String($0.rssi))
                        .italic()
                
            }  // List - PERIPHERALS
            .frame(height: 300)
            
            
            Spacer()
            
            Text("STATUS")
                .font(.headline)
            
            if bleManager.viewBleState {
                Text("Bluetooth is powered ON")
                    .foregroundColor(Color.green)
            } else {
                Text("Bluetooth is powered OFF")
                    .foregroundColor(Color.red)
            }
            
            
            HStack {  // - CONTROLS
                VStack (spacing: 10) {
                    Button(action: {
                        self.bleManager.startScanning()
                    }) {
                        Text("Start Scan")
                    }
                    
                    Button(action: {
                        self.bleManager.stopScanning()
                    }) {
                        Text("Stop Scan")
                    }
                }
                .padding()
                
                VStack (spacing: 10) {
                    Button(action: {
                        print("Start advertising")
                    }) {
                        Text("Start Adv")
                    }
                    
                    Button(action: {
                        print("Stop advertising")
                    }) {
                        Text("Stop Adv")
                    }
                }
                .padding()
            }  // HStack - CONTROLS
            
            Spacer()
            
        }  // - WINDOW
        
    }  // var body View
}  // BleBrowseView


struct BleBrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BleBrowseView()
            .previewDevice("iPhone 12 mini")
//            .previewDevice("iPhone 6s Plus")
            .preferredColorScheme(.dark)  // Comment this out for .light, which is the default.
    }
}

