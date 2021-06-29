//
//  ContentView.swift
//  MapsPeople Sample Integration iOS
//
//  Created by Robert Tanase on 29/06/2021.
//

import SwiftUI
import CrowdConnectedCore

struct ContentView: View {
    var body: some View {
        MapsPeopleView()
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                CrowdConnected.shared.startNavigation()
            })
            .onDisappear(perform: {
                CrowdConnected.shared.stopNavigation()
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
