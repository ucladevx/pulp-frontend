import UIKit
import MapKit
import CoreLocation
import SnapKit
import MapKitGoogleStyler

class MapScreen: UIViewController, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var mapView: MKMapView?
    var pointAnnotation:CustomPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 200
    
    var locationManager: CLLocationManager = {
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        return locationManager
    }()
    
    let searchBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchBar: UISearchBar = {
        let searchbar = UISearchBar()
        searchbar.layer.borderWidth = 0
        searchbar.layer.borderColor = UIColor.black.cgColor
        searchbar.searchBarStyle = UISearchBar.Style.minimal
        searchbar.placeholder = "Parks, mueseums, bars, etc.";
        var textField = searchbar.value(forKey: "searchField") as? UITextField
        textField?.backgroundColor = .white
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        return searchbar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.clear
        
        self.mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: (self.window?.frame.width)!, height: (self.window?.frame.height)!))
        
        self.locationManager.delegate = self
        
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView?.setRegion(viewRegion, animated: true)
        }
        
        mapView?.delegate = self
        configureTileOverlay()
        
        self.mapView!.showsCompass = true
        self.mapView!.showsBuildings = true
        self.mapView!.showsUserLocation = true
        self.view.addSubview(self.mapView!)
        self.searchBarView.addSubview(searchBar)
        self.view.addSubview(searchBarView)
        
        let buttonItem = MKUserTrackingButton(mapView: mapView)
        buttonItem.frame = CGRect(origin: CGPoint(x:view.frame.width - 70, y: view.frame.height - 70), size: CGSize(width: 35, height: 35))
        
        view.addSubview(buttonItem)
        
        setUpSearchBar()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if let mapView = self.mapView {
            let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: self.distanceSpan, longitudinalMeters: self.distanceSpan)
//            let viewRegion = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(region, animated: true)
            mapView.isZoomEnabled = true
        }
    }
    
    
    
    private func configureTileOverlay() {
        // We first need to have the path of the overlay configuration JSON
        guard let overlayFileURLString = Bundle.main.path(forResource: "overlay", ofType: "json") else {
            return
        }
        let overlayFileURL = URL(fileURLWithPath: overlayFileURLString)
        
        // After that, you can create the tile overlay using MapKitGoogleStyler
        guard let tileOverlay = try? MapKitGoogleStyler.buildOverlay(with: overlayFileURL) else {
            return
        }
        
        // And finally add it to your MKMapView
        mapView!.addOverlay(tileOverlay)
    }
    
    func setUpSearchBar() {
        searchBarView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
            make.height.equalTo(view.frame.height/8)
            make.top.equalTo(view).offset(20)
        }
        
        searchBar.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(searchBarView)
            make.right.equalTo(searchBarView)
            make.top.equalTo(searchBarView)
            make.bottom.equalTo(searchBarView)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView!.setRegion(region, animated: true)
        }
        
        let location = CLLocationCoordinate2D(latitude: 34.07, longitude: -118.452393)
        
        //Below code sets the new added pin the center of the screen
        let center = location
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
        mapView!.setRegion(region, animated: true)
        
        //Toggle the new pin's parameters, thinking of creating a function to create pins with these parameters
        pointAnnotation = CustomPointAnnotation()
        pointAnnotation.pinCustomImageName = "MapFaveIcon"
        pointAnnotation.coordinate = location
        pointAnnotation.title = "Random Attraction"
        pointAnnotation.subtitle = "Some random attraction"

        pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: "pin")
        mapView!.addAnnotation(pinAnnotationView.annotation!)
    }
    
}

extension MapScreen: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // This is the final step. This code can be copied and pasted into your project
        // without thinking on it so much. It simply instantiates a MKTileOverlayRenderer
        // for displaying the tile overlay.
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
    
    //MARK: - Custom Annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //Below code checks if the pin is the user location pin, if it is, skips the rest of the code
        if (annotation.isKind(of: MKUserLocation.self)){
            return nil
        }
        
        //Otherwise, create a customized Pulp pin
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        if let customPointAnnotation = annotation as? CustomPointAnnotation {
        annotationView?.image = UIImage(named: customPointAnnotation.pinCustomImageName)
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.setCenter(userLocation.coordinate, animated: true)
    }
}

