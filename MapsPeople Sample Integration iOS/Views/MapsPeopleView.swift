//
//  MapsPeopleView.swift
//  MapsPeople Sample Integration iOS
//
//  Created by Robert Tanase on 29/06/2021.
//

import SwiftUI

struct MapsPeopleView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> MapsPeopleUIKitView {
        return MapsPeopleUIKitView()
    }
    
    func updateUIView(_ uiView: MapsPeopleUIKitView, context: Context) { }
}

