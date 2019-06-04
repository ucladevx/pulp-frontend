//
//  ExploreController.swift
//  Pulp
//
//  Created by Aryan Arora on 5/20/19.
//  Copyright © 2019 Aryan Arora. All rights reserved.
//
import UIKit

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
    var reviews: [Review] = reviewData
    
    
    let bgImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Wave_Explore"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let locationImageView: UIImageView = {
        let imageView = UIImageView()
        var image = locationData[0].placeImage
        imageView.image = UIImage(named: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let locationTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 20/255, green: 121/255, blue: 201/255, alpha: 1)
        textView.text = locationData[0].placeCityState
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
        textView.text = locationData[0].placeName
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir Book", size: 30)
        textView.font = UIFont.boldSystemFont(ofSize: 30)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let PlaceDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = locationData[0].placeDescription
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir Book", size: 15)
        textView.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let DistanceOpenTextView: UITextView = {
        let textView = UITextView()
        var distance = locationData[0].placeDistance
        var hours = locationData[0].placeHours
        textView.text = "\(distance ?? 0) miles away  Open \(hours ?? 0) hrs"
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir Book", size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
    }()
    let RatingPulpsTextView:UITextView = {
        let textView = UITextView()
        var avRating = locationData[0].placeRating
        textView.text = "\(avRating ?? 0) Pulps"
        textView.isEditable = false
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
         textView.text = "Spilling the juice..."
        textView.font = UIFont(name: "Avenir Book", size: 20)
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isScrollEnabled = false
        return textView
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
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
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
        contentView.addSubview(DistanceOpenTextView)
        contentView.addSubview(RatingPulpsTextView)
        contentView.addSubview(Profile1ImageView)
        contentView.addSubview(Profile2ImageView)
        contentView.addSubview(Profile3ImageView)
        contentView.addSubview(Profile4ImageView)
        contentView.addSubview(AddReviewTextView)
        
        
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
        PlaceNameTextView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        PlaceDescriptionTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        PlaceDescriptionTextView.topAnchor.constraint(equalTo: PlaceNameTextView.bottomAnchor).isActive = true
        PlaceDescriptionTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        PlaceDescriptionTextView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        DistanceOpenTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        DistanceOpenTextView.topAnchor.constraint(equalTo: PlaceDescriptionTextView.bottomAnchor).isActive = true
        DistanceOpenTextView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        DistanceOpenTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        RatingPulpsTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 130).isActive = true
        RatingPulpsTextView.topAnchor.constraint(equalTo: DistanceOpenTextView.bottomAnchor, constant: 10).isActive = true
        RatingPulpsTextView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        RatingPulpsTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        Profile1ImageView.leftAnchor.constraint(equalTo: RatingPulpsTextView.rightAnchor, constant: 10).isActive = true
        Profile1ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        Profile1ImageView.topAnchor.constraint(equalTo: DistanceOpenTextView.bottomAnchor, constant: 10).isActive = true
        Profile1ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Profile1ImageView.clipsToBounds = true
        Profile1ImageView.layer.cornerRadius = Profile1ImageView.frame.size.width / 2
        
        Profile2ImageView.leftAnchor.constraint(equalTo: Profile1ImageView.rightAnchor).isActive = true
        Profile2ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        Profile2ImageView.topAnchor.constraint(equalTo: DistanceOpenTextView.bottomAnchor, constant: 10).isActive = true
        Profile2ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Profile2ImageView.clipsToBounds = true
        Profile2ImageView.layer.cornerRadius = Profile1ImageView.frame.size.width / 2
        
        Profile3ImageView.leftAnchor.constraint(equalTo: Profile2ImageView.rightAnchor).isActive = true
        Profile3ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        Profile3ImageView.topAnchor.constraint(equalTo: DistanceOpenTextView.bottomAnchor, constant: 10).isActive = true
        Profile3ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Profile3ImageView.clipsToBounds = true
        Profile3ImageView.layer.cornerRadius = Profile1ImageView.frame.size.width / 2
        
        Profile4ImageView.leftAnchor.constraint(equalTo: Profile3ImageView.rightAnchor).isActive = true
        Profile4ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        Profile4ImageView.topAnchor.constraint(equalTo: DistanceOpenTextView.bottomAnchor, constant: 10).isActive = true
        Profile4ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Profile4ImageView.clipsToBounds = true
        Profile4ImageView.layer.cornerRadius = Profile1ImageView.frame.size.width / 2
        
        
        
        AddReviewTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        AddReviewTextView.topAnchor.constraint(equalTo: RatingPulpsTextView.bottomAnchor, constant: 25).isActive = true
        AddReviewTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        AddReviewTextView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    
    private func setupReviews() {
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView!)
        
        collectionView?.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        collectionView?.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: AddReviewTextView.leadingAnchor).isActive = true
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
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewCollectionCell
        cell.autolayoutCell()
        cell.review = reviews[indexPath.row]
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
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut eni"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
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
    
    

}

class ReviewCollectionCell: UICollectionViewCell {
    var stackView: UIStackView = UIStackView()
    var imageView: UIImageView = UIImageView()
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
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
    }
    
    var review: Review! {
        didSet{
            imageView.image = UIImage(named: review.imageName!)
            reviewText.text = review.text ?? ""
        }
    }
}
