//
//  LogInController.swift
//  Pulp
//
//  Created by Andy Cai on 4/17/19.
//  Copyright © 2019 Katherine Miao. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


class LogInController : UIViewController
{
    override func viewDidLoad() {
        view.backgroundColor = UIColor(rgb: 0xF7F7F7) /* #F7F7F7 */
        loginContentView.addSubview(pulpLogo)
        loginContentView.addSubview(welcomeTxt)
        loginContentView.addSubview(describeLabel)
        loginContentView.addSubview(unameLabel)
        loginContentView.addSubview(unameTxtField)
        loginContentView.addSubview(pwordLabel)
        loginContentView.addSubview(pwordTxtField)
        loginContentView.addSubview(btnLogin)
        loginContentView.addSubview(createAcctLabel)
        view.addSubview(loginContentView)
        setUpAutoLayout()
    }
    private let loginContentView:UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .gray
        return view
    }()
    
    private let pulpLogo:UIImageView =
    {
        let imageName = "Pulp_Logo"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x:200, y: 30, width: 35, height: 35) //arbitrary x and y values, should be fixed
        return imageView
    }()
    
    private let welcomeTxt:UILabel = {
        
        let welcome = UILabel()
        welcome.text = "Get Started."
        welcome.textColor = .black
        //welcome.backgroundColor = .orange
        welcome.font = UIFont(name: "Avenir-Black", size: 30)
        welcome.textAlignment = .left
        welcome.translatesAutoresizingMaskIntoConstraints = false
        welcome.numberOfLines = 0
        return welcome
    }()
    
    private let describeLabel:UILabel = {
        
        let txt = UILabel()
        txt.text = "Enter your details and let \nthe journey begin."
        txt.textColor = .gray
        txt.font = UIFont(name: "Avenir-MediumOblique", size: 20)
        txt.textAlignment = .left
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.numberOfLines = 0
        return txt
    }()
    
    private let unameLabel:UILabel = {
        let label = UILabel()
        label.text = "Username or Email"
        label.font = UIFont(name: "Avenir-Book", size: UIFont.systemFontSize)
        label.font = label.font.withSize(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pwordLabel:UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont(name: "Avenir-Book", size: UIFont.systemFontSize)
        label.font = label.font.withSize(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let createAcctLabel: UILabel = {
       let label = UILabel()
        label.text = "Create an account"
        label.textColor = .gray
        label.font = UIFont(name: "Avenir-Book", size: UIFont.systemFontSize)
        label.font = label.font.withSize(18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let unameTxtField:UITextField = {
        let txtField = UITextField()
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.layer.cornerRadius = 12
        txtField.backgroundColor = .white
        txtField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        txtField.leftView = paddingView
        txtField.leftViewMode = .always
        return txtField
    }()
    
    private let pwordTxtField:UITextField = {
        let txtField = UITextField()
        txtField.layer.borderWidth = 1
        txtField.layer.borderColor = UIColor.black.cgColor
        txtField.layer.cornerRadius = 12
        txtField.backgroundColor = .white
        txtField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        txtField.leftView = paddingView
        return txtField
    }()
    
    let btnLogin:UIButton = {
        let btn = UIButton(type:.system)
        btn.backgroundColor = UIColor(rgb: 0x1479C9)
        btn.setTitle("Log in", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 18)
        btn.tintColor = .white
        btn.layer.cornerRadius = 12
        btn.clipsToBounds = true
//        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        btn.frame = CGRect(x: 0, y: 0, width: 5, height: 10)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private func setUpAutoLayout()
    {
        loginContentView.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 40).isActive = true
        loginContentView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: -40).isActive = true
        loginContentView.heightAnchor.constraint(equalToConstant: view.frame.height*1/2).isActive = true
        loginContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true //this line of code centers the view
        
        welcomeTxt.leftAnchor.constraint(equalTo: loginContentView.leftAnchor, constant: 20).isActive = true
        welcomeTxt.rightAnchor.constraint(equalTo: loginContentView.rightAnchor, constant: 20).isActive = true
        welcomeTxt.topAnchor.constraint(equalTo: loginContentView.topAnchor, constant: 20).isActive = true
        
        describeLabel.leftAnchor.constraint(equalTo: loginContentView.leftAnchor, constant: 20).isActive = true
        describeLabel.topAnchor.constraint(equalTo: welcomeTxt.topAnchor, constant: 45).isActive = true
        
        unameLabel.leftAnchor.constraint(equalTo: loginContentView.leftAnchor, constant: 20).isActive = true
        unameLabel.rightAnchor.constraint(equalTo: loginContentView.rightAnchor, constant: -20).isActive = true
        unameLabel.topAnchor.constraint(equalTo: describeLabel.bottomAnchor, constant: 15).isActive = true
        
        unameTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        unameTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-100).isActive = true
        unameTxtField.topAnchor.constraint(equalTo:unameLabel.bottomAnchor, constant:10).isActive = true
        unameTxtField.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        pwordLabel.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        pwordLabel.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-20).isActive = true
        pwordLabel.topAnchor.constraint(equalTo: unameTxtField.bottomAnchor, constant: 10).isActive = true
        
        pwordTxtField.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        pwordTxtField.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant:-100).isActive = true
        pwordTxtField.topAnchor.constraint(equalTo:pwordLabel.bottomAnchor, constant:10).isActive = true
        pwordTxtField.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        btnLogin.leftAnchor.constraint(equalTo:loginContentView.leftAnchor, constant:20).isActive = true
        btnLogin.rightAnchor.constraint(equalTo:loginContentView.rightAnchor, constant: -view.frame.width*1/2).isActive = true
        btnLogin.topAnchor.constraint(equalTo:pwordTxtField.bottomAnchor, constant:20).isActive = true
        
        createAcctLabel.leftAnchor.constraint(equalTo: loginContentView.leftAnchor, constant: 20).isActive=true
        createAcctLabel.topAnchor.constraint(equalTo: btnLogin.bottomAnchor, constant: 10).isActive = true
    }
}


