//
//  LogIn.swift
//  Pulp
//
//  Created by Aryan Arora on 5/14/19.
//  Copyright © 2019 Aryan Arora. All rights reserved.
//
import Foundation
import SnapKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit

let loginDispatch = DispatchGroup()
class LogInController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if(AccessToken.current == nil)
        {
            print("not logged in")
        }
        else{
            //Below code sends token to local host 3000
            
            print("logged in already")
            let vc = MapScreen()
            //Below code performs a segue to another page
            self.present(vc, animated: true, completion: {
                print("You have logged in already!")
            })
        }
        view.backgroundColor = UIColor(rgb: 0xF7F7F7)
        setUpLoginButton()
        setUpAutoLayout()
    }
    
    private let loginContentView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let graphicView:UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Fruits"))
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let pulpLogo:UIImageView =
    {
        let imageName = "Pulp_Logo"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x:210, y: 80, width: 35, height: 35) //arbitrary x and y values, should be fixed
        return imageView
    }()
    
    private let welcomeTxt:UILabel = {
        
        let welcome = UILabel()
        welcome.text = "Get Started."
        welcome.textColor = .black
        welcome.font = UIFont(name: "Avenir-Black", size: 30)
        welcome.textAlignment = .left
        welcome.translatesAutoresizingMaskIntoConstraints = false
        welcome.numberOfLines = 0
        return welcome
    }()
    
    private let describeLabel:UILabel = {
        
        let txt = UILabel()
        txt.text = "Begin exploring \nexperiences with friends."
        txt.textColor = .gray
        txt.font = UIFont(name: "Avenir-MediumOblique", size: 20)
        txt.textAlignment = .left
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.numberOfLines = 0
        return txt
    }()
    
    let FBLoginButton : UIButton = {
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.setImage(UIImage(named: "Log In Button"), for: .normal)
        return myLoginButton
    }()
    
    func accessTokenGETRequest( accessToken: String)
    {
        
    }
    
    func setUpLoginButton()
    {
        FBLoginButton.addTarget(self, action: #selector(self.loginButtonClicked),  for: .touchUpInside)
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logOut()
        
        loginManager.logIn(permissions: [ .publicProfile, .email, .userFriends ], viewController: self, completion: { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, _):
                print("Logged in!")
                loginDispatch.enter()
                CreateUser()
                loginDispatch.notify(queue: .main) {
                print("Created User")
                LoggedIn = true
                let defaults = UserDefaults.standard
                defaults.set(LoggedIn, forKey: "login_key")
                defaults.synchronize()
                let vc = MapScreen()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: {
                    print("You have logged in successfully!")
                })
            }
            }
        }
        )
    }
    
        
    
    func setUpAutoLayout()
    {
        loginContentView.addSubview(welcomeTxt)
        loginContentView.addSubview(describeLabel)
        loginContentView.addSubview(FBLoginButton)
        loginContentView.addSubview(graphicView)
        loginContentView.addSubview(pulpLogo)
        
        view.addSubview(loginContentView)
        
        loginContentView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
            make.height.equalTo(view.frame.height/2)
            make.centerY.equalTo(view)
        }
        
        welcomeTxt.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(loginContentView).offset(80)
            make.left.equalTo(loginContentView).offset(20)
        }
        
        describeLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(welcomeTxt)
            make.top.equalTo(welcomeTxt.snp_bottomMargin).offset(20)
        }
        FBLoginButton.snp.makeConstraints({ (make) -> Void in
            make.width.equalTo(150)
            make.height.equalTo(60)
            make.top.equalTo(describeLabel.snp_bottomMargin).offset(60)
            make.left.equalTo(describeLabel)
        })
        
        graphicView.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(view)
            make.top.equalTo(view)
        }
    }
    
}

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
