//
//  LogInController.swift
//  Pulp
//
//  Created by Andy Cai on 5/14/19.
//  Copyright © 2019 Andy Cai. All rights reserved.
//

import Foundation
import FacebookLogin
import SnapKit

class LogInController : UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor(rgb: 0xF7F7F7)
        setUpLoginButton()

        view.addSubview(FBLoginButton)
        view.addSubview(graphicView)
        setUpAutoLayout()
        
//        if let accessToken = AccessToken.current {
//            // User is logged in, use 'accessToken' here.
//        }
    }
    
    private let graphicView:UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Fruits"))
    
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let FBLoginButton : UIButton = {
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.backgroundColor = UIColor.blue
        myLoginButton.layer.cornerRadius = 12
        myLoginButton.setTitle("My Login Button", for: .normal)
        
        return myLoginButton
    }()
    
    func setUpLoginButton()
    {
        FBLoginButton.addTarget(self, action: #selector(self.loginButtonClicked),  for: .touchUpInside)
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                print("Logged in!")
            }
        }
    }
    
    func setUpAutoLayout()
    {
        FBLoginButton.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(180)
            make.height.equalTo(40)
            make.center.equalTo(self.view)
        })
        
        graphicView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(view)
            make.top.equalTo(view)
        }
    }
    
}
