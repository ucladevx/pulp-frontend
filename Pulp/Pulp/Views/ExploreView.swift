//
//  ExploreController.swift
//  Pulp
//
//  Created by Aryan Arora on 5/20/19.
//  Copyright © 2019 Aryan Arora. All rights reserved.
//
import UIKit
import CoreLocation


class Explore_Controller: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
  
    let scrollView = UIScrollView()
    let contentView = UIView()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    var collectionView: UICollectionView?
    let cellId = "Example Cell"
    let cellSpacing:CGFloat = 10
    var selectedLocation: Int = 20
    var isDatabasePlace: Bool = true
    var calledbyMap: Bool = true
    let locationManager = CLLocationManager()
    var place: Place = YelpSearch[0]
    var mapSnapshotView: UIView?
    var ratingViewStart: CGPoint?
    var locationImageStart: CGPoint?

    let bgImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Home-invert"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        btn.titleEdgeInsets.left = 10
        btn.titleEdgeInsets.right = 10
        btn.setTitle("< Back", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = .zero
        btn.layer.shadowRadius = 5
        return btn
    }()
    let locationImageView: CustomImageView = {
        let imageView = CustomImageView()
        var count = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let locationImageShadowView: UIView = {// Works around shadow truncated by clipsToBounds
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 5
        return view
    }()
    let locationTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .white
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir Book Italic", size: 18)
        textView.font = UIFont.italicSystemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let ExploreTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Explore"
        textView.backgroundColor = UIColor(red: 20/255, green: 121/255, blue: 201/255, alpha: 1)
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir Book", size: 30)
        textView.font = UIFont.boldSystemFont(ofSize: 35)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let PlaceNameTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.textColor = UIColor(red: 135/255, green: 132/255, blue: 132/255, alpha: 1)
        textView.backgroundColor = .clear
        textView.font = UIFont(name: "Avenir Book", size: 30)
        textView.font = UIFont.boldSystemFont(ofSize: 35)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let placeTypeIcon: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Icon"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let DistanceTextView: UITextView = {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.font = UIFont(name: "Avenir Book", size: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()

    var PlaceDescriptionButtonList = [UIButton]()
    
    let PlaceDescriptionRow1: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    let PlaceDescriptionRow2: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    let ratingPulpsIconView: RatingPulpsIconView = {
//        let ratingView = RatingPulpsIconView(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        let ratingView = RatingPulpsIconView(frame: CGRect(x: 0, y: 0, width: 150, height: 80))
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        ratingView.fullImage = UIImage(named: "Rating_Full")
        ratingView.emptyImage = UIImage(named: "Rating_Empty")
        ratingView.backgroundColor =  UIColor.clear
        return ratingView
    }()
    let ratingView: UIView = { // Wrapper for rating icons to work
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let ratingTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textColor = UIColor(red: 126/255, green: 126/255, blue: 126/255, alpha: 1)
        textView.font = UIFont(name: "Avenir Book Italic", size: 15)
        textView.font = UIFont.italicSystemFont(ofSize: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
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
    
    let AddReviewTextView:UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.textColor = .black
        textView.text = "Spilling the juice..."
        textView.font = UIFont(name: "Avenir Book", size: 20)
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let AddReviewButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 249/255, green: 160/255, blue: 119/255, alpha: 1)
        button.setTitle("Check In!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var popUpWindow: PopUpWindow = {
        let view = PopUpWindow()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        contentView.backgroundColor = .white
        setupLayout()
        setupViews()
        setupReviews()

    }
    
    // Set the final constraint positions for animated elements
    func setFinalAnimationConstraints() {
        self.ratingView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 35).isActive = true
        self.ratingView.topAnchor.constraint(equalTo: self.PlaceDescriptionRow2.bottomAnchor, constant: 15).isActive = true
        
        self.locationImageView.layer.cornerRadius = 0
        self.locationImageView.translatesAutoresizingMaskIntoConstraints = false
        self.locationImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.locationImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.locationImageView.bottomAnchor.constraint(equalTo: self.PlaceNameTextView.topAnchor, constant: -15).isActive = true
        self.locationImageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
    }
    
    func animateFromMap() {
        contentView.bringSubviewToFront(ratingView)
        contentView.bringSubviewToFront(locationImageView)
        ratingView.center = ratingViewStart ?? CGPoint(x: 195.0, y: 565.0)
        locationImageView.frame = CGRect(x: locationImageStart?.x ?? 25, y: locationImageStart?.y ?? 512, width: 150.0, height: 140.0)
        locationImageView.layer.cornerRadius = 28
        view.layoutIfNeeded()
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
            self.mapSnapshotView?.alpha = 0
            self.setFinalAnimationConstraints()
            self.view.layoutIfNeeded()
        }, completion: { finished in
            print("Animation Done")
            self.mapSnapshotView?.removeFromSuperview()
            self.view.layoutIfNeeded()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(calledbyMap) {
            animateFromMap()
        }
        else {
            self.setFinalAnimationConstraints()
        }
    }
    
    func setupScrollView(){

        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.bounces = false 
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    private func setupLayout() {
        
        
        contentView.addSubview(bgImageView)
        contentView.sendSubviewToBack(bgImageView)
        contentView.addSubview(backButton)
        contentView.addSubview(locationTextView)
        contentView.addSubview(ExploreTextView)
        contentView.addSubview(PlaceNameTextView)
        contentView.addSubview(placeTypeIcon)
        contentView.addSubview(PlaceDescriptionRow1)
        contentView.addSubview(PlaceDescriptionRow2)
        contentView.addSubview(DistanceTextView)
        ratingView.addSubview(ratingPulpsIconView)
        contentView.addSubview(ratingTextView)
        contentView.addSubview(AddReviewTextView)
        contentView.addSubview(AddReviewButton)
        contentView.addSubview(visualEffectView)
        contentView.addSubview(FriendImagesView)
        
        contentView.addSubview(locationImageShadowView)
        contentView.addSubview(locationImageView)
        contentView.addSubview(ratingView)
        
        backButton.titleLabel?.font = UIFont(name: "Avenir-Light", size:view.frame.height/50)
        if(calledbyMap){
            place = FriendPlaces[selectedLocation]
            backButton.setTitle("< Back to Map", for: .normal)
            contentView.addSubview(mapSnapshotView!)
            mapSnapshotView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            mapSnapshotView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            mapSnapshotView?.alpha = 1
        }
        else{
            place = YelpSearch[selectedLocation]
            backButton.setTitle("< Back to Results", for: .normal)
        }
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        locationImageView.loadImage(urlString: place.image ?? defaultURL)
        let CityState = place.city + ", " + place.state
        locationTextView.text = CityState
        PlaceNameTextView.text = place.name
        place_id = place.id
        print(place.reviews)
        let tags = place.tags
        for t in tags {
            let btn = UIButton(type: .custom)
            btn.setTitle(t, for: UIControl.State.normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: "Avenir-Light", size:view.frame.height/50)
            btn.backgroundColor = UIColor(red: 249/255, green: 160/255, blue: 119/255, alpha: 1)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.layer.cornerRadius = 15
            btn.contentEdgeInsets = UIEdgeInsets.init(top:5, left:10, bottom:5, right:10)
//            btn.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
//            btn.titleLabel?.numberOfLines = 1
            PlaceDescriptionButtonList.append(btn)
        }
        
        let placeLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
        let dist = (locationManager.location?.distance(from: placeLocation) ?? 0) / 1609.34
        let distance = String(format: "%.1f", dist)
        DistanceTextView.text = distance +  " miles away"

        var avRating: Double = place.rating
        avRating = floor(avRating * 2 + 0.5) / 2 //rounding to nearest .5
        ratingPulpsIconView.rating = avRating
        if (avRating.remainder(dividingBy: 1.0) == 0) { // truncate '.0' if present
            ratingTextView.text = String(Int(avRating)) + " pulps"
        }
        else {
            ratingTextView.text = String(avRating) + " pulps"
        }

        locationImageShadowView.leftAnchor.constraint(equalTo: locationImageView.leftAnchor).isActive = true
        locationImageShadowView.rightAnchor.constraint(equalTo: locationImageView.rightAnchor).isActive = true
        locationImageShadowView.topAnchor.constraint(equalTo: locationImageView.topAnchor).isActive = true
        locationImageShadowView.bottomAnchor.constraint(equalTo: locationImageView.bottomAnchor).isActive = true
        
        backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true

        backButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 130).isActive = true
        backButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)
        
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.transform = CGAffineTransform(rotationAngle: (.pi ))
        bgImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        bgImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -30).isActive = true
        bgImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        bgImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        locationTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        locationTextView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 5).isActive = true
        locationTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        locationTextView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        ExploreTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        ExploreTextView.topAnchor.constraint(equalTo: locationTextView.bottomAnchor, constant: -10).isActive = true
        ExploreTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        ExploreTextView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        PlaceNameTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        PlaceNameTextView.topAnchor.constraint(equalTo: ExploreTextView.bottomAnchor, constant: 255).isActive = true
        PlaceNameTextView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        placeTypeIcon.leftAnchor.constraint(equalTo: PlaceNameTextView.rightAnchor, constant: 20).isActive = true
        placeTypeIcon.topAnchor.constraint(equalTo: ExploreTextView.bottomAnchor, constant: 267).isActive = true
        placeTypeIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        placeTypeIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        DistanceTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        DistanceTextView.topAnchor.constraint(equalTo: PlaceNameTextView.bottomAnchor, constant: -15).isActive = true
        DistanceTextView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        DistanceTextView.heightAnchor.constraint(equalToConstant: 40).isActive = false
        
        PlaceDescriptionRow1.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        PlaceDescriptionRow1.topAnchor.constraint(equalTo: DistanceTextView.bottomAnchor, constant: 5).isActive = true
        
        PlaceDescriptionRow2.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        PlaceDescriptionRow2.topAnchor.constraint(equalTo: PlaceDescriptionRow1.bottomAnchor, constant: 5).isActive = true
       
        
        var accumulatedButtonWidth = CGFloat(0.0)
        
        for PlaceDescriptionButton in PlaceDescriptionButtonList {
            let width = CGFloat(PlaceDescriptionButton.currentTitle!.count)*6.3 + 25
            if(accumulatedButtonWidth + width > screenWidth - 60) {
                PlaceDescriptionRow2.addArrangedSubview(PlaceDescriptionButton)
                print(Int(screenWidth) - 60)
            }
            else {
                PlaceDescriptionRow1.addArrangedSubview(PlaceDescriptionButton)
            }
            accumulatedButtonWidth += width
        }
        
