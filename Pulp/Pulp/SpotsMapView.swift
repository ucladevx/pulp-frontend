//
//  mapView.swift
//  Pulp
//
//  Created by Andy Cai on 5/7/19.
//  Copyright © 2019 Andy Cai. All rights reserved.
//

import UIKit
import MapKit

class SpotsMapView: UIViewController, CLLocationManagerDelegate {
    
    var window: UIWindow?
//    var mapView: MKMapView?
    var locationManager: CLLocationManager?
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 500
    
    private let contentView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var mapView:MKMapView = {
        let mView = MKMapView();
        mView.translatesAutoresizingMaskIntoConstraints = false;
        return mView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(rgb: 0xF7F7F7)
        
        self.view.addSubview(self.mapView)
//        contentView.addSubview(mapView)
        view.addSubview(contentView)
        
        self.locationManager = CLLocationManager()
        if let locationManager = self.locationManager {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.requestAlwaysAuthorization()
            locationManager.distanceFilter = 50
            locationManager.startUpdatingLocation()
        }
        
        setUpAutoLayout()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        let region = MKCoordinateRegion.init(center: newLocation.coordinate, latitudinalMeters: self.distanceSpan, longitudinalMeters: self.distanceSpan)
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    func setUpAutoLayout()
    {
        contentView.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 20).isActive = true
        contentView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: -20).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height*2/3).isActive = true
//        contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true //this line of code centers the view
        
        mapView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
}
