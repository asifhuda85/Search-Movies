//
//  UIImage+Extension.swift
//  Search Movie DB
//
//  Created by Md Asif Huda on 5/7/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import UIKit


let imgCache = NSCache<NSString, UIImage>() 

// Create UIImageView extension to do Lazy image download
extension UIImageView {
    
    func loadImageUsingCacheWith(urlString:String) {
        if let cacheImg = imgCache.object(forKey: urlString as NSString) {
            self.image = cacheImg
            return
        }
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, err) in
            if err != nil {
                return
            }
            DispatchQueue.main.async(execute: {
                if let downedImg = UIImage(data: data!) {
                    imgCache.setObject(downedImg, forKey: urlString as NSString)
                    self.image = downedImg
                }
            })
        }).resume()
        
    }
    
}
