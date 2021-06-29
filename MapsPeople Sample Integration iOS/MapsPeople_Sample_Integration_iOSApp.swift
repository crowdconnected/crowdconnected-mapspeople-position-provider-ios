//
//  MapsPeople_Sample_Integration_iOSApp.swift
//  MapsPeople Sample Integration iOS
//
//  Created by Robert Tanase on 29/06/2021.
//

import SwiftUI
import CrowdConnectedIPS

@main
struct MapsPeople_Sample_Integration_iOSApp: App {
    
    init() {
        CrowdConnectedIPS.activate()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
