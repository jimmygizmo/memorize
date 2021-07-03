//
//  ContentView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 7/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
// TEST: Trying optional specification of a preferred device for the preview pane. If not
// specified (nil), then XCode will choose the device based on the run configuration.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue:
                "iPhone 12 mini (com.apple.CoreSimulator.SimDeviceType.iPhone-12-mini)")
            )
    }
}

// Get a list of simulator device identifiers you can use for the preview device:
// % xcrun simctl list devicetypes

