//
//  DiveIn.swift
//  Pulp
//
//  Created by Aryan Arora on 4/22/19.
//  Copyright © 2019 Aryan Arora. All rights reserved.
//



import UIKit
import CoreLocation

let impact = UIImpactFeedbackGenerator(style: .medium)
let dispatchGroup = DispatchGroup()
let yelpDispatchGroup = DispatchGroup()
let searchDispatchGroup = DispatchGroup()
let yelpSearchDispatchGroup = DispatchGroup()

class DiveIn: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate{
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Wave_DiveIn"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("< Back to Map", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        return btn
    }()
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
    
    let descriptionView: UILabel = {
        let textView = UILabel()
        textView.text = "Dive in."
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let subheadingView: UILabel = {
        let textView = UILabel()
        textView.text = "What are you looking for?"
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let searchBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchBarIcon: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "SearchIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let searchBar: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Parks, museums, bars, etc."
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.textColor = UIColor.gray
        txtField.returnKeyType = UIReturnKeyType.go;
        txtField.enablesReturnKeyAutomatically = true;
        
        return txtField
        
    }()
    
    let zipView: UIView = {
        let view = UIView();
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let zipBar: UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "Enter zip code"
        txtField.translatesAutoresizingMaskIntoConstraints = false
        return txtField
    }()
    
    let zipBarIcon: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "ZipCode"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let currentLocationView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let currentLocationButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Using current location", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let currentLocationIcon: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "LocationIcon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let searchButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Search", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        return btn
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let exploreButton: UIButton = {
        let btn = UIButton()
        btn.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        btn.setImage(#imageLiteral(resourceName: "Footer_ExpClick"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(openExploreView), for: .touchUpInside)
        return btn
    }()
    
    
    @objc func openExploreView(){
        let mapVC = Explore_Controller()
        present(mapVC, animated: true, completion: nil)
    }
    
    
    let profileButton: UIButton = {
        let btn = UIButton()
        btn.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        btn.setImage(#imageLiteral(resourceName: "Footer_Prof"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(openProfileView), for: .touchUpInside)
        return btn
    }()
    
    @objc func openProfileView(){
       
    }
    
    let faveButton: UIButton = {
        let btn = UIButton()
        btn.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        btn.setImage(#imageLiteral(resourceName: "Footer_Fave"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let bottomControlView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func registerTapped(_ sender: UIButton) {
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
    var locationManager: CLLocationManager = {
        var locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        
        view.addSubview(backgroundImageView)
        topView.addSubview(descriptionView)
        topView.addSubview(subheadingView)
        topView.addSubview(searchBarView)
        searchBarView.addSubview(searchBar)
        topView.addSubview(zipView)
        view.addSubview(topView)
        view.addSubview(bottomControlView)
        setupBottomControls()
        setupLayout()
        setupButtonDestination()
        searchButton.addTarget(self, action: #selector(self.searchTapped(_:)), for: .touchUpInside)
        self.searchBar.delegate = self
        self.locationManager.delegate = self
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchAction();
        return true
    }
    
    @objc func searchTapped(_ sender: UIButton) {
        searchAction();
    }
    
    func searchAction(){
        impact.impactOccurred()
        let searchTerm: String = searchBar.text ?? ""
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

    
    fileprivate func setupBottomControls() {
//        let bottomControlsStackView = UIStackView(arrangedSubviews: [exploreButton, profileButton, faveButton])
//        bottomControlsStackView.backgroundColor = .white
//        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
//        bottomControlsStackView.distribution = .fillEqually
//        bottomControlsStackView.spacing = 20
//
//
//
//        bottomControlView.addSubview(bottomControlsStackView)
//        NSLayoutConstraint.activate([
//            bottomControlsStackView.centerXAnchor.constraint(equalTo:bottomControlView.centerXAnchor),
//            bottomControlsStackView.centerYAnchor.constraint(equalTo:bottomControlView.centerYAnchor),
//            bottomControlsStackView.heightAnchor.constraint(equalToConstant: view.frame.height/14)
//            ])
    }
    
    private func setupSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        let topConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 100)
        let leftConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 44)
        
        
        searchController.searchBar.addConstraint(heightConstraint)
        self.view.addSubview(searchController.searchBar)
        self.view.addConstraints([topConstraint, leftConstraint, rightConstraint])
    }
    
    private func setupLayout(){
        bottomControlView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomControlView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomControlView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomControlView.heightAnchor.constraint(equalToConstant: view.frame.height/12).isActive = true

        
        backgroundImageView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalToConstant:view.frame.height/1.9).isActive = true
        
        topView.topAnchor.constraint(equalTo:view.topAnchor, constant:view.frame.height/10).isActive = true
        topView.leftAnchor.constraint(equalTo:view.leftAnchor, constant:view.frame.width/8).isActive = true
        topView.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-view.frame.width/8).isActive = true
        topView.heightAnchor.constraint(equalToConstant:view.frame.height/2.5).isActive = true
        
        descriptionView.topAnchor.constraint(equalTo:topView.topAnchor, constant:40).isActive = true
        descriptionView.leftAnchor.constraint(equalTo:topView.leftAnchor).isActive = true
        descriptionView.rightAnchor.constraint(equalTo:topView.rightAnchor).isActive = true
        descriptionView.font = UIFont(name: "Avenir-Black", size: view.frame.height/23)
        
        subheadingView.topAnchor.constraint(equalTo:descriptionView.bottomAnchor).isActive = true
        subheadingView.leftAnchor.constraint(equalTo:topView.leftAnchor).isActive = true
        subheadingView.rightAnchor.constraint(equalTo:topView.rightAnchor).isActive = true
        subheadingView.font = UIFont(name: "Avenir-MediumOblique", size: view.frame.height/38)

        searchBarView.topAnchor.constraint(equalTo:subheadingView.bottomAnchor, constant:view.frame.height/40).isActive = true
        searchBarView.leftAnchor.constraint(equalTo:topView.leftAnchor).isActive = true
        searchBarView.rightAnchor.constraint(equalTo:topView.rightAnchor).isActive = true
        searchBarView.heightAnchor.constraint(equalToConstant: view.frame.height/20).isActive = true
        searchBarView.layer.cornerRadius = view.frame.width/40
        
        searchBarView.addSubview(searchBar)
        searchBar.centerXAnchor.constraint(equalTo:searchBarView.centerXAnchor).isActive = true
        searchBar.centerYAnchor.constraint(equalTo:searchBarView.centerYAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo:searchBarView.leftAnchor, constant:view.frame.width/13).isActive = true
        searchBar.rightAnchor.constraint(equalTo:searchBarView.rightAnchor, constant:-5).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: view.frame.height/25).isActive = true
        searchBar.font = UIFont(name: "Avenir-Light", size:view.frame.height/50)
        
        searchBarView.addSubview(searchBarIcon)
        searchBarIcon.leftAnchor.constraint(equalTo:searchBarView.leftAnchor, constant:5).isActive = true
        searchBarIcon.centerYAnchor.constraint(equalTo:searchBarView.centerYAnchor).isActive = true

//        zipView.topAnchor.constraint(equalTo:searchBarView.bottomAnchor, constant:view.frame.height/40).isActive = true
//        zipView.leftAnchor.constraint(equalTo:topView.leftAnchor).isActive = true
//        zipView.rightAnchor.constraint(equalTo:topView.rightAnchor).isActive = true
//        zipView.heightAnchor.constraint(equalToConstant: view.frame.height/20).isActive = true
//        zipView.layer.cornerRadius = view.frame.width/40
//
//        zipView.addSubview(zipBar)
//        zipBar.centerXAnchor.constraint(equalTo:zipView.centerXAnchor).isActive = true
//        zipBar.centerYAnchor.constraint(equalTo:zipView.centerYAnchor).isActive = true
//        zipBar.leftAnchor.constraint(equalTo:zipView.leftAnchor, constant:view.frame.width/13).isActive = true
//        zipBar.rightAnchor.constraint(equalTo:zipView.rightAnchor, constant:-5).isActive = true
//        zipBar.heightAnchor.constraint(equalToConstant: view.frame.height/25).isActive = true
//        zipBar.font = UIFont(name: "Avenir-Light", size:view.frame.height/50)
//
//        zipView.addSubview(zipBarIcon)
//        zipBarIcon.leftAnchor.constraint(equalTo:zipView.leftAnchor, constant:5).isActive = true
//        zipBarIcon.centerYAnchor.constraint(equalTo:zipView.centerYAnchor).isActive = true
        
        topView.addSubview(searchButton)
        searchButton.layer.cornerRadius = 10
        searchButton.titleEdgeInsets.left = 10
        searchButton.titleEdgeInsets.right = 10
        searchButton.frame = CGRect(x: 0, y: view.frame.height/3.3, width: view.frame.width/5, height: 40)
        searchButton.titleLabel?.font = UIFont(name: "Avenir-Light", size:view.frame.height/50)
        searchButton.backgroundColor = .white
        
        topView.addSubview(currentLocationView)
        currentLocationView.topAnchor.constraint(equalTo:searchBarView.bottomAnchor, constant:15).isActive = true
        currentLocationView.leftAnchor.constraint(equalTo:topView.leftAnchor).isActive = true
        currentLocationView.rightAnchor.constraint(equalTo:topView.rightAnchor).isActive = true
        currentLocationView.heightAnchor.constraint(equalToConstant: view.frame.height/25).isActive = true

        currentLocationView.addSubview(currentLocationButton)
        currentLocationButton.centerYAnchor.constraint(equalTo:currentLocationView.centerYAnchor).isActive = true
        currentLocationButton.heightAnchor.constraint(equalToConstant:view.frame.height/30).isActive = true
        currentLocationButton.leftAnchor.constraint(equalTo:currentLocationView.leftAnchor, constant:view.frame.width/13).isActive = true
        currentLocationButton.titleLabel?.font = UIFont(name: "Avenir-Light", size:view.frame.height/45)

        //currentLocationButton.addTarget(self,  action: #selector(openExploreView2), for: .touchUpInside)
        
        currentLocationView.addSubview(currentLocationIcon)
        currentLocationIcon.leftAnchor.constraint(equalTo:currentLocationView.leftAnchor, constant:5).isActive = true
        currentLocationIcon.centerYAnchor.constraint(equalTo:currentLocationView.centerYAnchor).isActive = true

        let bottomContainerView = UIView()
        view.addSubview(bottomContainerView)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.topAnchor.constraint(equalTo: backgroundImageView.bottomAnchor).isActive = true
        bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomContainerView.heightAnchor.constraint(equalToConstant:view.frame.height/3).isActive = true
        
        
        // HIKE BUTTON
        bottomContainerView.addSubview(restaurantsImageView)
        restaurantsImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/3).isActive = true
        restaurantsImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: view.frame.height/12).isActive = true
        restaurantsImageView.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        
        bottomContainerView.addSubview(restaurantsLabel)
        restaurantsLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/3).isActive = true
        restaurantsLabel.topAnchor.constraint(equalTo:restaurantsImageView.bottomAnchor).isActive = true
        restaurantsLabel.font = UIFont(name: "Avenir-Medium", size: view.frame.height/50)
        
        bottomContainerView.addSubview(restaurantsButton)
        restaurantsButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/3).isActive = true
        restaurantsButton.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: view.frame.height/12).isActive = true
        restaurantsButton.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        restaurantsButton.widthAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        
        
        // MUSEUM BUTTON
        bottomContainerView.addSubview(museumImageView)
        museumImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/9).isActive = true
        museumImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: view.frame.height/12).isActive = true
        museumImageView.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true

        bottomContainerView.addSubview(museumLabel)
        museumLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/9).isActive = true
        museumLabel.topAnchor.constraint(equalTo:museumImageView.bottomAnchor).isActive = true
        museumLabel.font = UIFont(name: "Avenir-Medium", size: view.frame.height/50)
        
        bottomContainerView.addSubview(museumButton)
        museumButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/9).isActive = true
        museumButton.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: view.frame.height/12).isActive = true
        museumButton.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        museumButton.widthAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true

        
        // FESTIVAL BUTTON
        bottomContainerView.addSubview(festivalImageView)
        festivalImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/9).isActive = true
        festivalImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: view.frame.height/12).isActive = true
        festivalImageView.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true

        bottomContainerView.addSubview(festivalLabel)
        festivalLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/9).isActive = true
        festivalLabel.topAnchor.constraint(equalTo:festivalImageView.bottomAnchor).isActive = true
        festivalLabel.font = UIFont(name: "Avenir-Medium", size: view.frame.height/50)

        bottomContainerView.addSubview(festivalButton)
        festivalButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/9).isActive = true
        festivalButton.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: view.frame.height/12).isActive = true
        festivalButton.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        festivalButton.widthAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        
        
        // THRILL BUTTON
        bottomContainerView.addSubview(thrillImageView)
        thrillImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/3).isActive = true
        thrillImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: view.frame.height/12).isActive = true
        thrillImageView.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        
        bottomContainerView.addSubview(thrillLabel)
        thrillLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/3).isActive = true
        thrillLabel.topAnchor.constraint(equalTo:thrillImageView.bottomAnchor).isActive = true
        thrillLabel.font = UIFont(name: "Avenir-Medium", size: view.frame.height/50)

        bottomContainerView.addSubview(thrillButton)
        thrillButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/3).isActive = true
        thrillButton.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: view.frame.height/12).isActive = true
        thrillButton.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        thrillButton.widthAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true

        
        // PHOTO BUTTON
        bottomContainerView.addSubview(photoImageView)
        photoImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/3).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        photoImageView.topAnchor.constraint(equalTo:restaurantsLabel.bottomAnchor).isActive = true

        bottomContainerView.addSubview(photoLabel)
        photoLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/3).isActive = true
        photoLabel.topAnchor.constraint(equalTo:photoImageView.bottomAnchor).isActive = true
        photoLabel.font = UIFont(name: "Avenir-Medium", size: view.frame.height/50)
        
        bottomContainerView.addSubview(photoButton)
        photoButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/3).isActive = true
        photoButton.topAnchor.constraint(equalTo:restaurantsLabel.bottomAnchor).isActive = true
        photoButton.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        photoButton.widthAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true

        
        // ANIMAL BUTTON
        bottomContainerView.addSubview(animalImageView)
        animalImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/9).isActive = true
        animalImageView.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        animalImageView.topAnchor.constraint(equalTo:museumLabel.bottomAnchor).isActive = true

        bottomContainerView.addSubview(animalLabel)
        animalLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/9).isActive = true
        animalLabel.topAnchor.constraint(equalTo:animalImageView.bottomAnchor).isActive = true
        animalLabel.font = UIFont(name: "Avenir-Medium", size: view.frame.height/50)
        
        bottomContainerView.addSubview(animalButton)
        animalButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -view.frame.width/9).isActive = true
        animalButton.topAnchor.constraint(equalTo:museumLabel.bottomAnchor).isActive = true
        animalButton.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        animalButton.widthAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true

        
        // LANDSCAPE BUTTON
        bottomContainerView.addSubview(landscapeImageView)
        landscapeImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/9).isActive = true
        landscapeImageView.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        landscapeImageView.topAnchor.constraint(equalTo:festivalLabel.bottomAnchor).isActive = true

        bottomContainerView.addSubview(landscapeLabel)
        landscapeLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/9).isActive = true
        landscapeLabel.topAnchor.constraint(equalTo:landscapeImageView.bottomAnchor).isActive = true
        landscapeLabel.font = UIFont(name: "Avenir-Medium", size: view.frame.height/50)

        bottomContainerView.addSubview(landscapeButton)
        landscapeButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/9).isActive = true
        landscapeButton.topAnchor.constraint(equalTo:festivalLabel.bottomAnchor).isActive = true
        landscapeButton.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        landscapeButton.widthAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        
        
        // AQUATIC BUTTON
        bottomContainerView.addSubview(aquaticImageView)
        aquaticImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/3).isActive = true
        aquaticImageView.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        aquaticImageView.topAnchor.constraint(equalTo:thrillLabel.bottomAnchor).isActive = true
        
        bottomContainerView.addSubview(aquaticLabel)
        aquaticLabel.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/3).isActive = true
        aquaticLabel.topAnchor.constraint(equalTo:aquaticImageView.bottomAnchor).isActive = true
        aquaticLabel.font = UIFont(name: "Avenir-Medium", size: view.frame.height/50)
        
        bottomContainerView.addSubview(aquaticButton)
        aquaticButton.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: view.frame.width/3).isActive = true
        aquaticButton.topAnchor.constraint(equalTo:thrillLabel.bottomAnchor).isActive = true
        aquaticButton.heightAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true
        aquaticButton.widthAnchor.constraint(equalToConstant:view.frame.width/4.5).isActive = true

        
        view.addSubview(backButton)
        backButton.layer.cornerRadius = 10
        backButton.titleEdgeInsets.left = 10
        backButton.titleEdgeInsets.right = 10
        //        backButton.frame = CGRect(x: 0, y: view.frame.height/3.3, width: 100, height: 30)
        backButton.titleLabel?.font = UIFont(name: "Avenir-Light", size:view.frame.height/50)
        backButton.backgroundColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        backButton.addTarget(self, action: #selector(self.goBackMap(_:)), for: .touchUpInside)
    }
    
    func setupButtonDestination(){
        restaurantsButton.tag=0
        restaurantsButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)
        museumButton.tag=1
        museumButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)
        festivalButton.tag=2
        festivalButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)
        thrillButton.tag=3
        thrillButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)
        
        photoButton.tag=4
        photoButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)
        animalButton.tag=5
        animalButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)
        landscapeButton.tag=6
        landscapeButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)
        aquaticButton.tag=7
        aquaticButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)

    }
    @objc func goBackMap(_ sender: UIButton) {
        impact.impactOccurred()
        self.dismiss(animated: true, completion: {
            print("Changes back to MapScreen successfully!")
        })
    }
    
}


