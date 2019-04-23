//
//  LogInController.swift
//  Pulp
//
//  Created by Andy Cai on 4/17/19.
//  Copyright © 2019 Katherine Miao. All rights reserved.
//

import Foundation
import UIKit


class LogInController : UIViewController
{
    private let loginContentView:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()

    private let unameTxtField:UITextField = {
        let txtField = UITextField()
        txtField.backgroundColor = .white
        txtField.borderStyle = .roundedRect
        return txtField
    }()

}


