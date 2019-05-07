//
//  ViewController.swift
//  Discover Page
//
//  Created by Aryan Arora on 5/1/19.
//  Copyright © 2019 Aryan Arora. All rights reserved.
//
let cellID = "cellID"
import UIKit

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
       collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        navigationItem.title = "Daily Feed"
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellID)
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
        
    }
}

class FeedCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    let nameLabel : UILabel = {
    
//    }
    
    func setupViews() {
        backgroundColor = UIColor.white
    }
}
