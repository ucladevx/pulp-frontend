//
//  CreateProfileViewController.swift
//  Pulp
//
//  Created by Ryan Lam on 4/22/19.
//  Copyright © 2019 Katherine Miao. All rights reserved.
//

//NO LONGER CONTAINED IN MVP

import UIKit

class CreateProfileViewController: UIViewController {
    
    private let graphicView:UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Fruits.png"))
        //imageView.backgroundColor = .green
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let loginContentView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let welcomeTxt:UILabel = {
        
        let view = UILabel()
        view.text = "Tell us \nabout \nyourself."
        view.textColor = .black
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    
    private let nameTxtField:UITextField = {
        let txtField = UITextField()
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.backgroundColor = .white
        txtField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        txtField.leftView = paddingView
        txtField.leftViewMode = .always
        return txtField
    }()

    
    private let locationTxtField:UITextField = {
        let txtField = UITextField()
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.backgroundColor = .white
        txtField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        txtField.leftView = paddingView
        txtField.leftViewMode = .always
        return txtField
    }()
    
    private let genderTxtField:UITextField = {
        let txtField = UITextField()
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.backgroundColor = .white
        txtField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        txtField.leftView = paddingView
        txtField.leftViewMode = .always
        return txtField
    }()
    
    private let ageTxtField:UITextField = {
        let txtField = UITextField()
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.backgroundColor = .white
        txtField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        txtField.leftView = paddingView
        txtField.leftViewMode = .always
        return txtField
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .gray
        //label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLabel:UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.textColor = .gray
        //label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genderLabel:UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel:UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor(red:0.08, green:0.47, blue:0.79, alpha:1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        loginContentView.addSubview(welcomeTxt)
        loginContentView.addSubview(nameLabel)
        loginContentView.addSubview(nameTxtField)
        
        loginContentView.addSubview(ageLabel)
        loginContentView.addSubview(ageTxtField)
        
        loginContentView.addSubview(genderLabel)
        loginContentView.addSubview(genderTxtField)
        
        loginContentView.addSubview(locationLabel)
        loginContentView.addSubview(locationTxtField)
        
        buttonView.addSubview(nextButton)
        
        view.addSubview(graphicView)
        view.addSubview(buttonView)
        view.addSubview(loginContentView)
        setUpAutoLayout()
    }
    
    func setUpAutoLayout() {
    
        graphicView.topAnchor.constraint(equalTo:view.topAnchor, constant: -view.frame.height/20).isActive = true
        graphicView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: view.frame.width/11).isActive = true
        graphicView.widthAnchor.constraint(equalToConstant:view.frame.width/1.1).isActive = true
        graphicView.heightAnchor.constraint(equalToConstant:view.frame.height/3.2).isActive = true
        
        loginContentView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/6).isActive = true
        loginContentView.leftAnchor.constraint(equalTo:view.leftAnchor, constant: view.frame.width/4).isActive = true
        loginContentView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: -view.frame.width/4).isActive = true
        loginContentView.heightAnchor.constraint(equalToConstant:view.frame.height/1.6).isActive = true

        welcomeTxt.topAnchor.constraint(equalTo:loginContentView.topAnchor).isActive = true
        welcomeTxt.leftAnchor.constraint(equalTo:loginContentView.leftAnchor).isActive = true
        welcomeTxt.rightAnchor.constraint(equalTo:loginContentView.rightAnchor).isActive = true
        welcomeTxt.heightAnchor.constraint(equalToConstant: view.frame.height/4.5).isActive = true
        welcomeTxt.font = UIFont(name: "Avenir-Black", size: view.frame.height/23)

        
        nameLabel.topAnchor.constraint(equalTo:welcomeTxt.bottomAnchor).isActive = true;
        nameLabel.leftAnchor.constraint(equalTo:loginContentView.leftAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo:loginContentView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant:view.frame.height/30).isActive = true
        nameLabel.font = UIFont(name: "Avenir-Book", size: view.frame.height/50)

        
        nameTxtField.topAnchor.constraint(equalTo:nameLabel.bottomAnchor).isActive = true
        nameTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor).isActive = true
        nameTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor).isActive = true
        nameTxtField.heightAnchor.constraint(equalToConstant:view.frame.height/20).isActive = true
        nameTxtField.layer.cornerRadius = view.frame.height/70

        
        ageLabel.topAnchor.constraint(equalTo:nameTxtField.bottomAnchor, constant: view.frame.height/75).isActive = true;
        ageLabel.leftAnchor.constraint(equalTo:loginContentView.leftAnchor).isActive = true
        ageLabel.rightAnchor.constraint(equalTo:loginContentView.rightAnchor).isActive = true
        ageLabel.heightAnchor.constraint(equalToConstant:view.frame.height/30).isActive = true
        ageLabel.font = UIFont(name: "Avenir-Book", size: view.frame.height/50)


        ageTxtField.topAnchor.constraint(equalTo:ageLabel.bottomAnchor).isActive = true
        ageTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor).isActive = true
        ageTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor).isActive = true
        ageTxtField.heightAnchor.constraint(equalToConstant:view.frame.height/20).isActive = true
        ageTxtField.layer.cornerRadius = view.frame.height/70

        
        genderLabel.topAnchor.constraint(equalTo:ageTxtField.bottomAnchor, constant: view.frame.height/75).isActive = true;
        genderLabel.leftAnchor.constraint(equalTo:loginContentView.leftAnchor).isActive = true
        genderLabel.rightAnchor.constraint(equalTo:loginContentView.rightAnchor).isActive = true
        genderLabel.heightAnchor.constraint(equalToConstant:view.frame.height/30).isActive = true
        genderLabel.font = UIFont(name: "Avenir-Book", size: view.frame.height/50)

        
        genderTxtField.topAnchor.constraint(equalTo:genderLabel.bottomAnchor).isActive = true
        genderTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor).isActive = true
        genderTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor).isActive = true
        genderTxtField.heightAnchor.constraint(equalToConstant:view.frame.height/20).isActive = true
        genderTxtField.layer.cornerRadius = view.frame.height/70

        
        locationLabel.topAnchor.constraint(equalTo:genderTxtField.bottomAnchor, constant: view.frame.height/75).isActive = true;
        locationLabel.leftAnchor.constraint(equalTo:loginContentView.leftAnchor).isActive = true
        locationLabel.rightAnchor.constraint(equalTo:loginContentView.rightAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant:view.frame.height/30).isActive = true
        locationLabel.font = UIFont(name: "Avenir-Book", size: view.frame.height/50)

        
        locationTxtField.topAnchor.constraint(equalTo:locationLabel.bottomAnchor).isActive = true
        locationTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor).isActive = true
        locationTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor).isActive = true
        locationTxtField.heightAnchor.constraint(equalToConstant:view.frame.height/20).isActive = true
        locationTxtField.layer.cornerRadius = view.frame.height/70

        
        //nextButton.topAnchor.constraint(equalTo:loginContentView.bottomAnchor).isActive = true
        nextButton.rightAnchor.constraint(equalTo:buttonView.rightAnchor, constant: -view.frame.width/20).isActive = true
        nextButton.centerYAnchor.constraint(equalTo:buttonView.centerYAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant:view.frame.height/20).isActive = true
        nextButton.titleLabel?.font = UIFont(name:"Avenir-Black", size: view.frame.height/50)

        
        buttonView.heightAnchor.constraint(equalToConstant:view.frame.height/12).isActive = true
        buttonView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        buttonView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
