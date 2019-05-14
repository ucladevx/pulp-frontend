//
//  CreateProfileViewController.swift
//  Pulp
//
//  Created by Ryan Lam on 4/22/19.
//  Copyright © 2019 Andy Cai. All rights reserved.
//

import UIKit

class SelectInterestController: UIViewController {
    
    private let contentView:UIView = {
        let view = UIView()
        //view.backgroundColor = .green
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
        view.text = "What floats \nyour boat?"
        view.textColor = .black
        //view.backgroundColor = .orange
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        return view
    }()
    
    private let describeLabel:UILabel = {
        let label = UILabel()
        label.text = "Choose your top three interests"
        label.textColor = .gray
        //label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        contentView.addSubview(welcomeTxt)
        contentView.addSubview(describeLabel)
        
        view.addSubview(buttonView)
        view.addSubview(contentView)
        setUpAutoLayout()
    }
    
    func setUpAutoLayout() {
        
        contentView.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 40).isActive = true
        contentView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: -40).isActive = true
        contentView.topAnchor.constraint(equalTo:view.topAnchor, constant:view.frame.height/8).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        welcomeTxt.topAnchor.constraint(equalTo:contentView.topAnchor).isActive = true
        welcomeTxt.leftAnchor.constraint(equalTo:contentView.leftAnchor).isActive = true
        welcomeTxt.rightAnchor.constraint(equalTo:contentView.rightAnchor).isActive = true
        welcomeTxt.heightAnchor.constraint(equalToConstant: view.frame.height/4.5).isActive = true
        welcomeTxt.font = UIFont(name: "Avenir-Black", size: view.frame.height/23)
        
        
        describeLabel.topAnchor.constraint(equalTo:welcomeTxt.bottomAnchor).isActive = true;
        describeLabel.leftAnchor.constraint(equalTo:contentView.leftAnchor).isActive = true
        describeLabel.rightAnchor.constraint(equalTo:contentView.rightAnchor).isActive = true
        describeLabel.heightAnchor.constraint(equalToConstant:view.frame.height/30).isActive = true
        describeLabel.font = UIFont(name: "Avenir-Book", size: view.frame.height/50)
        
        
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
