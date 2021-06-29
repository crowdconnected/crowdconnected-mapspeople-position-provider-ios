//
//  MapsPeopleUIKitView.swift
//  MapsPeople Sample Integration iOS
//
//  Created by Robert Tanase on 29/06/2021.
//

import UIKit
import MapsIndoors
import GoogleMaps

class MapsPeopleUIKitView: UIView {
    
    private let googleMapView: GMSMapView
    private let mapControl: MPMapControl
    
    init() {
        GMSServices.provideAPIKey("YOUR_GOOGLE_API_KEY")
        MapsIndoors.provideAPIKey("YOUR_MAPSPEOPLE_API_KEY", googleAPIKey: "YOUR_GOOGLE_API_KEY")
        
        googleMapView = GMSMapView.map(withFrame: .zero, camera: GMSCameraPosition())
        mapControl = MPMapControl(map: googleMapView)!
        mapControl.showUserPosition(true)
    
        super.init(frame: .zero)

        setupPositioningService()
        setupView()
        animateCameraToVenue()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPositioningService() {
        MapsIndoors.positionProvider = CrowdConnectedPositionProvider()
        MapsIndoors.positionProvider?.startPositioning(nil)
    }
    
    private func setupView() {
        googleMapView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(googleMapView)

        NSLayoutConstraint.activate([
            googleMapView.topAnchor.constraint(equalTo: topAnchor),
            googleMapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            googleMapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            googleMapView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func animateCameraToVenue() {
        let venueProvider = MPVenueProvider.init()
        venueProvider.getVenuesWithCompletion { [weak self] venueCollection, error in
            guard error == nil else {
                return
            }
            guard let venues = venueCollection?.venues,
                  let currentVenue = venues.first as? MPVenue,
                  let venueCoordinateBounds = currentVenue.getBoundingBox() else {
                return
            }
            self?.googleMapView.animate(with: GMSCameraUpdate.fit(venueCoordinateBounds))
        }
    }
}
