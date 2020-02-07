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

    
    let bgImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Wave_Explore"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("< Back to Results", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        return btn
    }()
    let locationImageView: CustomImageView = {
        let imageView = CustomImageView()
        var count = 5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let locationTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 20/255, green: 121/255, blue: 201/255, alpha: 1)
        
        textView.textColor = UIColor(red: 183/255, green: 217/255, blue: 249/255, alpha: 1)
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir Book Italic", size: 15)
        textView.font = UIFont.italicSystemFont(ofSize: 15)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let ExploreTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Explore"
        textView.backgroundColor = UIColor(red: 20/255, green: 121/255, blue: 201/255, alpha: 1)
        textView.textColor = .white
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
        textView.textColor = .black
        textView.backgroundColor = .white
        textView.font = UIFont(name: "Avenir Book", size: 30)
        textView.font = UIFont.boldSystemFont(ofSize: 30)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let PlaceDescriptionTextView: UITextView = {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.backgroundColor = .white
        textView.font = UIFont(name: "Avenir Book", size: 15)
        textView.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let DistanceTextView: UITextView = {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.backgroundColor = .white
        textView.textColor = .black
        textView.font = UIFont(name: "Avenir Book", size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let RatingPulpsTextView:UITextView = {
        let textView = UITextView()
        
        textView.isEditable = false
        textView.backgroundColor = .white
        textView.font = UIFont(name: "Avenir Book", size: 15)
        textView.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let Profile1ImageView: UIImageView = {
        let imageView = UIImageView()
        var image = FBFriendsData[0].imageName
        imageView.image = UIImage(named: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let Profile2ImageView: UIImageView = {
        let imageView = UIImageView()
        var image = FBFriendsData[1].imageName
        imageView.image = UIImage(named: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let Profile3ImageView: UIImageView = {
        let imageView = UIImageView()
        var image = FBFriendsData[2].imageName
        imageView.image = UIImage(named: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let Profile4ImageView: UIImageView = {
        let imageView = UIImageView()
        var image = FBFriendsData[3].imageName
        imageView.image = UIImage(named: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let AddReviewTextView:UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.backgroundColor = .white
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
        button.backgroundColor = UIColor(red: 54/255, green: 120/255, blue: 195/255, alpha: 1)
        button.setTitle("Check In!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.layer.cornerRadius = 10
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
        
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        view.addSubview(navigationBar)
        navigationBar.tintColor = .black
        navigationBar.barStyle = UIBarStyle.black
        setupScrollView()
        contentView.backgroundColor = .white
        setupLayout()
        setupViews()
        setupReviews()
        
 
    }
    
    func setupScrollView(){

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    private func setupLayout() {
        
        contentView.addSubview(bgImageView)
        self.contentView.sendSubviewToBack(bgImageView)
        contentView.addSubview(locationImageView)
        contentView.addSubview(locationTextView)
        contentView.addSubview(ExploreTextView)
        contentView.addSubview(PlaceNameTextView)
        contentView.addSubview(PlaceDescriptionTextView)
        contentView.addSubview(DistanceTextView)
        contentView.addSubview(RatingPulpsTextView)
        contentView.addSubview(Profile1ImageView)
        contentView.addSubview(Profile2ImageView)
        contentView.addSubview(Profile3ImageView)
        contentView.addSubview(Profile4ImageView)
        contentView.addSubview(AddReviewTextView)
        contentView.addSubview(backButton)
        contentView.addSubview(AddReviewButton)
        contentView.addSubview(visualEffectView)
        
        if(calledbyMap){
            place = FriendPlaces[selectedLocation]
        }
        else{
            place = YelpSearch[selectedLocation]
        }
        locationImageView.loadImage(urlString: place.image ?? defaultURL)
        let CityState = place.city + ", " + place.state
        locationTextView.text = CityState
        PlaceNameTextView.text = place.name
        place_id = place.id
        print(place.reviews)
        var tag = ""
        let tags = place.tags
        for (i, t) in tags.enumerated(){
            tag += t
            if (i != tags.count - 1){
                tag += ", "
            }
        
        }
        PlaceDescriptionTextView.text = tag
        let placeLocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
        let dist = (locationManager.location?.distance(from: placeLocation) ?? 0) / 1609.34
        let distance = String(format: "%.1f", dist)
        DistanceTextView.text = distance +  " miles away"
        var avRating: Double = place.rating
        avRating = floor(avRating * 2 + 0.5) / 2 //rounding to nearest .5
        RatingPulpsTextView.text = "\(avRating ) Pulps"
        
        
        
        backButton.layer.cornerRadius = 10
        backButton.titleEdgeInsets.left = 10
        backButton.titleEdgeInsets.right = 10
//        backButton.frame = CGRect(x: 0, y: view.frame.height/3.3, width: 100, height: 30)
        backButton.titleLabel?.font = UIFont(name: "Avenir-Light", size:view.frame.height/50)
        backButton.backgroundColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        backButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        backButton.addTarget(self, action: #selector(self.registerTapped(_:)), for: .touchUpInside)
        
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bgImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        bgImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        locationTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        locationTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80).isActive = true
        locationTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        locationTextView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        ExploreTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        ExploreTextView.topAnchor.constraint(equalTo: locationTextView.bottomAnchor).isActive = true
        ExploreTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        ExploreTextView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        locationImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        locationImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        locationImageView.topAnchor.constraint(equalTo: ExploreTextView.bottomAnchor).isActive = true
        locationImageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        PlaceNameTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        PlaceNameTextView.topAnchor.constraint(equalTo: locationImageView.bottomAnchor).isActive = true
        PlaceNameTextView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        PlaceNameTextView.heightAnchor.constraint(equalToConstant: 90).isActive = false
        
        PlaceDescriptionTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        PlaceDescriptionTextView.topAnchor.constraint(equalTo: PlaceNameTextView.bottomAnchor).isActive = true
        PlaceDescriptionTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        PlaceDescriptionTextView.heightAnchor.constraint(equalToConstant: 60).isActive = false
        
        DistanceTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        DistanceTextView.topAnchor.constraint(equalTo: PlaceDescriptionTextView.bottomAnchor).isActive = true
        DistanceTextView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        DistanceTextView.heightAnchor.constraint(equalToConstant: 40).isActive = false
        
        RatingPulpsTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 130).isActive = true
        RatingPulpsTextView.topAnchor.constraint(equalTo: DistanceTextView.bottomAnchor, constant: 10).isActive = true
        RatingPulpsTextView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        RatingPulpsTextView.heightAnchor.constraint(equalToConstant: 40).isActive = false
        
        Profile1ImageView.leftAnchor.constraint(equalTo: RatingPulpsTextView.rightAnchor, constant: 10).isActive = true
        Profile1ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        Profile1ImageView.topAnchor.constraint(equalTo: DistanceTextView.bottomAnchor, constant: 10).isActive = true
        Profile1ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Profile1ImageView.clipsToBounds = true
        Profile1ImageView.layer.cornerRadius = Profile1ImageView.frame.size.width / 2
        
        Profile2ImageView.leftAnchor.constraint(equalTo: Profile1ImageView.rightAnchor).isActive = true
        Profile2ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        Profile2ImageView.topAnchor.constraint(equalTo: DistanceTextView.bottomAnchor, constant: 10).isActive = true
        Profile2ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Profile2ImageView.clipsToBounds = true
        Profile2ImageView.layer.cornerRadius = Profile1ImageView.frame.size.width / 2
        
        Profile3ImageView.leftAnchor.constraint(equalTo: Profile2ImageView.rightAnchor).isActive = true
        Profile3ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        Profile3ImageView.topAnchor.constraint(equalTo: DistanceTextView.bottomAnchor, constant: 10).isActive = true
        Profile3ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Profile3ImageView.clipsToBounds = true
        Profile3ImageView.layer.cornerRadius = Profile1ImageView.frame.size.width / 2
        
        Profile4ImageView.leftAnchor.constraint(equalTo: Profile3ImageView.rightAnchor).isActive = true
        Profile4ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        Profile4ImageView.topAnchor.constraint(equalTo: DistanceTextView.bottomAnchor, constant: 10).isActive = true
        Profile4ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Profile4ImageView.clipsToBounds = true
        Profile4ImageView.layer.cornerRadius = Profile1ImageView.frame.size.width / 2
        
        
        
        AddReviewTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        AddReviewTextView.topAnchor.constraint(equalTo: AddReviewButton.bottomAnchor, constant: 10).isActive = true
        AddReviewTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        AddReviewTextView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        

        AddReviewButton.topAnchor.constraint(equalTo: RatingPulpsTextView.bottomAnchor, constant: 20).isActive = true
        AddReviewButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        AddReviewButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        AddReviewButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        AddReviewButton.addTarget(self, action: #selector(self.checkInTapped(_:)), for: .touchUpInside)
        
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
            imageView.loadImage(urlString: review.userImage ?? defaultURL)
            reviewText.text = review.body ?? ""
        }
    }
}


