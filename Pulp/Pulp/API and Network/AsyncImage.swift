//
//  AsyncImage.swift
//  Pulp
//
//  Created by Aryan Arora on 1/21/20.
//  Copyright © 2020 Aryan Arora. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject,AnyObject>()
class CustomImageView: UIImageView {
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style:UIActivityIndicatorView.Style.medium)
    
    func loadImage(urlString: String){
        let url = NSURL(string: urlString)
        image = nil
        addSpinner()
        
        if let task = task{
            task.cancel()
        }
        if let imageFromCache = imageCache.object(forKey: url?.absoluteString as AnyObject) as? UIImage{
            self.image = imageFromCache
            removeSpinner()
            return
        }
        
            
        
        task = URLSession.shared.dataTask(with: url as! URL){ (data,response,error) in
        guard let data = data,
            let newImage = UIImage(data: data)
            else {
                print("Couldn't load image ")
                return
            }
            imageCache.setObject(newImage, forKey: url?.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = newImage
                self.removeSpinner()
            }
        }
        task.resume()
            
    }
        
        
    func addSpinner() {
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    func removeSpinner(){
        spinner.removeFromSuperview()
    }
}

