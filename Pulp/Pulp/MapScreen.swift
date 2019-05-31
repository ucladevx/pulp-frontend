import UIKit
import MapKit
import CoreLocation
import SnapKit
import MapKitGoogleStyler

class MapScreen: UIViewController, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var mapView: MKMapView?
    
    //The range (meter) of how much we want to see arround the user's location
    let distanceSpan: Double = 500
    
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
//        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
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
        
        
        searchBarView.addSubview(searchBar)
        self.view.addSubview(searchBarView)
        
        let buttonItem = MKUserTrackingButton(mapView: mapView)
        buttonItem.frame = CGRect(origin: CGPoint(x:view.frame.width - 70, y: view.frame.height - 70), size: CGSize(width: 35, height: 35))
        
        view.addSubview(buttonItem)
        
        setUpSearchBar()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        if let mapView = self.mapView {
//            let region = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: self.distanceSpan, longitudinalMeters: self.distanceSpan)
            let viewRegion = MKCoordinateRegion(center: newLocation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: true)
            mapView.showsUserLocation = true
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
}

