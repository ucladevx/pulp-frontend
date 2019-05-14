//
//  ExploreViewController.swift
//  Pulp
//
//  Created by Katherine Miao on 3/14/19.
//  Copyright © 2019 Katherine Miao. All rights reserved.
//

import UIKit

class ExploreViewController:UIViewController{
    
    let backgroundYellow = UIColor(red:1.00, green:0.97, blue:0.84, alpha:1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundYellow
        view.addSubview(exploreDescriptionView)
        setupLayout()
        setupBottomControls()
    }
    
    let exploreImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "diddyriese"))
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let exploreDescriptionView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Diddy Riese", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        attributedText.append(NSAttributedString(string: "\n\n6 of your friends checked in here: Jay M, Alissa N...\nServes cookies, brownies, and ice cream, a UCLA favorite!\n0.6 miles away, open until 12am", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
        
    }()
    
    private func setupLayout(){
        let topImageContainerView = UIView()
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.addSubview(exploreImageView)
        exploreImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        exploreImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        exploreImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        exploreDescriptionView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        exploreDescriptionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25).isActive = true
        exploreDescriptionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        exploreDescriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        exploreDescriptionView.backgroundColor = backgroundYellow
    }
    
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.lightGray
        button.setTitle("Back to profile!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(openProfileView), for: .touchUpInside)
        return button
    }()
    
    @objc func openProfileView(){
        let profileVC = ViewController()
        present(profileVC, animated: true, completion: nil)
    }
    
    fileprivate func setupBottomControls() {
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [profileButton])
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

}
