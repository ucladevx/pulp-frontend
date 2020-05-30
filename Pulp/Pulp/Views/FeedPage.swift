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
//        collectionView?.backgroundColor = .white
        collectionView?.backgroundColor = UIColor.white.withAlphaComponent(0.0)
            
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
        userImage.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        userImage.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 10).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        userImage.layer.cornerRadius = 20;
        
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
        userName.translatesAutoresizingMaskIntoConstraints = false
        postTitle.font = UIFont(name: "Avenir Book", size: 20)
        postTitle.textColor = .orange
        postTitle.topAnchor.constraint(equalTo: userName.topAnchor, constant: 15).isActive = true
        postTitle.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        postTitle.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10).isActive = true
        userName.isEditable = false
        userName.isScrollEnabled = false
        
        
//        stackView.addSubview(placeType)
//        placeType.font = UIFont(name: "Avenir Book", size: 15)
//        placeType.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
//        placeType.backgroundColor = .white
//        placeType.translatesAutoresizingMaskIntoConstraints = false
//        placeType.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: -10).isActive = true
//        placeType.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
//        placeType.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10).isActive = true
//        placeType.isEditable = false
//        placeType.isScrollEnabled = false
        
        stackView.addSubview(postText)
        postText.font = UIFont(name: "Avenir Book", size: 15)
        postText.textColor = UIColor(red: 121/255, green: 121/255, blue: 121/255, alpha: 1)
        postText.backgroundColor = .white
        postText.translatesAutoresizingMaskIntoConstraints = false
        postText.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 10).isActive = true
        postText.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        postText.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 10).isActive = true
        postText.isEditable = false
        postText.isScrollEnabled = false
        postText.heightAnchor.constraint(equalToConstant: 100)
        
        stackView.addSubview(tagListRow)
        tagListRow.axis = .horizontal
        tagListRow.alignment = .leading
        tagListRow.distribution = .equalSpacing
        tagListRow.spacing = 5
        
        tagListRow.translatesAutoresizingMaskIntoConstraints = false
        tagListRow.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        tagListRow.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        tagListRow.topAnchor.constraint(equalTo: postText.bottomAnchor, constant: 10).isActive = true
        tagListRow.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
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
        
        
        
    }
    
    
    var post: Feed! {
    didSet{
            
        userImage.loadImage(urlString: post.userPhoto ?? defaultURL)
        userName.text = post.userName
        postTitle.text = "Checked into In N Out"
        postImage.loadImage(urlString: post.placeImage)
        
        for t in post.placeTags {
            let btn = UIButton(type: .custom)
            btn.setTitle(t, for: UIControl.State.normal)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.titleLabel?.font = UIFont(name: "Avenir-Light", size:30)
            btn.backgroundColor = UIColor(red: 249/255, green: 160/255, blue: 119/255, alpha: 1)
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.layer.cornerRadius = 15
            btn.contentEdgeInsets = UIEdgeInsets.init(top:5, left:10, bottom:5, right:10)
            tagList.append(btn)
        }
        
        for btn in tagList {
            tagListRow.addArrangedSubview(btn)
        }
//        var tag = ""
//        let tags = post.placeTags
//        for (i, t) in tags.enumerated(){
//            if (i == 2){
//                break
//            }
//            tag += t
//            if (i == 0){
//                tag += ", "
//            }
//        }
//        placeType.text = tag
        
        postText.text = post.reviewText
        }
    }
}
