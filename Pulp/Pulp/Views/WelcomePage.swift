//
//  WelcomePageController.swift
//  Pulp
//
//  Created by Aryan Arora on 5/28/19.
//  Copyright © 2019 Aryan Arora. All rights reserved.
//

import UIKit

class WelcomePageController: UIViewController{

    let OpenerUp: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Home-1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let OpenerDown: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "Home-1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let Title: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "PulpTitle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(Title)
        view.addSubview(OpenerDown)
        view.addSubview(OpenerUp)
        
        setupLayout()
    }
    
    private func setupLayout() {
        OpenerUp.center = CGPoint(x: 270, y: view.bounds.height + 110)
        OpenerDown.center = CGPoint(x: 240, y: view.bounds.height + 10)
        
        Title.center = CGPoint(x: (view.bounds.width * 0.5), y: (view.bounds.height * 0.45))
        Title.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        OpenerUp.alpha = 1.0
        OpenerDown.alpha = 1.0

        UIView.animate(withDuration: 1.0, delay: 1, options: [.curveEaseInOut , .allowUserInteraction],
                animations: {
                    self.OpenerUp.center = CGPoint(x: 130, y: -50)
                    self.OpenerUp.transform = CGAffineTransform(rotationAngle: (.pi-0.5 ))
                    self.OpenerDown.center = CGPoint(x: 300, y: self.view.bounds.height + 70)
                    self.OpenerDown.transform = CGAffineTransform(rotationAngle: (-0.5))
        },
                       completion: { finished in
                        print("Animation Done")
                        let nextVC = LogInController()
                        self.present(nextVC, animated: true, completion: {
                            print("Changes to login_page successfully!")
                        })

        })
        
        
       
    }
}