//        ratingView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: (screenWidth - ratingPulpsIconView.frame.size.width)/2).isActive = true
        
        
        ratingTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        ratingTextView.topAnchor.constraint(equalTo: PlaceDescriptionRow2.bottomAnchor, constant: 40).isActive = true
        
        AddReviewButton.topAnchor.constraint(equalTo: ratingTextView.bottomAnchor, constant: 10).isActive = true
        AddReviewButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        AddReviewButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        AddReviewButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        AddReviewButton.addTarget(self, action: #selector(self.checkInTapped(_:)), for: .touchUpInside)
        

        func addImagetoFriendImagesView(url:String, view:CustomImageView){
            view.loadImage(urlString: url)
            view.widthAnchor.constraint(equalToConstant:40).isActive = true
            view.heightAnchor.constraint(equalToConstant: 40).isActive = true
            view.clipsToBounds = true
            view.layoutIfNeeded()
            view.layer.cornerRadius = view.frame.size.width / 2
        }

        let imageStringArray: [String] = place.fbvisitors;
    
        
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


        FriendImagesView.topAnchor.constraint(equalTo: PlaceDescriptionRow2.bottomAnchor, constant: 15).isActive = true
        FriendImagesView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        
        AddReviewTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        AddReviewTextView.topAnchor.constraint(equalTo: AddReviewButton.bottomAnchor, constant: 10).isActive = true 
        AddReviewTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        AddReviewTextView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(visualEffectView)
        visualEffectView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        visualEffectView.alpha = 0
    }
    
    
    private func setupReviews() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView!)
        
        
        
        collectionView?.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        collectionView?.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
