//
//  ViewController.swift
//  Pulp
//
//  Created by Katherine Miao on 2/27/19.
//  Copyright © 2019 Katherine Miao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let backgroundYellow = UIColor(red:1.00, green:0.97, blue:0.84, alpha:1.0)
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "profileKatMiao"))
        // enable autolayout for profileImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let profileDescriptionView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Katherine Miao", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)])
        attributedText.append(NSAttributedString(string: "\n\nAge: 19\nGender: Female\nLocation: Los Angeles, CA", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
 
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundYellow
        view.addSubview(profileDescriptionView)
        setupLayout()
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
        profileDescriptionView.backgroundColor = backgroundYellow
    }

}

