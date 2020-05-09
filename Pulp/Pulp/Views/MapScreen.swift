import UIKit
import MapKit
import CoreLocation
import SnapKit
import MapKitGoogleStyler
import Moya

class CustomPointAnnotation: MKPointAnnotation {
    var pinCustomImageName:String!
    var indexNum:Int!
}
let mapDispatch = DispatchGroup()
let popupView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 30
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.2
    view.layer.shadowOffset = .zero
    view.layer.shadowRadius = 5
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()
let popupLocationView = UIView()
let popupDiveinView = UIView()
class MapScreen: UIViewController, CLLocationManagerDelegate,UICollectionViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    var isDisplayingLocation = false
    var isDisplayingDivein = false
    var window: UIWindow?
    var mapView: MKMapView?
    var pointAnnotationList:[CustomPointAnnotation] = []
    var pinAnnotationView:MKPinAnnotationView!
    var selectedAnnotation:MKPointAnnotation!
    var currentLocation:CLLocation!
    var selectedPlace: Place?
    var collectionView: UICollectionView?
    var place : Place?
    var zoomCheck = true
    var lastLocation: CLLocation?
    let distanceSpan: Double = 500
    
    var locationManager: CLLocationManager = {
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
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
    let searchBar: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Dive in!", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Light", size:15)
        button.layer.cornerRadius = 10
        button.setTitleColor( .gray, for: .normal)
        return button
    }()
    let searchBarTextField: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Parks, museums, bars, etc."
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.font = UIFont(name: "Avenir-Light", size:15)
        txtField.textColor = UIColor.gray
        txtField.returnKeyType = UIReturnKeyType.go;
        txtField.enablesReturnKeyAutomatically = true;
        txtField.spellCheckingType = .no
        txtField.isHidden = true
        return txtField
    }()
    let searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(">", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = UIColor(red: 249/255, green: 160/255, blue: 119/255, alpha: 1)
        btn.layer.cornerRadius = 10
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        return btn
    }()
    
    // Background of the popup
    
    
    // Picture of the experience
    let contentImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 28
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // Title of the experience
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Venice Canals"
        textView.textColor = UIColor(red: 135/255, green: 132/255, blue: 132/255, alpha: 1)
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir-Book", size: 24)
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    } ()
    
    // Experience location
    let locationTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Venice, CA"
        textView.textColor = UIColor(red: 126/255, green: 126/255, blue: 126/255, alpha: 1)
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir-Book Italic", size: 15)
        textView.font = UIFont.italicSystemFont(ofSize: 15)
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    } ()
    
    let ratingPulpsIconView: RatingPulpsIconView = {
        let ratingView = RatingPulpsIconView(frame: CGRect(x: 0, y: 0, width: 150, height: 80))
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.fullImage = UIImage(named: "Rating_Full")
        ratingView.emptyImage = UIImage(named: "Rating_Empty")
        ratingView.backgroundColor =  UIColor.clear
        return ratingView
    }()
    
    let ratingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Experience category
    let profile1ImageView: UIImageView = UIImageView()
    let profile2ImageView: UIImageView = UIImageView()
    let profile3ImageView: UIImageView = UIImageView()
    let profile4ImageView: UIImageView = UIImageView()
    
    let checkThisOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let OpenerUp: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Home-1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let OpenerDown: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Home-1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let Title: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "PulpTitle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let Profile1ImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let Profile2ImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let Profile3ImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let Profile4ImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let FriendImagesView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Dive In Popup Views
    let restaurantsImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "RestaurantIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let restaurantsButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let restaurantsLabel:UILabel = {
        let label = UILabel()
        label.text = "Restaurants"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let museumImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Museum"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let museumLabel:UILabel = {
        let label = UILabel()
        label.text = "Museums"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let museumButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let festivalImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Festival"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let festivalLabel:UILabel = {
        let label = UILabel()
        label.text = "Festivals"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let festivalButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let thrillImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Thrill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let thrillLabel:UILabel = {
        let label = UILabel()
        label.text = "Thrill"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let thrillButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Photo Op"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let photoLabel:UILabel = {
        let label = UILabel()
        label.text = "Photo Ops"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photoButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let animalImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Animal"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let animalLabel:UILabel = {
        let label = UILabel()
        label.text = "Animals"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let animalButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let landscapeImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Landscape"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let landscapeLabel:UILabel = {
        let label = UILabel()
        label.text = "Landscapes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let landscapeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let aquaticImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Aquatic"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let aquaticLabel:UILabel = {
        let label = UILabel()
        label.text = "Aquatic"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let aquaticButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    let FeedButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        btn.titleEdgeInsets.left = 10
        btn.titleEdgeInsets.right = 10
        btn.setTitle("< Feed", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = .zero
        btn.layer.shadowRadius = 5
        return btn
    }()
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(Title)
        view.addSubview(OpenerDown)
        view.addSubview(OpenerUp)
        OpenerUp.center = CGPoint(x: 270, y: view.bounds.height + 110)
        OpenerDown.center = CGPoint(x: 240, y: view.bounds.height + 10)
        
        Title.center = CGPoint(x: (view.bounds.width * 0.5), y: (view.bounds.height * 0.45))
        Title.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        OpenerUp.alpha = 1.0
        OpenerDown.alpha = 1.0
        
        print(USERID)
        setupDiveinButtonDestination()

        mapDispatch.enter()
        GetMapPlaces(fromMap: true)
        mapDispatch.notify(queue: .main) {
            UIView.animate(withDuration: 1.0, delay: 1, options: [.curveEaseInOut , .allowUserInteraction],
                animations: {
                    self.OpenerUp.center = CGPoint(x: 130, y: -50)
                    self.OpenerUp.transform = CGAffineTransform(rotationAngle: (.pi-0.5 ))
                    self.OpenerDown.center = CGPoint(x: 300, y: self.view.bounds.height + 70)
                    self.OpenerDown.transform = CGAffineTransform(rotationAngle: (-0.5))
                   },
                completion: { finished in
                print("Animation Done")
                print("Updated Friend Places")
                if !FriendPlaces.isEmpty{
                    self.place = FriendPlaces[0]
                    }
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.view.backgroundColor = UIColor.clear
                self.mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: (self.window?.frame.width)!, height: (self.window?.frame.height)!))
                        
                self.locationManager.delegate = self
                        
                if let userLocation = self.locationManager.location?.coordinate {
                    let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters:1700, longitudinalMeters: 1700)
                    self.mapView?.setRegion(viewRegion, animated: true)
                    print("Correct Area")
                    }
                self.locationManager.stopUpdatingLocation()
                        
                self.mapView?.delegate = self
                self.configureTileOverlay()
                        
                self.mapView!.showsCompass = true
                self.mapView!.showsBuildings = true
                self.mapView!.showsUserLocation = true
                self.mapView!.addGestureRecognizer(self.mapTapRecognizer)
                self.mapTapRecognizer.delegate = self.mapView! as! UIGestureRecognizerDelegate
                self.view.addSubview(self.mapView!)
                
                self.searchBarView.addSubview(self.searchBar)
                self.searchBarView.addSubview(self.searchBarTextField)
                self.searchBarTextField.delegate = self
                self.searchBarView.addSubview(self.searchButton)
                self.searchButton.addTarget(self, action: #selector(self.searchButtonTapped), for: .touchDown)
                self.view.addSubview(self.searchBarView)
                self.view.addSubview(self.FeedButton)
                self.FeedButton.addTarget(self, action: #selector(self.feedButtonTapped), for: .touchDown)
                        
                let buttonItem = MKUserTrackingButton(mapView: self.mapView)
                buttonItem.frame = CGRect(origin: CGPoint(x:self.view.frame.width - 70, y: self.view.frame.height - 70), size: CGSize(width: 35, height: 35))
                        
                self.view.addSubview(buttonItem)
                        
                self.setUpSearchBar()
                
                self.popupLayout()
                        
                if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
                            
                    self.currentLocation = self.locationManager.location
                        for place in FriendPlaces {
                            let pinLocation = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                            self.addPin(imageName: "MapFaveIcon", location: pinLocation, title: place.name, subtitle: "")
                            }
                        }
                            popupLocationView.addGestureRecognizer(self.tapRecognizer)
            })
            
        }
    
    }
    
    var viewTranslation = CGPoint(x: 0, y: 0)
    @objc func handleDismiss(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            viewTranslation = sender.translation(in: view)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: self.viewTranslation.y)
            })
        case .ended:
            if viewTranslation.y < 200 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.view.transform = .identity
                })
            } else {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    private var bottomConstraint = NSLayoutConstraint()
    
    //MARK: - Set up popup window
    private func popupLayout() {
        view.addSubview(popupView)
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        bottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 440)
        bottomConstraint.isActive = true
        popupView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        popupView.addSubview(popupLocationView)
        popupLocationView.translatesAutoresizingMaskIntoConstraints = false
        popupLocationView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor).isActive = true
        popupLocationView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor).isActive = true
        popupLocationView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor).isActive = true
        popupLocationView.topAnchor.constraint(equalTo: popupView.topAnchor).isActive = true
        
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        popupLocationView.addSubview(contentImageView)
        contentImageView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15).isActive = true
        contentImageView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -190).isActive = true
        contentImageView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 15).isActive = true
        contentImageView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -295).isActive = true
        //contentImageView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
     
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        popupLocationView.addSubview(titleTextView)
        titleTextView.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 10).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -10).isActive = true
        titleTextView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 8).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleTextView.sizeToFit()
        titleTextView.isScrollEnabled = false
        
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        popupLocationView.addSubview(locationTextView)
        locationTextView.leadingAnchor.constraint(equalTo: titleTextView.leadingAnchor).isActive = true
        locationTextView.trailingAnchor.constraint(equalTo: titleTextView.trailingAnchor).isActive = true
        locationTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: -20).isActive = true
        locationTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        popupLocationView.addSubview(ratingView)
        ratingView.addSubview(ratingPulpsIconView)
        ratingView.topAnchor.constraint(equalTo: locationTextView.bottomAnchor, constant: -20).isActive = true
        ratingView.leftAnchor.constraint(equalTo: contentImageView.rightAnchor, constant: 10).isActive = true
        
        popupLocationView.addSubview(FriendImagesView)

        FriendImagesView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 35).isActive = true
        FriendImagesView.rightAnchor.constraint(equalTo: popupView.rightAnchor, constant: -60).isActive = true
    
        popupLocationView.addSubview(checkThisOutButton)
        checkThisOutButton.isUserInteractionEnabled = true
        checkThisOutButton.topAnchor.constraint(equalTo: popupView.topAnchor).isActive = true
        checkThisOutButton.rightAnchor.constraint(equalTo: popupView.rightAnchor).isActive = true
        checkThisOutButton.leftAnchor.constraint(equalTo: popupView.leftAnchor).isActive = true
        checkThisOutButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor).isActive = true
        
        checkThisOutButton.addTarget(self, action: #selector(self.checkthisoutTapped(_:)), for: .touchUpInside)
        
        popupView.addSubview(popupDiveinView)
        popupDiveinView.translatesAutoresizingMaskIntoConstraints = false
        popupDiveinView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor).isActive = true
        popupDiveinView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor).isActive = true
        popupDiveinView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor).isActive = true
        popupDiveinView.topAnchor.constraint(equalTo: popupView.topAnchor).isActive = true
        
        let popupDiveinViewWidth = view.frame.size.width - 20
        
        // RESTAURANTS BUTTON
        popupDiveinView.addSubview(restaurantsImageView)

        restaurantsImageView.centerXAnchor.constraint(equalTo: popupDiveinView.centerXAnchor, constant: -popupDiveinViewWidth/3).isActive = true
        
        restaurantsImageView.topAnchor.constraint(equalTo: popupDiveinView.topAnchor, constant: 10).isActive = true
        restaurantsImageView.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
        
        
        popupDiveinView.addSubview(restaurantsLabel)
        restaurantsLabel.centerXAnchor.constraint(equalTo: restaurantsImageView.centerXAnchor).isActive = true
    restaurantsLabel.topAnchor.constraint(equalTo:restaurantsImageView.bottomAnchor).isActive = true
        restaurantsLabel.font = UIFont(name: "Avenir-Medium", size: 13.5)
        
        popupDiveinView.addSubview(restaurantsButton)
        restaurantsButton.centerXAnchor.constraint(equalTo: restaurantsImageView.centerXAnchor).isActive = true
        restaurantsButton.centerYAnchor.constraint(equalTo: restaurantsImageView.centerYAnchor).isActive = true
    restaurantsButton.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
        restaurantsButton.widthAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true

        // MUSEUM BUTTON
        popupDiveinView.addSubview(museumImageView)
        museumImageView.centerXAnchor.constraint(equalTo: popupDiveinView.centerXAnchor, constant: -popupDiveinViewWidth/9).isActive = true
        museumImageView.topAnchor.constraint(equalTo: popupDiveinView.topAnchor, constant: 10).isActive = true
         museumImageView.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true

        popupDiveinView.addSubview(museumLabel)
        museumLabel.centerXAnchor.constraint(equalTo: museumImageView.centerXAnchor).isActive = true
        museumLabel.topAnchor.constraint(equalTo:museumImageView.bottomAnchor).isActive = true
        museumLabel.font = UIFont(name: "Avenir-Medium", size: 13.5)

        popupDiveinView.addSubview(museumButton)
        museumButton.centerXAnchor.constraint(equalTo: museumImageView.centerXAnchor).isActive = true
        museumButton.centerYAnchor.constraint(equalTo: museumImageView.centerYAnchor).isActive = true
        museumButton.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
        museumButton.widthAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true


        // FESTIVAL BUTTON
        popupDiveinView.addSubview(festivalImageView)
        festivalImageView.centerXAnchor.constraint(equalTo: popupDiveinView.centerXAnchor, constant: popupDiveinViewWidth/9).isActive = true
        festivalImageView.topAnchor.constraint(equalTo: popupDiveinView.topAnchor, constant: 10).isActive = true
        festivalImageView.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true

        popupDiveinView.addSubview(festivalLabel)
        festivalLabel.centerXAnchor.constraint(equalTo: festivalImageView.centerXAnchor).isActive = true
        festivalLabel.topAnchor.constraint(equalTo:festivalImageView.bottomAnchor).isActive = true
        festivalLabel.font = UIFont(name: "Avenir-Medium", size: 13.5)

        popupDiveinView.addSubview(festivalButton)
        festivalButton.centerXAnchor.constraint(equalTo: festivalImageView.centerXAnchor).isActive = true
        festivalButton.centerYAnchor.constraint(equalTo: festivalImageView.centerYAnchor).isActive = true
        festivalButton.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
        festivalButton.widthAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true


        // THRILL BUTTON
        popupDiveinView.addSubview(thrillImageView)
        thrillImageView.centerXAnchor.constraint(equalTo: popupDiveinView.centerXAnchor, constant: popupDiveinViewWidth/3).isActive = true
        thrillImageView.topAnchor.constraint(equalTo: popupDiveinView.topAnchor, constant: 10).isActive = true
        thrillImageView.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true

        popupDiveinView.addSubview(thrillLabel)
        thrillLabel.centerXAnchor.constraint(equalTo: thrillImageView.centerXAnchor).isActive = true
        thrillLabel.topAnchor.constraint(equalTo:thrillImageView.bottomAnchor).isActive = true
        thrillLabel.font = UIFont(name: "Avenir-Medium", size: 13.5)

        popupDiveinView.addSubview(thrillButton)
        thrillButton.centerXAnchor.constraint(equalTo: thrillImageView.centerXAnchor).isActive = true
        thrillButton.centerYAnchor.constraint(equalTo: thrillImageView.centerYAnchor).isActive = true
        thrillButton.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
        thrillButton.widthAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true

        // Photo Button
        popupDiveinView.addSubview(photoImageView)

        photoImageView.centerXAnchor.constraint(equalTo: popupDiveinView.centerXAnchor, constant: -popupDiveinViewWidth/3).isActive = true
        
        photoImageView.topAnchor.constraint(equalTo: restaurantsLabel.bottomAnchor, constant: 10).isActive = true
    photoImageView.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
        
        
        popupDiveinView.addSubview(photoLabel)
        photoLabel.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor).isActive = true
    photoLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor).isActive = true
        photoLabel.font = UIFont(name: "Avenir-Medium", size: 13.5)
        
        popupDiveinView.addSubview(photoButton)
        photoButton.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor).isActive = true
        photoButton.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
    
        photoButton.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
        photoButton.widthAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true

        // ANIMAL BUTTON
        popupDiveinView.addSubview(animalImageView)
        animalImageView.centerXAnchor.constraint(equalTo: popupDiveinView.centerXAnchor, constant: -popupDiveinViewWidth/9).isActive = true
        animalImageView.topAnchor.constraint(equalTo: museumLabel.bottomAnchor, constant: 10).isActive = true
         animalImageView.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true

        popupDiveinView.addSubview(animalLabel)
        animalLabel.centerXAnchor.constraint(equalTo: animalImageView.centerXAnchor).isActive = true
        animalLabel.topAnchor.constraint(equalTo:animalImageView.bottomAnchor).isActive = true
        animalLabel.font = UIFont(name: "Avenir-Medium", size: 13.5)

        popupDiveinView.addSubview(animalButton)
        animalButton.centerXAnchor.constraint(equalTo: animalImageView.centerXAnchor).isActive = true
        animalButton.centerYAnchor.constraint(equalTo: animalImageView.centerYAnchor).isActive = true
        animalButton.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
        animalButton.widthAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true


        // LANDSCAPE BUTTON
        popupDiveinView.addSubview(landscapeImageView)
        landscapeImageView.centerXAnchor.constraint(equalTo: popupDiveinView.centerXAnchor, constant: popupDiveinViewWidth/9).isActive = true
        landscapeImageView.topAnchor.constraint(equalTo: festivalLabel.bottomAnchor, constant: 10).isActive = true
        landscapeImageView.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true

        popupDiveinView.addSubview(landscapeLabel)
        landscapeLabel.centerXAnchor.constraint(equalTo: landscapeImageView.centerXAnchor).isActive = true
        landscapeLabel.topAnchor.constraint(equalTo:landscapeImageView.bottomAnchor).isActive = true
        landscapeLabel.font = UIFont(name: "Avenir-Medium", size: 13.5)

        popupDiveinView.addSubview(landscapeButton)
        landscapeButton.centerXAnchor.constraint(equalTo: landscapeImageView.centerXAnchor).isActive = true
        landscapeButton.centerYAnchor.constraint(equalTo: landscapeImageView.centerYAnchor).isActive = true
        landscapeButton.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
        landscapeButton.widthAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true


        // AQUATIC BUTTON
        popupDiveinView.addSubview(aquaticImageView)
        aquaticImageView.centerXAnchor.constraint(equalTo: popupDiveinView.centerXAnchor, constant: popupDiveinViewWidth/3).isActive = true
        aquaticImageView.topAnchor.constraint(equalTo: thrillLabel.bottomAnchor, constant: 10).isActive = true
        aquaticImageView.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true

        popupDiveinView.addSubview(aquaticLabel)
        aquaticLabel.centerXAnchor.constraint(equalTo: aquaticImageView.centerXAnchor).isActive = true
        aquaticLabel.topAnchor.constraint(equalTo:aquaticImageView.bottomAnchor).isActive = true
        aquaticLabel.font = UIFont(name: "Avenir-Medium", size: 13.5)

        popupDiveinView.addSubview(aquaticButton)
        aquaticButton.centerXAnchor.constraint(equalTo: aquaticImageView.centerXAnchor).isActive = true
        aquaticButton.centerYAnchor.constraint(equalTo: aquaticImageView.centerYAnchor).isActive = true
        aquaticButton.heightAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
        aquaticButton.widthAnchor.constraint(equalToConstant:popupDiveinViewWidth/4.5).isActive = true
    }
    
    //MARK: - Location Popup Tapped
    @objc func checkthisoutTapped(_ sender: UIButton) {
        if(isDisplayingLocation) {
            impact.impactOccurred()
            let nextVC = Explore_Controller()
            nextVC.ratingViewStart = ratingView.superview?.convert(ratingView.frame.origin, to: nil)
            nextVC.locationImageStart = contentImageView.superview?.convert(contentImageView.frame.origin, to: nil)
            nextVC.selectedLocation = sender.tag
            nextVC.isDatabasePlace = true
            ratingPulpsIconView.isHidden = true
            contentImageView.isHidden = true
            nextVC.mapSnapshotView = view.snapshotView(afterScreenUpdates: true)
            ratingPulpsIconView.isHidden = false
            contentImageView.isHidden = false
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: false, completion: {
                print("Changes to explore page successfully!")
            })
        }
    }
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        return recognizer
    }()
    
    private lazy var mapTapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(mapTapped))
        return recognizer
    }()
    
    @objc private func mapTapped() {
        if(isDisplayingDivein) {
            impact.impactOccurred()
            // Popup slides down
            let transitionAnimator = UIViewPropertyAnimator(duration: 0.9, dampingRatio: 1, animations: {
                self.bottomConstraint.constant = 440
                self.searchButton.isHidden = true
                self.searchBarTextField.isHidden = true
                self.searchBar.isHidden = false
                self.view.layoutIfNeeded()
            })
            place = nil
            isDisplayingDivein = false
            transitionAnimator.startAnimation()
        }
    }
    
    //MARK: - Location Pin Tapped
    @objc private func popupViewTapped(recognizer: UITapGestureRecognizer, index: Int) {
        impact.impactOccurred()
        place = FriendPlaces[index]
        contentImageView.loadImage(urlString: place?.image ?? defaultURL)
        titleTextView.text = place?.name
        
        let textViewSize = titleTextView.frame.size;
        let fixedWidth = textViewSize.width;
        let expectSize = titleTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)));

        var expectFont = titleTextView.font;
        if (expectSize.height > textViewSize.height) {
            while (titleTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height > textViewSize.height) {
                expectFont = titleTextView.font!.withSize(titleTextView.font!.pointSize - 1)
                titleTextView.font = expectFont
            }
        }
        else {
            while (titleTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT))).height < textViewSize.height) {
                expectFont = titleTextView.font;
                titleTextView.font = titleTextView.font!.withSize(titleTextView.font!.pointSize + 1)
            }
            titleTextView.font = expectFont
        }

        let cityState = (place?.city ?? "") + ", " + (place?.state ?? "")
        locationTextView.text = cityState
        let tags = place?.tags
        
        var rating: Double = place?.rating ?? 0
        rating = floor(rating * 2 + 0.5) / 2 //rounding to nearest .5
        ratingPulpsIconView.rating = rating
        let a = [String] ()
        let imageStringArray: [String] = place?.fbvisitors ?? a;
        
        func addImagetoFriendImagesView(url:String, view:CustomImageView){
            view.loadImage(urlString: url)
            view.widthAnchor.constraint(equalToConstant:40).isActive = true
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
            view.clipsToBounds = true
            view.layoutIfNeeded()
            view.layer.cornerRadius = view.frame.size.width / 2
        }
            
        if(imageStringArray.count >= 1){
                addImagetoFriendImagesView(url: imageStringArray[0], view: Profile1ImageView)
                FriendImagesView.addArrangedSubview(Profile1ImageView)
            }
        if(imageStringArray.count >= 2){
                addImagetoFriendImagesView(url: imageStringArray[1], view: Profile2ImageView)
                FriendImagesView.addArrangedSubview(Profile2ImageView)
            }
        if(imageStringArray.count >= 3){
                addImagetoFriendImagesView(url: imageStringArray[2], view: Profile3ImageView)
                FriendImagesView.addArrangedSubview(Profile3ImageView)
            }
        if(imageStringArray.count >= 4){
                addImagetoFriendImagesView(url: imageStringArray[3], view: Profile4ImageView)
                FriendImagesView.addArrangedSubview(Profile4ImageView)
            }
        
       