//        collectionView?.leadingAnchor.constraint(equalTo: AddReviewTextView.leadingAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: AddReviewTextView.bottomAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView?.backgroundColor = .white
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: cellSpacing, bottom: 0, right: cellSpacing)
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.minimumLineSpacing = 10
        
        collectionView?.register(ReviewCollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (place.reviews.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewCollectionCell
        cell.autolayoutCell()
        cell.review = place.reviews[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300 , height: 130)
    }

    
    
    func setupViews(){
        contentView.addSubview(label1)
        label1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label1.topAnchor.constraint(equalTo: AddReviewTextView.bottomAnchor, constant: 300).isActive = true
        label1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        
        contentView.addSubview(label2)
        label2.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 25).isActive = true
        label2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 3/4).isActive = true
        label2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    let label1: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var fbfriend: FBFriend! {
        didSet{
            Profile1ImageView.image = UIImage(named: fbfriend.imageName!)
        }
    }
    
    @objc func registerTapped(_ sender: UIButton) {
        impact.impactOccurred()
        self.dismiss(animated: true, completion: {
            print("Changes to previous page successfully!")
        })
    }
    
    @objc func checkInTapped(_ sender: UIButton) {
        impact.impactOccurred()
        if(!isDatabasePlace){
        CreatePlace(place: place)
        }
        
        view.addSubview(popUpWindow)
        popUpWindow.reviewText.text = ""
        popUpWindow.reviewText.placeholder = "Share your experience?"
        
        popUpWindow.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        popUpWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popUpWindow.heightAnchor.constraint(equalToConstant: 500).isActive = true
        popUpWindow.widthAnchor.constraint(equalToConstant: view.frame.width - 64).isActive = true
        
        popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        popUpWindow.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.popUpWindow.alpha = 1
            self.popUpWindow.transform = CGAffineTransform.identity
        }
    }

}

