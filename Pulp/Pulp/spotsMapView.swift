//
//  mapView.swift
//  Pulp
//
//  Created by Andy Cai on 5/7/19.
//  Copyright © 2019 Andy Cai. All rights reserved.
//

import UIKit
import MapKit

class spotsMapView: UIViewController, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var mapView: MKMapView?
    var locationManager: CLLocationManager?
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = .white
        
        self.mapView = MKMapView(frame: CGRect(x:0, y:20, width:(self.window?.frame.width)!, height:300))
        self.view.addSubview(self.mapView!)
        
        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if let mapView = self.mapView {
            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, self.distanceSpan, self.distanceSpan)
            mapView.setRegion(region, animated: true)
            mapView.showsUserLocation = true
        }
    }
    
}
