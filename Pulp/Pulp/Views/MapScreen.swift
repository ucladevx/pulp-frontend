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
class MapScreen: UIViewController, CLLocationManagerDelegate,UICollectionViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    var isDisplaying = false
    var window: UIWindow?
    var mapView: MKMapView?
    var pointAnnotationList:[CustomPointAnnotation] = []
    var pinAnnotationView:MKPinAnnotationView!
    var selectedAnnotation:MKPointAnnotation!
    var currentLocation:CLLocation!
    var selectedPlace: Int = 0
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
    
    let searchBar: UITextField = {
        let searchbar = UITextField()
        searchbar.placeholder = "        Parks, museums, bars, etc.";
        searchbar.textAlignment = .left
        searchbar.font = UIFont(name: "Avenir-Light", size:15)
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        return searchbar
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

        mapDispatch.enter()
        GetMapPlaces()
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
                self.view.addSubview(self.mapView!)
                self.searchBarView.addSubview(self.searchBar)
                //            self.searchBarView.addSubview(self.filterButton)
                //            self.searchBarView.addSubview(self.cancelButton)
                //            self.searchBarView.addSubview(self.vertLineView)
                self.view.addSubview(self.searchBarView)
                        
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
                            popupView.addGestureRecognizer(self.tapRecognizer)
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
    
    private func popupLayout() {
        view.addSubview(popupView)
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        bottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 440)
        bottomConstraint.isActive = true
        popupView.heightAnchor.constraint(equalToConstant: 450).isActive = true
        
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(contentImageView)
        contentImageView.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 15).isActive = true
        contentImageView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -190).isActive = true
        contentImageView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 15).isActive = true
        contentImageView.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -295).isActive = true
        //contentImageView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
     
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(titleTextView)
        titleTextView.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 10).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -10).isActive = true
        titleTextView.topAnchor.constraint(equalTo: popupView.topAnchor, constant: 8).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleTextView.sizeToFit()
        titleTextView.isScrollEnabled = false
        
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        popupView.addSubview(locationTextView)
        locationTextView.leadingAnchor.constraint(equalTo: titleTextView.leadingAnchor).isActive = true
        locationTextView.trailingAnchor.constraint(equalTo: titleTextView.trailingAnchor).isActive = true
        locationTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: -20).isActive = true
        locationTextView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        popupView.addSubview(ratingView)
        ratingView.addSubview(ratingPulpsIconView)
        ratingView.topAnchor.constraint(equalTo: locationTextView.bottomAnchor, constant: -20).isActive = true
        ratingView.leftAnchor.constraint(equalTo: contentImageView.rightAnchor, constant: 10).isActive = true
    
        popupView.addSubview(checkThisOutButton)
        checkThisOutButton.topAnchor.constraint(equalTo: popupView.topAnchor).isActive = true
        checkThisOutButton.rightAnchor.constraint(equalTo: popupView.rightAnchor).isActive = true
        checkThisOutButton.leftAnchor.constraint(equalTo: popupView.leftAnchor).isActive = true
        checkThisOutButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor).isActive = true
        
        checkThisOutButton.addTarget(self, action: #selector(self.checkthisoutTapped(_:)), for: .touchUpInside)
        
        popupView.addSubview(FriendImagesView)
        
        FriendImagesView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 35).isActive = true
        FriendImagesView.rightAnchor.constraint(equalTo: popupView.rightAnchor, constant: -60).isActive = true
        
    }
    
    @objc func checkthisoutTapped(_ sender: UIButton) {
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
    private var currentState: State = .closed
    
    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer()
        return recognizer
    }()
    
    @objc private func popupViewTapped(recognizer: UITapGestureRecognizer, index: Int) {
        impact.impactOccurred()
        isDisplaying = true // does this do anything
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
        
        let transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            self.bottomConstraint.constant = 280
            self.view.layoutIfNeeded()
        })
        transitionAnimator.addCompletion { position in
            
                self.bottomConstraint.constant = 280
        }
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
        
//        filterButton.snp.makeConstraints { (make) -> Void in
//            make.left.equalTo(searchBarView).offset(15)
//            //make.right.equalTo(searchBarView)
//            make.top.equalTo(searchBarView)
//            make.bottom.equalTo(searchBarView)
//        }
        
//        cancelButton.snp.makeConstraints { (make) -> Void in
//            //make.left.equalTo(searchBarView)
//            make.right.equalTo(searchBarView).offset(-15)
//            make.top.equalTo(searchBarView)
//            make.bottom.equalTo(searchBarView)
//        }
        
//        vertLineView.snp.makeConstraints { (make) -> Void in
//            make.left.equalTo(searchBarView).offset(38)
//            //make.right.equalTo(searchBarView).offset(-15)
//            make.top.equalTo(searchBarView).offset(8)
//            make.bottom.equalTo(searchBarView).offset(-8)
//        }
        searchBar.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        
    }
    
    @objc func myTargetFunction(textField: UITextField) {
        impact.impactOccurred()
        let nextVC = DiveIn()
        self.present(nextVC, animated: true, completion: {
            print("Changes to divein successfully!")
        })
    }
    
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
