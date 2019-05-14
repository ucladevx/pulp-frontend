//
//  LogInController.swift
//  Pulp
//
//  Created by Andy Cai on 5/14/19.
//  Copyright © 2019 Andy Cai. All rights reserved.
//

import Foundation
import FacebookLogin

class LogInController : UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = UIColor(rgb: 0xF7F7F7)
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }
    
    
}
