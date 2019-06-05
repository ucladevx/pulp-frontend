import UIKit
import MapKit
import CoreLocation
import SnapKit
import MapKitGoogleStyler

class MapScreen: UIViewController, CLLocationManagerDelegate {
    
    var window: UIWindow?
    var mapView: MKMapView?
    var pointAnnotationList:[CustomPointAnnotation] = []
    var pinAnnotationView:MKPinAnnotationView!
    var selectedAnnotation:MKPointAnnotation!
    
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
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchBar: UITextField = {
        let searchbar = UITextField()
        searchbar.placeholder = "Parks, museums, bars, etc.";
        //var textField = searchbar.value(forKey: "searchField") as? UITextField
        //textField?.backgroundColor = .white
        searchbar.textAlignment = .left
        searchbar.font = UIFont(name: "Avenir-Light", size:15)
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        return searchbar
    }()
    
    // Background of the popup
    let popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // Picture of the experience
    let contentImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Default Pic"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let filterButton: UIButton = {
        let btn = UIButton()
        btn.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        btn.setImage(#imageLiteral(resourceName: "SearchTripleBar"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let cancelButton: UIButton = {
        let btn = UIButton()
        btn.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        btn.setImage(#imageLiteral(resourceName: "SearchX"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let vertLineView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "SearchVertBar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Title of the experience
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Venice Canals"
        textView.textColor = .black
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir-Book", size: 18)
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    } ()
    
    // Experience location
    let locationTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Venice Canals, Venice, CA"
        textView.textColor = UIColor(red: 126/255, green: 126/255, blue: 126/255, alpha: 1)
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir-Oblique", size: 12)
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    } ()
    
    // Experience category
    let categoryTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Nature, Photo Ops"
        textView.textColor = UIColor(red: 126/255, green: 126/255, blue: 126/255, alpha: 1)
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir-Oblique", size: 12)
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    } ()
    
    
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
        self.searchBarView.addSubview(filterButton)
        self.searchBarView.addSubview(cancelButton)
        self.searchBarView.addSubview(vertLineView)
        self.view.addSubview(searchBarView)
        
        let buttonItem = MKUserTrackingButton(mapView: mapView)
        buttonItem.frame = CGRect(origin: CGPoint(x:view.frame.width - 70, y: view.frame.height - 70), size: CGSize(width: 35, height: 35))
        
        view.addSubview(buttonItem)
        
        setUpSearchBar()
        
        popupLayout()
        
        //Below code adds Pulp pins to the mapview
        let pinLocation = CLLocationCoordinate2D(latitude: 34.07, longitude: -118.452393)
        
        //Below code sets the new added pin the center of the screen
        let center = pinLocation
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
        mapView!.setRegion(region, animated: true)
        
        //Below code adds pins to the map
        addPin(imageName: "MapFaveIcon", location: pinLocation, title: "Cai's Residence", subtitle: "What's good")
        addPin(imageName: "MapShopIcon", location: pinLocation, title: "Cai's shop", subtitle: "")
        
        
        popupView.addGestureRecognizer(tapRecognizer)
        view.addSubview(popupView)
    }
    
    private var bottomConstraint = NSLayoutConstraint()
    
    private func popupLayout() {
        popupView.layer.cornerRadius = 15
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        bottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 440)
        bottomConstraint.isActive = true
        popupView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(contentImageView)
        contentImageView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 20).isActive = true
        contentImageView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -190).isActive = true
        contentImageView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -315).isActive = true
        contentImageView.heightAnchor.constraint(equalToConstant: 115).isActive = true
        
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(titleTextView)
        titleTextView.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 10).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -305).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(locationTextView)
        locationTextView.leadingAnchor.constraint(equalTo: titleTextView.leadingAnchor).isActive = true
        locationTextView.trailingAnchor.constraint(equalTo: titleTextView.trailingAnchor).isActive = true
        locationTextView.topAnchor.constraint(equalTo: titleTextView.topAnchor, constant: 25).isActive = true
        locationTextView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        categoryTextView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(categoryTextView)
        categoryTextView.leadingAnchor.constraint(equalTo: titleTextView.leadingAnchor).isActive = true
        categoryTextView.trailingAnchor.constraint(equalTo: titleTextView.trailingAnchor).isActive = true
        categoryTextView.topAnchor.constraint(equalTo: titleTextView.topAnchor, constant: 40).isActive = true
        categoryTextView.heightAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    private var currentState: State = .closed
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        recognizer.addTarget(selectedAnnotation, action: #selector(popupViewTapped(recognizer:)))
        return recognizer
    }()
    
    @objc private func popupViewTapped(recognizer: UITapGestureRecognizer) {
        let state = currentState.opposite
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 290
            case .closed:
                self.bottomConstraint.constant = 440
            }
            self.view.layoutIfNeeded()
        })
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            }
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 290
            case .closed:
                self.bottomConstraint.constant = 440
            }
        }
        transitionAnimator.startAnimation()
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
            make.height.equalTo(view.frame.height/20)
            make.top.equalTo(view).offset(60)
        }
        
        searchBar.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(vertLineView).offset(10)
            make.right.equalTo(searchBarView)
            make.top.equalTo(searchBarView)
            make.bottom.equalTo(searchBarView)
        }
        
        filterButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(searchBarView).offset(15)
            //make.right.equalTo(searchBarView)
            make.top.equalTo(searchBarView)
            make.bottom.equalTo(searchBarView)
        }
        
        cancelButton.snp.makeConstraints { (make) -> Void in
            //make.left.equalTo(searchBarView)
            make.right.equalTo(searchBarView).offset(-15)
            make.top.equalTo(searchBarView)
            make.bottom.equalTo(searchBarView)
        }
        
        vertLineView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(searchBarView).offset(38)
            //make.right.equalTo(searchBarView).offset(-15)
            make.top.equalTo(searchBarView).offset(8)
            make.bottom.equalTo(searchBarView).offset(-8)
        }
        searchBar.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        
    }
    
    @objc func myTargetFunction(textField: UITextField) {
        let nextVC = DiveIn()
        self.present(nextVC, animated: true, completion: {
            print("Changes to divein successfully!")
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView!.setRegion(region, animated: true)
        }
    }
    
    //addPin function adds new pins to the map
    private func addPin(imageName:String, location:CLLocationCoordinate2D, title:String, subtitle:String)
    {
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.pinCustomImageName = imageName
        pointAnnotation.coordinate = location
        pointAnnotation.title = title
        pointAnnotation.subtitle = subtitle
        pointAnnotationList.append(pointAnnotation)
        
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
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        self.selectedAnnotation = view.annotation as? CustomPointAnnotation
//        let nextVC = Explore_Controller()
//        self.present(nextVC, animated: true) {
//            print("Segue to explore view successfully!")
//        }
//    }
    
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

private enum State {
    case closed
    case open
}
extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return.open
        }
    }
}