extension Explore_Controller: PopUpDelegate {
    
    func handleDismissal() {
        service.request(.AddReview(userID: USERID, placeID: place_id, rating: popUpWindow.floatRatingView.rating, body: popUpWindow.reviewText.text)) {(result) in
            switch result {
            case .success(let response):
                print("Added Review!")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        print(popUpWindow.floatRatingView.rating)
        print(popUpWindow.reviewText.text)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove pop up window..")
        }
    }
    
    func goBacktoExplore() {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectView.alpha = 0
            self.popUpWindow.alpha = 0
            self.popUpWindow.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.popUpWindow.removeFromSuperview()
            print("Did remove pop up window..")
        }
    }
    
}


class ReviewCollectionCell: UICollectionViewCell {
    var stackView: UIStackView = UIStackView()
    var imageView: CustomImageView = CustomImageView()
    var reviewText: UITextView = UITextView()
    
    func autolayoutCell() {
        self.backgroundColor = .white
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        stackView.addSubview(imageView)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        stackView.addSubview(reviewText)
        reviewText.text = "The Venice Canal Historic District are great to capture during the day or at sunset."
        reviewText.font = UIFont(name: "Avenir Book", size: 15)
        reviewText.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        reviewText.font = UIFont.italicSystemFont(ofSize: 15)
        reviewText.translatesAutoresizingMaskIntoConstraints = false
        reviewText.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        reviewText.widthAnchor.constraint(equalToConstant: 200).isActive = true
        reviewText.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 30).isActive = true
        reviewText.isEditable = false
        reviewText.isScrollEnabled = false
        reviewText.backgroundColor = .white
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
    }
    
    var review: Review! {
        didSet{
            if(review.userImage != nil && review.userImage != "" ){
                imageView.loadImage(urlString: review.userImage!)
                print("review image is: ")
            }
            else{
                imageView.image = #imageLiteral(resourceName: "Empty-Profile_Photo")
            }
            reviewText.text = review.body ?? ""
        }
    }
}

open class RatingPulpsIconView: UIView {
    
    // MARK: Properties

    /// Array of empty image views
    private var emptyImageViews: [UIImageView] = []

    /// Array of full image views
    private var fullImageViews: [UIImageView] = []

    /// Sets the empty image (e.g. a star outline)
    @IBInspectable open var emptyImage: UIImage? {
        didSet {
            // Update empty image views
            for imageView in emptyImageViews {
                imageView.image = emptyImage
            }
            refresh()
        }
    }

    /// Sets the full image that is overlayed on top of the empty image.
    /// Should be same size and shape as the empty image.
    @IBInspectable open var fullImage: UIImage? {
        didSet {
            // Update full image views
            for imageView in fullImageViews {
                imageView.image = fullImage
            }
            refresh()
        }
    }

    /// Sets the empty and full image view content mode.
    open var imageContentMode: UIView.ContentMode = .scaleAspectFit

    /// Minimum rating.
    @IBInspectable open var minRating: Int = 0 {
        didSet {
            // Update current rating if needed
            if rating < Double(minRating) {
                rating = Double(minRating)
                refresh()
            }
        }
    }

    /// Max rating value.
    @IBInspectable open var maxRating: Int = 5 {
        didSet {
            if maxRating != oldValue {
                removeImageViews()
                initImageViews()
                
                // Relayout and refresh
                setNeedsLayout()
                refresh()
            }
        }
    }

    /// Minimum image size.
    @IBInspectable open var minImageSize = CGSize(width: 5.0, height: 5.0)

    /// Set the current rating.
    @IBInspectable open var rating: Double = 0 {
        didSet {
            if rating != oldValue {
                refresh()
            }
        }
    }

