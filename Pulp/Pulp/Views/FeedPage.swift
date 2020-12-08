//
//  FeedPage.swift
//  Pulp
//
//  Created by Aryan Arora on 5/10/20.
//  Copyright © 2020 Aryan Arora. All rights reserved.
//

import UIKit

let feedDispatchGroup = DispatchGroup()
var first = true
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
        btn.setTitle("Map >", for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 15
        btn.titleEdgeInsets.left = 10
        btn.titleEdgeInsets.right = 10
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = .zero
        btn.layer.shadowRadius = 5
        return btn
    }()
    
    let discoverText: UITextView = UITextView()
    let header: UIStackView = UIStackView()
    let discoverImage: UIImageView = UIImageView(image: UIImage(named: "Museum"))
    var userImage : CustomImageView = CustomImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .black
        view.backgroundColor = UIColor(patternImage: UIImage(named: "FeedBackground")!)
        
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

        

        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        header.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        header.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 160).isActive = true
        header.backgroundColor = .red
        
        header.addSubview(userImage)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        userImage.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 30).isActive = true
        userImage.topAnchor.constraint(equalTo: header.topAnchor, constant: 40).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImage.layer.cornerRadius = 25
        userImage.clipsToBounds = true
        userImage.loadImage(urlString: USER_Photo)
        
        header.addSubview(discoverText)
        discoverText.translatesAutoresizingMaskIntoConstraints = false
        discoverText.topAnchor.constraint(equalTo: header.topAnchor, constant: 90).isActive = true
        discoverText.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 30).isActive = true
        discoverText.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        discoverText.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        discoverText.isScrollEnabled = false
        discoverText.text = "Discover"
        discoverText.font = UIFont(name: "Avenir Next", size: 40)
        discoverText.textColor = .white
        discoverText.font = UIFont.boldSystemFont(ofSize: 40)
        discoverText.isEditable = false
        discoverText.isSelectable = false
       

        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView!)
            
        collectionView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 0).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView?.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        header.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -20 ).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: header.topAnchor, constant: 80 ).isActive = true
        backButton.addTarget(self, action: #selector(self.goBacktoMap(_:)) , for: .touchUpInside)
            
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView?.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.minimumInteritemSpacing = 20
        collectionViewFlowLayout.minimumLineSpacing = 50
            
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
            cell.post = locations[indexPath.row]
            //cell.checkOutButton.addTarget(self, action: #selector(checkoutTapped(_:)), for: .touchUpInside)
            //cell.checkOutButton.tag = indexPath.row
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: view.bounds.width-50 , height: 400)
        }
}


class FeedCollectionCell: UICollectionViewCell{
    var stackView: UIStackView = UIStackView()
    var userImage : CustomImageView = CustomImageView()
    var userName: UITextView = UITextView()
    var postTitle : UITextView = UITextView()
    var placeType: UITextView = UITextView()
    var postText: UITextView = UITextView()
    var postImage: CustomImageView = CustomImageView()
    var tagList = [UIButton]()
    var tagListRow : UIStackView = UIStackView()
    
    
    func autolayoutCell() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 30

        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.backgroundColor = .white
        
        stackView.addSubview(userImage)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        userImage.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 15).isActive = true
        userImage.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        userImage.layer.cornerRadius = 30
        userImage.clipsToBounds = true
        
        
        stackView.addSubview(userName)
        userName.font = UIFont(name: "Avenir Book", size: 20)
        userName.textColor = .black
        userName.backgroundColor = .white
        userName.font = UIFont.boldSystemFont(ofSize: 20)
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 15).isActive = true
        userName.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        userName.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10).isActive = true
        userName.isEditable = false
        userName.isScrollEnabled = false
        
        
        stackView.addSubview(postTitle)
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        postTitle.font = UIFont(name: "Avenir Book", size: 16)
        postTitle.textColor = .orange
        postTitle.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        postTitle.topAnchor.constraint(equalTo: userName.topAnchor, constant: 27).isActive = true
        postTitle.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        postTitle.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10).isActive = true
        postTitle.isEditable = false
        postTitle.isScrollEnabled = false

        stackView.addSubview(postText)
        postText.font = UIFont(name: "Avenir Book", size: 18)
        postText.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        postText.translatesAutoresizingMaskIntoConstraints = false
        postText.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10).isActive = true
        postText.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        postText.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10).isActive = true
        postText.heightAnchor.constraint(equalToConstant: 80).isActive = true
        postText.isEditable = false
        postText.isScrollEnabled = false
        
        stackView.addSubview(tagListRow)
        tagListRow.axis = .horizontal
        tagListRow.alignment = .leading
        tagListRow.distribution = .equalSpacing
        tagListRow.spacing = 20
        
        tagListRow.translatesAutoresizingMaskIntoConstraints = false
        tagListRow.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 7).isActive = true
        tagListRow.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 10).isActive = true
        tagListRow.heightAnchor.constraint(equalToConstant: 29).isActive = true
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        stackView.addSubview(postImage)
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        postImage.topAnchor.constraint(equalTo: tagListRow.bottomAnchor, constant: 10).isActive = true
        postImage.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        postImage.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        postImage.layer.cornerRadius = 30
        postImage.clipsToBounds = true
        
    }
    
    
    var post: Feed! {
    didSet{
            
        userImage.loadImage(urlString: post.userPhoto ?? USER_Photo)
        userName.text = post.userName
        postTitle.text = "Checked into " + post.placeName
        postImage.loadImage(urlString: post.placeImage)
        
        for t in post.placeTags {
            let btn = UIButton(type: .custom)
            btn.setTitle(t, for: UIControl.State.normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: "Avenir-Light", size:16)
            btn.backgroundColor = UIColor(red: 249/255, green: 160/255, blue: 119/255, alpha: 1)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.layer.cornerRadius = 15
            btn.contentEdgeInsets = UIEdgeInsets.init(top:5, left:10, bottom:5, right:10)
            tagList.append(btn)
        }

        for btn in tagList {
            tagListRow.addArrangedSubview(btn)
            print("test")
        }
        first = false
        postText.text = post.reviewText
        }
    }
}
