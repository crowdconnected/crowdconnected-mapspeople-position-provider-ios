//
//  CrowdConnectedPositionProvider.swift
//  MapsPeople Sample Integration iOS
//
//  Created by Robert Tanase on 29/06/2021.
//

import MapsIndoors
import CrowdConnectedCore

class CrowdConnectedPositionProvider: NSObject, MPPositionProvider {
    
    private var running = false
    
    var delegate: MPPositionProviderDelegate?
    var latestPositionResult: MPPositionResult?
    var providerType: MPPositionProviderType = .GPS_POSITION_PROVIDER
    var preferAlwaysLocationPermission: Bool = false
    var locationServicesActive: Bool = false
    
    override init() {
        super.init()

        CrowdConnected.shared.start(appKey: "YOUR_APP_KEY", token: "YOUR_TOKEN", secret: "YOUR_SECRET") { deviceId, error in
            guard error == nil else {
                // Check credentials/network connection
                return
            }
        }
        CrowdConnected.shared.delegate = self
    }

    func requestLocationPermissions() {
        locationServicesActive = true
    }
    
    func updateLocationPermissionStatus() {
        locationServicesActive = true
    }
    
    func startPositioning(_ arg: String?) {
        running = true
    }
    
    func stopPositioning(_ arg: String?) {
        running = false
    }
    
    func startPositioning(after millis: Int32, arg: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(millis))) {
            self.startPositioning(arg)
        }
    }
    
    func isRunning() -> Bool {
        running
    }
}

extension CrowdConnectedPositionProvider: CrowdConnectedDelegate {
    
    func didUpdateLocation(_ locations: [Location]) {
        if running {
            for location in locations {
                latestPositionResult = MPPositionResult()
                latestPositionResult?.geometry = MPPoint(lat: location.latitude, lon: location.longitude, zValue: Double(location.floor))
                latestPositionResult?.provider = self
                latestPositionResult?.headingAvailable = false

                if let delegate = self.delegate,
                   let latestPositionResult = self.latestPositionResult {
                    delegate.onPositionUpdate(latestPositionResult)
                }
            }
        }
    }
}