//        setupFriendPhotos()
        checkThisOutButton.tag = index
        
        // slide divein popup down if it's open
        var animationDelay: TimeInterval = 0
        if(isDisplayingDivein) {
            let closePopupAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1, animations: {
                self.bottomConstraint.constant = 440
                self.searchButton.isHidden = true
                self.searchBarTextField.isHidden = true
                self.searchBar.isHidden = false
                self.view.layoutIfNeeded()
            })
            closePopupAnimator.addCompletion({_ in
                popupDiveinView.isHidden = true
                popupLocationView.isHidden = false
            })
            closePopupAnimator.startAnimation()
            animationDelay = 0.5
            isDisplayingDivein = false
        }
        else {
            popupDiveinView.isHidden = true
            popupLocationView.isHidden = false
        }
        
        // Popup slides up
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
                self.bottomConstraint.constant = 280
                self.view.layoutIfNeeded()
        })
        if(isDisplayingLocation == false) {
            transitionAnimator.startAnimation(afterDelay: animationDelay)
            isDisplayingLocation = true
        }
    }
    
    //MARK: - Location popup closed
    @objc private func popupViewClosed(recognizer: UITapGestureRecognizer) {
        impact.impactOccurred()
        // Popup slides down
        let transitionAnimator = UIViewPropertyAnimator(duration: 0.9, dampingRatio: 1, animations: {
                self.bottomConstraint.constant = 440
                self.view.layoutIfNeeded()
        })
        place = nil
        isDisplayingLocation = false
        transitionAnimator.startAnimation()
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
    
    //MARK: - Set up Dive In Buttons
    func setupDiveinButtonDestination(){
        restaurantsButton.tag=0
        restaurantsButton.addTarget(self, action: #selector(self.diveinTapped(_:)), for: .touchUpInside)
        museumButton.tag=1
        museumButton.addTarget(self, action: #selector(self.diveinTapped), for: .touchUpInside)
        festivalButton.tag=2
        festivalButton.addTarget(self, action: #selector(self.diveinTapped), for: .touchUpInside)
        thrillButton.tag=3
        thrillButton.addTarget(self, action: #selector(self.diveinTapped), for: .touchUpInside)
        
        photoButton.tag=4
        photoButton.addTarget(self, action: #selector(self.diveinTapped), for: .touchUpInside)
        animalButton.tag=5
        animalButton.addTarget(self, action: #selector(self.diveinTapped), for: .touchUpInside)
        landscapeButton.tag=6
        landscapeButton.addTarget(self, action: #selector(self.diveinTapped), for: .touchUpInside)
        aquaticButton.tag=7
        aquaticButton.addTarget(self, action: #selector(self.diveinTapped), for: .touchUpInside)

    }
    
    //MARK: - Dive In Button Tapped
    @objc func diveinTapped(_ sender: UIButton) {
        impact.impactOccurred()
        var searchTerm: String
        switch sender.tag {
            case 0:
            searchTerm = "Restaurant"
            case 1:
            searchTerm = "Museum"
            case 2:
            searchTerm = "Festival"
            case 3:
            searchTerm = "Thrill"
            case 4:
            searchTerm = "Photo"
            case 5:
            searchTerm = "Zoo"
            case 6:
            searchTerm = "Landscape"
            case 7:
            searchTerm = "Aquatic"
            
        default:
            searchTerm = ""
        }
        yelpDispatchGroup.enter()
        //get current location
        locationManager.startUpdatingLocation()
        var Latt = 34.073121 //default location if current not found
        var Long = -118.454704
        if let userLocation = self.locationManager.location?.coordinate {
            Latt = userLocation.latitude
            Long = userLocation.longitude
        }
        locationManager.stopUpdatingLocation()
        
        YelpSearchFunc(latt: Latt, longi:  Long, sterm: searchTerm, limitN: 10)
        yelpDispatchGroup.notify(queue: .main) {
            print("Moving to list_view")
            let nextVC = ListView_Controller()
            nextVC.searchTerm = searchTerm
            self.present(nextVC, animated: true, completion: {
            print("Changes to list_view successfully!")
        })
        }
    }
    
    //MARK: - Search Bar Layout
    func setUpSearchBar() {
        searchBarView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
            make.height.equalTo(view.frame.height/20)
            make.top.equalTo(view).offset(60)
        }
        
        searchBar.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(searchBarView)
            make.right.equalTo(searchBarView)
            make.top.equalTo(searchBarView)
            make.bottom.equalTo(searchBarView)
        }
        
        searchButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(40)
            make.right.equalTo(searchBar).offset(-2)
            make.top.equalTo(searchBar).offset(2)
            make.bottom.equalTo(searchBar).offset(-2)
        }
        
        searchBarTextField.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(searchBar).offset(20)
            make.right.equalTo(searchButton.snp_left).offset(-10)
            make.centerY.equalTo(searchBar).offset(1)
        }
        searchBar.addTarget(self, action: #selector(searchBarTapped), for: .touchDown)
        
        FeedButton.translatesAutoresizingMaskIntoConstraints = false
        FeedButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        FeedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
    }
    
    //MARK: - Search Bar Tapped
    @objc func searchBarTapped(textField: UITextField) {
        impact.impactOccurred()
        // Slide popup down
        var animationDelay: TimeInterval = 0
        let closePopupAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1, animations: {
                self.bottomConstraint.constant = 440
                self.view.layoutIfNeeded()
        })
        if(isDisplayingLocation) {
            closePopupAnimator.addCompletion({_ in
                popupLocationView.isHidden = true
                popupDiveinView.isHidden = false
            })
            closePopupAnimator.startAnimation()
            isDisplayingLocation = false
            animationDelay = 0.5
        } else {
            popupLocationView.isHidden = true
            popupDiveinView.isHidden = false
        }
        // slide divein popup up
        let openPopupAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            self.bottomConstraint.constant = 210
            self.searchButton.isHidden = false
            self.searchBarTextField.isHidden = false
            self.searchBar.isHidden = true
            self.view.layoutIfNeeded()
        })
        openPopupAnimator.addCompletion({_ in
            popupLocationView.isHidden = true
            popupDiveinView.isHidden = false
        })
        openPopupAnimator.startAnimation(afterDelay: animationDelay)
        isDisplayingDivein = true
        self.mapView?.selectedAnnotations.forEach({ self.mapView?.deselectAnnotation($0, animated: true) })
        
        
        /// Temporary - REMOVE
        
    }
    
    @objc func feedButtonTapped(_ sender: UIButton) {
        impact.impactOccurred()
        feedDispatchGroup.enter()
        GetFeed()
        feedDispatchGroup.notify(queue: .main) {
            let nextVC = FeedPage_Controller()
            nextVC.modalPresentationStyle = .fullScreen
            self.present(nextVC, animated: true, completion: {
                 print("Changes to feed_page successfully!")
             })
           }
    }
    
    //MARK: - Search Bar Actions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchAction();
        return true
    }
    
    @objc func searchButtonTapped(_ sender: UIButton) {
           searchAction();
    }
       
    func searchAction(){
        impact.impactOccurred()
        let searchTerm: String = searchBarTextField.text ?? ""
        if( searchTerm == ""){ return}
        yelpDispatchGroup.enter()
        locationManager.startUpdatingLocation()
        var Latt = 34.073121 //default location if current not found
        var Long = -118.454704
        if let userLocation = self.locationManager.location?.coordinate {
            Latt = userLocation.latitude
            Long = userLocation.longitude
        }
        locationManager.stopUpdatingLocation()
        YelpSearchFunc(latt: Latt, longi:  Long, sterm: searchTerm, limitN: 10)
        yelpDispatchGroup.notify(queue: .main) {
            print("Moving to list_view")
            let nextVC = ListView_Controller()
            nextVC.searchTerm = searchTerm
            self.present(nextVC, animated: true, completion: {
                print("Changes to list_view successfully!")
            })
        }
    }

    func YelpSearchFunc(latt:Double, longi: Double, sterm: String, limitN: Int) {

        service.request(.YelpTest(lat: latt, long: longi, term: sterm, limit:limitN)) {(result) in
            switch result {
            case .success(let response):
                let save = try? JSONDecoder().decode(Return.self, from: response.data)
                if (save != nil){
                
                TempPlaces = save!.businesses // if safe null then search again.....
                
                yelpSearchDispatchGroup.enter()
                ListToPlace(list:TempPlaces)
                yelpSearchDispatchGroup.notify(queue: .main) {
                    yelpDispatchGroup.leave()
                }
                return
                }
            case .failure(let error):
                print("Error: \(error)")
                return
            }
        }
    }
    
    // Close keyboard if other part of screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - Map Setup
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    //addPin function adds new pins to the map
    private func addPin(imageName:String, location:CLLocationCoordinate2D, title:String, subtitle:String)
    {
        let pointAnnotation = CustomPointAnnotation()
        pointAnnotation.pinCustomImageName = imageName
        pointAnnotation.coordinate = location
        pointAnnotation.title = title
        pointAnnotation.subtitle = subtitle
        pointAnnotation.indexNum = pointAnnotationList.count - 1
        pointAnnotationList.append(pointAnnotation)
        pinAnnotationView = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: "pin")
        mapView!.addAnnotation(pinAnnotationView.annotation!)

    }
    
    //MARK: - Friend Photos Setup
    private func setupFriendPhotos() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(collectionView!)
        print("working")
        collectionView?.leftAnchor.constraint(equalTo: contentImageView.rightAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 5).isActive = true
        collectionView?.backgroundColor = .white
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        
        collectionView?.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: "Example Cell")
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return place?.fbvisitors.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Example Cell", for: indexPath) as! PhotoCollectionCell
        cell.autolayoutCell()
        cell.photo = place?.fbvisitors[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300 , height: 200)
    }
    
}

//MARK: - Map Screen Actions
extension MapScreen: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(tileOverlay: tileOverlay)
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.selectedAnnotation = view.annotation as? CustomPointAnnotation
        var index: Int = -1
        for (i, place) in FriendPlaces.enumerated(){
            if(place.name == view.annotation?.title ){
              index = i
              break
            }
        }
        popupViewTapped(recognizer: tapRecognizer, index: index)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if(isDisplayingLocation && !isDisplayingDivein) {
            popupViewClosed(recognizer: tapRecognizer)
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
    
    
}

class PhotoCollectionCell: UICollectionViewCell {

       var imageView: CustomImageView = CustomImageView()
       
       func autolayoutCell() {
           self.backgroundColor = .white
       }
       
       var photo: String! {
           didSet{
               imageView.loadImage(urlString: photo)
             }
       }
   }
