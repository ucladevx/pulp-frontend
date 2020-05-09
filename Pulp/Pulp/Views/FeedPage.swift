//
//  FeedPage.swift
//  Pulp
//
//  Created by Aryan Arora on 5/10/20.
//  Copyright © 2020 Aryan Arora. All rights reserved.
//

import UIKit

let feedDispatchGroup = DispatchGroup()

class FeedPage_Controller: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView?
    let cellId = "Example Cell"
    let cellSpacing:CGFloat = 10
    var locations: [Feed] = FeedPlaces
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("< Map", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        print(FeedPlaces)
        setupList()
        
        
    }
    @objc func goBacktoMap(_ sender: UIButton) {
        impact.impactOccurred()
        self.dismiss(animated: true, completion: {
            print("Changes to map successfully!")
        })
    }
    
    private func setupList() {
        
        let feedHead = UIImageView(image: #imageLiteral(resourceName: "FeedHead"))
        view.addSubview(feedHead)
        feedHead.translatesAutoresizingMaskIntoConstraints = false
        feedHead.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        feedHead.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        feedHead.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        feedHead.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.15).isActive = true
        
        feedHead.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leftAnchor.constraint(equalTo: feedHead.leftAnchor, constant: 30 ).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50 ).isActive = true
        backButton.addTarget(self, action: #selector(self.goBacktoMap(_:)) , for: .touchUpInside)
    
    
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView!)
            
        collectionView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: feedHead.bottomAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView?.backgroundColor = .white
            
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.minimumInteritemSpacing = 20
        collectionViewFlowLayout.minimumLineSpacing = 0
            
        collectionView?.register(FeedCollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return locations.count
        }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCollectionCell
            cell.layer.borderWidth = 1.0;
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.autolayoutCell()
            cell.location = locations[indexPath.row]
            //cell.checkOutButton.addTarget(self, action: #selector(checkoutTapped(_:)), for: .touchUpInside)
            //cell.checkOutButton.tag = indexPath.row
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.bounds.width , height: 200)
        }
}


class FeedCollectionCell: UICollectionViewCell{
    var stackView: UIStackView = UIStackView()
    var placeImage: CustomImageView = CustomImageView()
    var placeName: UITextView = UITextView()
    var placeType: UITextView = UITextView()
    var placeRating: UITextView = UITextView()
    
    
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
        
        stackView.addSubview(placeType)
        placeType.font = UIFont(name: "Avenir Book", size: 15)
        placeType.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        placeType.backgroundColor = .white
        placeType.translatesAutoresizingMaskIntoConstraints = false
        placeType.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: -10).isActive = true
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
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        
    }
    
    
    var location: Feed! {
    didSet{
            
        placeImage.loadImage(urlString: location.placeImage ?? defaultURL)
        placeName.text = location.placeName
        var tag = ""
        let tags = location.placeTags
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
        placeRating.text = location.reviewText
        }
    }
}
