//
//  DiveIn.swift
//  Pulp
//
//  Created by Katherine Miao on 4/22/19.
//  Copyright © 2019 Katherine Miao. All rights reserved.
//

import UIKit

class DiveIn: UIViewController {
    
    let backgroundOrange = UIColor(red:250/255, green:154/255, blue:70/255, alpha:1.0)
    
    let hikeImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Hike"))
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let museumImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Museum"))
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let festivalImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Festival"))
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let thrillImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Thrill"))
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let photoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Photo Op"))
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let animalImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Animal"))
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let landscapeImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Landscape"))
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let aquaticImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Aquatic"))
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Dive in.", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 50), NSAttributedStringKey.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "\nWhat are you looking for?", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 30), NSAttributedStringKey.foregroundColor: UIColor.white]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
        
    }()
    
    private let exploreButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Explore!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(openExploreView), for: .touchUpInside)
        return button
    }()
    
    @objc func openExploreView(){
        let exploreVC = ExploreViewController()
        present(exploreVC, animated: true, completion: nil)
    }
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundOrange
        setupBottomControls()
        setupLayout()
//        searchBar.searchBarStyle = UISearchBarStyle.prominent
//        searchBar.placeholder = " Search..."
//        searchBar.sizeToFit()
//        searchBar.isTranslucent = false
//        searchBar.backgroundImage = UIImage()
//        searchBar.delegate = self as? UISearchBarDelegate
//        navigationItem.titleView = searchBar
        //setupSearchBar()
        

    }
    
    fileprivate func setupBottomControls() {
        let bottomControlsStackView = UIStackView(arrangedSubviews: [exploreButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        let topConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 100)
        let leftConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 44)
        
        
        searchController.searchBar.addConstraint(heightConstraint)
        self.view.addSubview(searchController.searchBar)
        self.view.addConstraints([topConstraint, leftConstraint, rightConstraint])
    }
    
    private func setupLayout(){
        let topContainerView = UIView()
        view.addSubview(topContainerView)
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        topContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        topContainerView.addSubview(descriptionView)
        descriptionView.centerXAnchor.constraint(equalTo: topContainerView.centerXAnchor).isActive = true
        descriptionView.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        descriptionView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.5).isActive = true
        descriptionView.backgroundColor = backgroundOrange
        
        let searchController = UISearchController(searchResultsController: nil)
        let topConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 500)
        let leftConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: topContainerView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: topContainerView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: searchController.searchBar, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 44)

        searchController.searchBar.addConstraint(heightConstraint)
        self.view.addSubview(searchController.searchBar)
        self.view.addConstraints([topConstraint, leftConstraint, rightConstraint])


        let bottomContainerView = UIView()
        view.addSubview(bottomContainerView)
        bottomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomContainerView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        bottomContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        bottomContainerView.addSubview(hikeImageView)
        hikeImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -150).isActive = true
        hikeImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 100).isActive = true
        hikeImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        bottomContainerView.addSubview(museumImageView)
        museumImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -50).isActive = true
        museumImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 100).isActive = true
        museumImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        bottomContainerView.addSubview(festivalImageView)
        festivalImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: 50).isActive = true
        festivalImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 100).isActive = true
        festivalImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        bottomContainerView.addSubview(thrillImageView)
        thrillImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: 150).isActive = true
        thrillImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 100).isActive = true
        thrillImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        bottomContainerView.addSubview(photoImageView)
        photoImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -150).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 200).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        bottomContainerView.addSubview(animalImageView)
        animalImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: -50).isActive = true
        animalImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 200).isActive = true
        animalImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        bottomContainerView.addSubview(landscapeImageView)
        landscapeImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: 50).isActive = true
        landscapeImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 200).isActive = true
        landscapeImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        bottomContainerView.addSubview(aquaticImageView)
        aquaticImageView.centerXAnchor.constraint(equalTo: bottomContainerView.centerXAnchor, constant: 150).isActive = true
        aquaticImageView.centerYAnchor.constraint(equalTo: bottomContainerView.topAnchor, constant: 200).isActive = true
        aquaticImageView.heightAnchor.constraint(equalTo: topContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
    }

    
}


