//
//  ViewController.swift
//  Pulp
//
//  Created by Katherine Miao on 2/27/19.
//  Copyright © 2019 Katherine Miao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //let backgroundYellow = UIColor(red:1.00, green:0.97, blue:0.84, alpha:1.0)
    let backgroundOrange = UIColor(red:250/255, green:154/255, blue:70/255, alpha:1.0)

    
    let profileImageView: UIImageView = {
        let image = UIImage(named: "profileKatMiao")
        let imageView = UIImageView(image: image)
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let profileDescriptionView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Katherine Miao", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedText.append(NSAttributedString(string: "\n\nAge: 19\nGender: Female\nLocation: Los Angeles, CA", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: UIColor.white]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
 
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        return button
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
    
    private let diveInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Dive in!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(openDiveIn), for: .touchUpInside)
        return button
    }()
    
    @objc func openDiveIn(){
        let diveInVC = DiveIn()
        present(diveInVC, animated: true, completion: nil)
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
        view.addSubview(profileDescriptionView)
        setupBottomControls()
        setupLayout()
    }
    
    fileprivate func setupBottomControls() {
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [exploreButton, diveInButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            //            previousButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
 
    }
    
    private func setupLayout(){
        let topImageContainerView = UIView()
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        profileDescriptionView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        profileDescriptionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        profileDescriptionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        profileDescriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        profileDescriptionView.backgroundColor = backgroundOrange
    }

}