    /// Sets whether or not the rating view can be changed by panning.
    @IBInspectable open var editable = true

    // MARK: Type
    @objc public enum FloatRatingViewType: Int {
        /// Integer rating
        case wholeRatings
        /// Double rating in increments of 0.5
        case halfRatings
        /// Double rating
        case floatRatings

        /// Returns true if rating can contain decimal places
        func supportsFractions() -> Bool {
            return self == .halfRatings || self == .floatRatings
        }
    }

    /// Float rating view type
    @IBInspectable open var type: FloatRatingViewType = .wholeRatings
    
    // MARK: Initializations
    
    required override public init(frame: CGRect) {
        super.init(frame: frame)
        
        initImageViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initImageViews()
    }
    
    // MARK: Helper methods
    private func initImageViews() {
        guard emptyImageViews.isEmpty && fullImageViews.isEmpty else {
            return
        }

        // Add new image views
        for _ in 0..<maxRating {
            let emptyImageView = UIImageView()
            emptyImageView.contentMode = imageContentMode
            emptyImageView.image = emptyImage
            emptyImageViews.append(emptyImageView)
            addSubview(emptyImageView)

            let fullImageView = UIImageView()
            fullImageView.contentMode = imageContentMode
            fullImageView.image = fullImage
            fullImageViews.append(fullImageView)
            addSubview(fullImageView)
        }
    }

    private func removeImageViews() {
        // Remove old image views
        for i in 0..<emptyImageViews.count {
            var imageView = emptyImageViews[i]
            imageView.removeFromSuperview()
            imageView = fullImageViews[i]
            imageView.removeFromSuperview()
        }
        emptyImageViews.removeAll(keepingCapacity: false)
        fullImageViews.removeAll(keepingCapacity: false)
    }

    // Refresh hides or shows full images
    private func refresh() {
        for i in 0..<fullImageViews.count {
            let imageView = fullImageViews[i]

            if rating >= Double(i+1) {
                imageView.layer.mask = nil
                imageView.isHidden = false
            } else if rating > Double(i) && rating < Double(i+1) {
                // Set mask layer for full image
                let maskLayer = CALayer()
                maskLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(rating-Double(i))*imageView.frame.size.width, height: imageView.frame.size.height)
                maskLayer.backgroundColor = UIColor.black.cgColor
                imageView.layer.mask = maskLayer
                imageView.isHidden = false
            } else {
                imageView.layer.mask = nil;
                imageView.isHidden = true
            }
        }
    }
    
    // Calculates the ideal ImageView size in a given CGSize
    private func sizeForImage(_ image: UIImage, inSize size: CGSize) -> CGSize {
        let imageRatio = image.size.width / image.size.height
        let viewRatio = size.width / size.height
        
        if imageRatio < viewRatio {
            let scale = size.height / image.size.height
            let width = scale * image.size.width
            
            return CGSize(width: width, height: size.height)
        } else {
            let scale = size.width / image.size.width
            let height = scale * image.size.height
            
            return CGSize(width: size.width, height: height)
        }
    }

    // MARK: UIView
    
    // Override to calculate ImageView frames
    override open func layoutSubviews() {
        super.layoutSubviews()

        guard let emptyImage = emptyImage else {
            return
        }

        let desiredImageWidth = frame.size.width / CGFloat(emptyImageViews.count)
        let maxImageWidth = max(minImageSize.width, desiredImageWidth)
        let maxImageHeight = max(minImageSize.height, frame.size.height)
        let imageViewSize = sizeForImage(emptyImage, inSize: CGSize(width: maxImageWidth, height: maxImageHeight))
        let imageXOffset = (frame.size.width - (imageViewSize.width * CGFloat(emptyImageViews.count))) /
                            CGFloat((emptyImageViews.count - 1))
        
        for i in 0..<maxRating {
            let imageFrame = CGRect(x: i == 0 ? 0 : CGFloat(i)*(imageXOffset+imageViewSize.width), y: 0, width: imageViewSize.width, height: imageViewSize.height)
            
            var imageView = emptyImageViews[i]
            imageView.frame = imageFrame
            
            imageView = fullImageViews[i]
            imageView.frame = imageFrame
        }
        
        refresh()
    }
}

// Used to generate a blank image for rating. May be removed later.
func imageWithSize(size: CGSize, filledWithColor color: UIColor = UIColor.clear, scale: CGFloat = 0.0, opaque: Bool = false) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
    color.set()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return image
}
