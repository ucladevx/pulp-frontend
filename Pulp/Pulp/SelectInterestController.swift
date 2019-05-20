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
    
    private let graphicView:UIImageView = {
        let imageName = "Fruits"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        view.font = UIFont(name: "Avenir-Black", size: 30)
        return view
    }()
    
    private let nextButton:UIButton = {
        let button = UIButton()
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor(red:0.08, green:0.47, blue:0.79, alpha:1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let describeLabel: UILabel = {
        
        let label = UILabel()
        // String variable containing the text.
        let fullString = "Choose your top three interests"
        
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: fullString, attributes: [NSAttributedString.Key.font:UIFont(name: "Avenir-Medium", size: 18)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.orange, range: NSRange(location:16,length:5))
        label.attributedText = myMutableString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let divider : UIView = {
        let line = UIView()
        line.backgroundColor = .black
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        contentView.addSubview(welcomeTxt)
        contentView.addSubview(describeLabel)
        contentView.addSubview(divider)
        
        buttonView.addSubview(nextButton)
        
        view.addSubview(graphicView)
        view.addSubview(buttonView)
        view.addSubview(contentView)
        setUpAutoLayout()
    }
    
    func setUpAutoLayout() {
        graphicView.topAnchor.constraint(equalTo:view.topAnchor, constant: -view.frame.height/20).isActive = true
        graphicView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: view.frame.width/11).isActive = true
        graphicView.widthAnchor.constraint(equalToConstant:view.frame.width/1.1).isActive = true
        graphicView.heightAnchor.constraint(equalToConstant:view.frame.height/3.2).isActive = true
        
        
        contentView.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 40).isActive = true
        contentView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: -40).isActive = true
        contentView.topAnchor.constraint(equalTo:view.topAnchor, constant:view.frame.height/8).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        divider.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        divider.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        divider.topAnchor.constraint(equalTo: welcomeTxt.bottomAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        divider.widthAnchor.constraint(equalToConstant: 320).isActive = true
        
        welcomeTxt.topAnchor.constraint(equalTo:contentView.topAnchor).isActive = true
        welcomeTxt.leftAnchor.constraint(equalTo:contentView.leftAnchor).isActive = true
        welcomeTxt.rightAnchor.constraint(equalTo:contentView.rightAnchor).isActive = true
        welcomeTxt.heightAnchor.constraint(equalToConstant: view.frame.height/4.5).isActive = true
        
        describeLabel.topAnchor.constraint(equalTo:divider.bottomAnchor).isActive = true
        describeLabel.leftAnchor.constraint(equalTo:contentView.leftAnchor).isActive = true
        describeLabel.rightAnchor.constraint(equalTo:contentView.rightAnchor).isActive = true
        describeLabel.heightAnchor.constraint(equalToConstant:view.frame.height/30).isActive = true
        
        
        buttonView.heightAnchor.constraint(equalToConstant:view.frame.height/12).isActive = true
        buttonView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        buttonView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        nextButton.rightAnchor.constraint(equalTo:buttonView.rightAnchor, constant: -view.frame.width/20).isActive = true
        nextButton.centerYAnchor.constraint(equalTo:buttonView.centerYAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant:view.frame.height/20).isActive = true
        nextButton.titleLabel?.font = UIFont(name:"Avenir-Black", size: view.frame.height/50)

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
