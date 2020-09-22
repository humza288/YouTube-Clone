//
//  Extensions.swift
//  youtube
//
//  Created by Humza Munir on 9/17/20.
//  Copyright © 2020 Humza Munir. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
         addConstraints(NSLayoutConstraint.constraints( withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

let imageCache = NSCache<NSString, UIImage>()


class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageFromUrl(urlString: String) {
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)!
               
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
       
            if error != nil {
               print(error as Any)
               return
            }
            
            if let image = imageCache.object(forKey: urlString as NSString) {
                DispatchQueue.main.async{
                    self.image = image
                    return
                }
            }
           
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
            }
            
       }).resume()
    }
}

extension UIImageView {
    
}
