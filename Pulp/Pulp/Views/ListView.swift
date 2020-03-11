//
//  ListViewController.swift
//  Pulp
//
//  Created by Aryan Arora on 5/30/19.
//  Copyright © 2019 Aryan Arora. All rights reserved.
//

import UIKit

let yelpReviewDispatchGroup = DispatchGroup()

class ListView_Controller: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView?
    var searchTerm: String?
    let cellId = "Example Cell"
    let cellSpacing:CGFloat = 10
    var locations: [Place] = YelpSearch
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("<", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupList()
        
        
    }
    @objc public func checkoutTapped(_ sender: UIButton) {
        impact.impactOccurred()
     let nextVC = Explore_Controller()
        nextVC.isDatabasePlace = YelpSearch[sender.tag].isDatabase
        nextVC.selectedLocation = sender.tag
        nextVC.calledbyMap = false

        YelpPlaceID = YelpSearch[sender.tag].id
        
        yelpReviewDispatchGroup.enter()
        service.request(.YelpReview()) {(result) in
            switch result {
            case .success(let response):
                let save = try? JSONDecoder().decode(Reviews.self, from: response.data)
                
                let defRev = [NewReview(text: "", rating: 0)]
                
                for review in save?.reviews ?? defRev{
                    var rev = Review(postedBy: nil, userImage: nil, body: review.text, rating: review.rating)
                    YelpSearch[sender.tag].reviews.append(rev);
                }
                yelpReviewDispatchGroup.leave()
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
        yelpReviewDispatchGroup.notify(queue: .main){
            self.present(nextVC, animated: true, completion: {
                print("Changes to explore page successfully!")
            })
        }
        
        
    }
    
    func YelpReviewFunction(id: Int){
        
        service.request(.YelpReview()) {(result) in
            switch result {
            case .success(let response):
                let save = try? JSONDecoder().decode(Reviews.self, from: response.data)
                
                let defRev = [NewReview(text: "", rating: 0)]
                
                for review in save?.reviews ?? defRev{
                    //YelpReviews.append(review)
                    print("printing yelp review text")
                    print(review.text)
                    var rev = Review(postedBy: nil, userImage: nil, body: review.text, rating: review.rating)
                    YelpSearch[id].reviews.append(rev);
                    yelpReviewDispatchGroup.notify(queue: .main){
                        yelpReviewDispatchGroup
                    }
                    
                }
                
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
   
    @objc func goBacktoDive(_ sender: UIButton) {
        impact.impactOccurred()
        self.dismiss(animated: true, completion: {
            print("Changes to diveIn successfully!")
        })
    }
    
    private func setupList() {
            let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 0))
            view.addSubview(navigationBar)
            navigationBar.barStyle = UIBarStyle.black
        let placeType: UITextView = UITextView()
        view.addSubview(placeType)
        placeType.font = UIFont(name: "Avenir Next", size: 20)
        placeType.font = UIFont.boldSystemFont(ofSize: 30)
        placeType.textColor = .white
        placeType.text = "         Search Results"
        placeType.textAlignment = NSTextAlignment(rawValue: 0)!
        placeType.backgroundColor = UIColor(red: 54/255, green: 120/255, blue: 195/255, alpha: 1)
        placeType.translatesAutoresizingMaskIntoConstraints = false
        placeType.topAnchor.constraint(equalTo: navigationBar.bottomAnchor).isActive = true
        placeType.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        placeType.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        placeType.heightAnchor.constraint(equalToConstant: 55 ).isActive = true
        placeType.isEditable = false
        placeType.isScrollEnabled = false
        
        view.addSubview(backButton)
        backButton.layer.cornerRadius = 10
        backButton.titleEdgeInsets.left = 10
        backButton.titleEdgeInsets.right = 10
        //        backButton.frame = CGRect(x: 0, y: view.frame.height/3.3, width: 100, height: 30)
        backButton.titleLabel?.font = UIFont(name: "Avenir-Light", size:view.frame.height/50)
        backButton.backgroundColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.centerYAnchor.constraint(equalTo: placeType.centerYAnchor).isActive = true
        backButton.leftAnchor.constraint(equalTo: placeType.leftAnchor).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 130).isActive = false
        backButton.addTarget(self, action: #selector(self.goBacktoDive(_:)), for: .touchUpInside)
    
    
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
            collectionView?.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(collectionView!)
            
            collectionView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            collectionView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            collectionView?.topAnchor.constraint(equalTo: placeType.bottomAnchor).isActive = true
            collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            collectionView?.backgroundColor = .white
            
            let collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            collectionViewFlowLayout.minimumInteritemSpacing = 20
            collectionViewFlowLayout.minimumLineSpacing = 0
            
            collectionView?.register(LocationCollectionCell.self, forCellWithReuseIdentifier: cellId)
            collectionView?.delegate = self
            collectionView?.dataSource = self
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return locations.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LocationCollectionCell
            cell.layer.borderWidth = 1.0;
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.autolayoutCell()
            cell.location = locations[indexPath.row]
            cell.checkOutButton.addTarget(self, action: #selector(checkoutTapped(_:)), for: .touchUpInside)
            cell.checkOutButton.tag = indexPath.row
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.bounds.width , height: 200)
        }
}


class LocationCollectionCell: UICollectionViewCell{
    var stackView: UIStackView = UIStackView()
    var placeImage: CustomImageView = CustomImageView()
    var placeName: UITextView = UITextView()
    var placeLocation: UITextView = UITextView()
    var placeType: UITextView = UITextView()
    var placeRating: UITextView = UITextView()
    var profile1ImageView: UIImageView = UIImageView()
    var profile2ImageView: UIImageView = UIImageView()
    var profile3ImageView: UIImageView = UIImageView()
    var profile4ImageView: UIImageView = UIImageView()
    let checkOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func autolayoutCell() {
        self.backgroundColor = .white
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.backgroundColor = .white
        stackView.addSubview(placeImage)
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        placeImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
        placeImage.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        placeImage.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        placeImage.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        stackView.addSubview(placeName)
        placeName.font = UIFont(name: "Avenir Book", size: 20)
        placeName.textColor = .black
        placeName.backgroundColor = .white
        placeName.font = UIFont.boldSystemFont(ofSize: 20)
        placeName.translatesAutoresizingMaskIntoConstraints = false
        placeName.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 15).isActive = true
        placeName.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        placeName.leftAnchor.constraint(equalTo: placeImage.rightAnchor, constant: 10).isActive = true
        placeName.isEditable = false
        placeName.isScrollEnabled = false
        
        stackView.addSubview(placeLocation)
        placeLocation.font = UIFont(name: "Avenir Book", size: 15)
        placeLocation.backgroundColor = .white
        placeLocation.font = UIFont.italicSystemFont(ofSize: 15)
        placeLocation.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        placeLocation.translatesAutoresizingMaskIntoConstraints = false
        placeLocation.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: -10).isActive = true
        placeLocation.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        placeLocation.leftAnchor.constraint(equalTo: placeImage.rightAnchor, constant: 10).isActive = true
        placeLocation.isEditable = false
        placeLocation.isScrollEnabled = false
        
        stackView.addSubview(placeType)
        placeType.font = UIFont(name: "Avenir Book", size: 15)
        placeType.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        placeType.backgroundColor = .white
        placeType.translatesAutoresizingMaskIntoConstraints = false
        placeType.topAnchor.constraint(equalTo: placeLocation.bottomAnchor, constant: -10).isActive = true
        placeType.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        placeType.leftAnchor.constraint(equalTo: placeImage.rightAnchor, constant: 10).isActive = true
        placeType.isEditable = false
        placeType.isScrollEnabled = false
        
        stackView.addSubview(placeRating)
        placeRating.font = UIFont(name: "Avenir Book", size: 15)
        placeRating.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        placeRating.backgroundColor = .white
        placeRating.translatesAutoresizingMaskIntoConstraints = false
        placeRating.topAnchor.constraint(equalTo: placeType.bottomAnchor, constant: -10).isActive = true
        placeRating.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        placeRating.leftAnchor.constraint(equalTo: placeImage.rightAnchor, constant: 10).isActive = true
        placeRating.isEditable = false
        placeRating.isScrollEnabled = false
        
        stackView.addSubview(profile1ImageView)
        profile1ImageView.translatesAutoresizingMaskIntoConstraints = false
        profile1ImageView.leftAnchor.constraint(equalTo: placeImage.rightAnchor, constant: 20).isActive = true
        profile1ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        profile1ImageView.topAnchor.constraint(equalTo: placeRating.bottomAnchor, constant: -5).isActive = true
        profile1ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profile1ImageView.clipsToBounds = true
        profile1ImageView.layer.cornerRadius = profile1ImageView.frame.size.width / 2

        stackView.addSubview(profile2ImageView)
        profile2ImageView.translatesAutoresizingMaskIntoConstraints = false
        profile2ImageView.leftAnchor.constraint(equalTo: profile1ImageView.rightAnchor).isActive = true
        profile2ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        profile2ImageView.topAnchor.constraint(equalTo: placeRating.bottomAnchor, constant: -5).isActive = true
        profile2ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profile2ImageView.clipsToBounds = true
        profile2ImageView.layer.cornerRadius = profile2ImageView.frame.size.width / 2

        stackView.addSubview(profile3ImageView)
        profile3ImageView.translatesAutoresizingMaskIntoConstraints = false
        profile3ImageView.leftAnchor.constraint(equalTo: profile2ImageView.rightAnchor).isActive = true
        profile3ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        profile3ImageView.topAnchor.constraint(equalTo: placeRating.bottomAnchor, constant: -5).isActive = true
        profile3ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profile3ImageView.clipsToBounds = true
        profile3ImageView.layer.cornerRadius = profile3ImageView.frame.size.width / 2


        stackView.addSubview(profile4ImageView)
        profile4ImageView.translatesAutoresizingMaskIntoConstraints = false
        profile4ImageView.leftAnchor.constraint(equalTo: profile3ImageView.rightAnchor).isActive = true
        profile4ImageView.widthAnchor.constraint(equalToConstant:40).isActive = true
        profile4ImageView.topAnchor.constraint(equalTo: placeRating.bottomAnchor, constant: -5).isActive = true
        profile4ImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profile4ImageView.clipsToBounds = true
        profile4ImageView.layer.cornerRadius = profile4ImageView.frame.size.width / 2
        
        stackView.addSubview(checkOutButton)
        checkOutButton.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        checkOutButton.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        checkOutButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        checkOutButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        
    }
    
    
    var location: Place! {
    didSet{
            
            placeImage.loadImage(urlString: location.image ?? defaultURL)
            placeName.text = location.name
            var address = ""
            if ((location.address1) != "" && (location.address1) != nil){
                address += location.address1 ?? ""
                address += ", "
            }
            if ((location.address2) != "" && (location.address2) != nil ){
                address += location.address2 ?? ""
                address += ", "
            }
            address += location.city
            placeLocation.text = address
            var tag = ""
            let tags = location.tags
            for (i, t) in tags.enumerated(){
                if (i == 2){
                    break
                }
                tag += t
                if (i == 0){
                    tag += ", "
                }
                
            }
            placeType.text = tag
            let rating = location.rating
            placeRating.text = "\(rating) Rating !"
//            profile1ImageView.image = UIImage(named: location.fbfriends![0].imageName!)
//            profile2ImageView.image = UIImage(named: location.fbfriends![1].imageName!)
//            profile3ImageView.image = UIImage(named: location.fbfriends![2].imageName!)
//            profile4ImageView.image = UIImage(named: location.fbfriends![3].imageName!)
        }
    }
}
