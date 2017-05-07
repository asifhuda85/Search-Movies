//
//  Model.swift
//  Search Movie DB
//
//  Created by Md Asif Huda on 5/7/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import Foundation

class SafeJsonObject : NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercasedFirstChar = String(key.characters.first!).uppercased()
        let selectorStr = uppercasedFirstChar + key.substring(from: key.index(key.startIndex, offsetBy: 1))
        let selector = NSSelectorFromString("set\(selectorStr):")
        let responds = self.responds(to: selector)
        if !responds {
            return
        }
        super.setValue(value, forKey: key)
    }
    
}

// Inherit the SafeJsonObject class and override the setValue
class Movie : SafeJsonObject {
    
    var poster_path:    String?
    var overview:       String?
    var release_date:   String?
    var original_title: String?
    var title:          String?
    var backdrop_path:  String?
    var vote_average:   NSNumber?
    
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        self.setValuesForKeys(dictionary)
    }
    
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)

    }
    
}
