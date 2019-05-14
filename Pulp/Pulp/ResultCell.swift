//
//  ResultCell.swift
//  Pulp
//
//  Created by Katherine Miao on 3/14/19.
//  Copyright © 2019 Katherine Miao. All rights reserved.
//

import UIKit
class ProductCell : UITableViewCell {
    
    struct Result{
        var resultName: String
        var resultImage: UIImage
        var resultDesc: String
    }
    
    var result : Result? {
        didSet {
            resultImage.image = result?.resultImage
            resultNameLabel.text = result?.resultName
            resultDescriptionLabel.text = result?.resultDesc
        }
    }
    
    private let resultNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let resultDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let decreaseButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "downvote"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    
    private let increaseButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "upvote"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()
    var productQuantity : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "1"
        label.textColor = .black
        return label
        
    }()
    
    @objc func decreaseFunc() {
        changeQuantity(by: -1)
    }
    
    @objc func increaseFunc() {
        changeQuantity(by: 1)
    }
    
    
    func changeQuantity(by amount: Int) {
        var quality = Int(productQuantity.text!)!
        quality += amount
        /*
        if quality < minValue {
            quality = 0
            productQuantity.text = "0"
        } else {
            productQuantity.text = "\(quality)"
        }
        delegate?.decreaseNumber(cell: self, number: quality)
 */
        
    }
    
    private let resultImage : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "diddyriese"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(resultImage)
        addSubview(resultNameLabel)
        addSubview(resultDescriptionLabel)
        addSubview(decreaseButton)
        addSubview(productQuantity)
        addSubview(increaseButton)
        /*
        resultImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        resultNameLabel.anchor(top: topAnchor, left: resultImage.rightAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        resultDescriptionLabel.anchor(top: resultNameLabel.bottomAnchor, left: resultImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
        
        let stackView = UIStackView(arrangedSubviews: [decreaseButton,productQuantity,increaseButton])
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: resultNameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 10, width: 0, height: 70, enableInsets: false)
        */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
