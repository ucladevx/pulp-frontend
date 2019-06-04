//
//  WelcomePageController.swift
//  Pulp
//
//  Created by Michelle  Lam on 5/28/19.
//  Copyright © 2019 Michelle Lam. All rights reserved.
//

import UIKit

class WelcomePageController: UIViewController{
    let bgImageView: UIImageView = {
        let imageView = UIImageView(image:  #imageLiteral(resourceName: "Welcome Screen"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "pulp -"
        textView.textColor = UIColor(red: 20/255, green: 121/255, blue: 201/255, alpha: 1)
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir Black", size: 50)
        textView.font = UIFont.systemFont(ofSize: 50, weight: UIFont.Weight.heavy)
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    } ()
    
    //BOLD AND ITALIC FONT
    let taglineTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Curated experiences\nnearby."
        textView.textColor = .black
        textView.isEditable = false
        textView.font = UIFont(name: "Avenir Black", size: 20)
        textView.font = UIFont.italicSystemFont(ofSize: 20)
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    } ()
    
    let nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor(red:0.08, green:0.47, blue:0.79, alpha:1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //CONNECT CONTROLLERS THROUGH THE BUTTON
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(bgImageView)
        self.view.sendSubviewToBack(bgImageView)
        self.view.addSubview(titleTextView)
        self.view.addSubview(taglineTextView)
        self.view.addSubview(nextButton)
        
        setupLayout()
    }
    
    @objc func buttonClicked(sender: UIButton){
        let nextVC = LogInController()
        self.present(nextVC, animated: true, completion: {
            print("Changes to login_page successfully!")
        })
    }
    
    private func setupLayout() {
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        bgImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        bgImageView.widthAnchor.constraint(equalTo: self.view.heightAnchor, multiplier:0.57).isActive = true
        
        titleTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        titleTextView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        taglineTextView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 40).isActive = true
        taglineTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor).isActive = true
        taglineTextView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        taglineTextView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        nextButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -40).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
    }
}
